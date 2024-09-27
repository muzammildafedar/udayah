import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shippi/provider/companies.dart';
import 'package:shippi/provider/mailer.dart';
import 'package:shippi/styles/fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class EmailTemplates extends StatefulWidget {
  const EmailTemplates({Key? key}) : super(key: key);

  @override
  State<EmailTemplates> createState() => _EmailTemplatesState();
}

class _EmailTemplatesState extends State<EmailTemplates> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HtmlEditorController _htmlEditorController = HtmlEditorController();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _resumeUrl;
  bool _isLoading = true;
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    _fetchLatestResume();
  }

  Future<void> _fetchLatestResume() async {
    try {
      final fileProvider = Provider.of<EmailProvider>(context, listen: false);
      final url = await fileProvider.getLatestResumeUrl();
      if (mounted) {
        setState(() {
          _resumeUrl = url;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch resume: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      final fileName = result.files.single.name;

      if (kIsWeb) {
        // On web, access the bytes property
        final fileBytes = result.files.single.bytes;
        if (fileBytes != null) {
          // Handle file as bytes for web
          Provider.of<EmailProvider>(context, listen: false)
              .setSelectedFileName(fileName);
          Provider.of<EmailProvider>(context, listen: false)
              .setSelectedFileBytes(fileBytes);
          await Provider.of<EmailProvider>(context, listen: false).uploadFile();
        }
      } else {
        // On non-web platforms, access the path
        final filePath = result.files.single.path;
        if (filePath != null) {
          Provider.of<EmailProvider>(context, listen: false)
              .setSelectedFileName(fileName);
          Provider.of<EmailProvider>(context, listen: false)
              .setSelectedFilePath(filePath);
        }
      }
    }
  }

  void _submitForm(String stage) async {
    if (_formKey.currentState!.validate()) {
      final String subject = _subjectController.text;
      final String email = _emailController.text;
      final user = FirebaseAuth.instance.currentUser;

      final emailProvider = Provider.of<EmailProvider>(context, listen: false);
      final comapaiesProvider =
          Provider.of<CompaniesProvider>(context, listen: false);

      _htmlEditorController.getText().then((body) async {
        try {
          await emailProvider.sendEmail(
            to: stage == 'test' ? user!.email : comapaiesProvider.selectedEmail,
            subject: subject,
            body: body,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email sent successfully!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send email: $e')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final comapaiesProvider =
        Provider.of<CompaniesProvider>(context, listen: false);
    _emailController.text = comapaiesProvider.selectedEmail;
    return Consumer<EmailProvider>(builder: (context, data, child) {
      if (data.loading) {
        return Center(child: CircularProgressIndicator());
      }
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Send Email', style: AppTextStyles.regularBlack),
                      SizedBox(height: 16.0),
                      TextFormField(
                        style: AppTextStyles.regularBlack,
                        controller: _subjectController,
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.subject),
                        ),
                        validator: (value) =>
                            _validateNotEmpty(value, 'Subject'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        style: AppTextStyles.regularBlack,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) => _validateNotEmpty(value, 'Email'),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _pickResume,
                        child: AbsorbPointer(
                          child: Consumer<EmailProvider>(
                            builder: (context, provider, _) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: provider.selectedFileName == null
                                      ? 'Attach your resume'
                                      : 'Resume attached: ${provider.selectedFileName}',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: Icon(Icons.attach_file),
                                ),
                                validator: (value) {
                                  if (provider.selectedFileName == null) {
                                    return 'Please attach your resume.';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : _errorMessage != null
                              ? Text(_errorMessage!)
                              : _resumeUrl != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Latest Resume:',
                                          style: AppTextStyles.regularBlack,
                                        ),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            _launchURL(_resumeUrl!);
                                          },
                                          child: Text(
                                            'View Resume',
                                            style: AppTextStyles.regularBlack,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text('No resume found.',
                                      style: AppTextStyles.regularBlack),
                      SizedBox(height: 16.0),
                      Text('Email Content', style: AppTextStyles.regularBlack),
                      SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 300,
                        child: HtmlEditor(
                          controller: _htmlEditorController,
                          htmlEditorOptions: HtmlEditorOptions(
                            hint: 'Your email content here...',
                          ),
                          otherOptions: OtherOptions(
                            height: 400,
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _submitForm('test');
                              },
                              icon: Icon(Icons.send),
                              label: Text('Test'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical: 16.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _submitForm('none');
                              },
                              icon: Icon(Icons.send),
                              label: Text('Send Cold Email'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical: 16.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }
}

void _launchURL(String url) async {
  html.window.open(url, 'new tab');
}
