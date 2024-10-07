import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udayah/provider/auth.dart'; // Ensure this is imported
import 'package:udayah/provider/smtp.dart';
import 'package:udayah/styles/fonts.dart';
import 'package:udayah/styles/styles.dart';
import 'package:udayah/widgets/category_box.dart';
import 'package:udayah/widgets/popups.dart';
  
class SmtpSetup extends StatefulWidget {
  const SmtpSetup({super.key});

  @override
  State<SmtpSetup> createState() => _SmtpSetupState();
}

class _SmtpSetupState extends State<SmtpSetup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _smtpServerController =
      TextEditingController(text: 'smtp.gmail.com');
  final TextEditingController _smtpPortController =
      TextEditingController(text: '587');
  final TextEditingController _smtpUsernameController = TextEditingController();
  final TextEditingController _smtpPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSmtpDetails();
  }

  @override
  void dispose() {
    _smtpServerController.dispose();
    _smtpPortController.dispose();
    _smtpUsernameController.dispose();
    _smtpPasswordController.dispose();
    super.dispose();
  }

  Future<void> _fetchSmtpDetails() async {
    final smtpProvider = Provider.of<SmtpProvider>(context, listen: false);
    final email = FirebaseAuth.instance.currentUser?.email;

    if (email != null) {
      final details = await smtpProvider.getSmtpDetails(email);
      if (details != null) {
        _smtpServerController.text = details['smtp_server'] ?? '';
        _smtpPortController.text = details['smtp_port'] ?? '';
        _smtpUsernameController.text = details['smtp_username'] ?? '';
        _smtpPasswordController.text = details['smtp_password'] ?? '';
      }
    }
  }

  void _submitForm(BuildContext context) {
    final smtpProvider = Provider.of<SmtpProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;

    if (_formKey.currentState!.validate()) {
      final String smtpServer = _smtpServerController.text;
      final String smtpPort = _smtpPortController.text;
      final String smtpUsername = _smtpUsernameController.text;
      final String smtpPassword = _smtpPasswordController.text;

      smtpProvider.storeSmtpDetails(
          email: user?.email,
          smtpServer: smtpServer,
          smtpPort: smtpPort,
          smtpUsername: smtpUsername,
          smtpPassword: smtpPassword,
          context: context);

      // Implement further logic if needed, such as navigating to another page
    }
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  String? _validatePort(String? value) {
    final String? notEmptyError = _validateNotEmpty(value, 'SMTP Port');
    if (notEmptyError != null) return notEmptyError;

    final int? port = int.tryParse(value!);
    if (port == null || port <= 0) {
      return 'Please enter a valid port number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CategoryBox(
            title: "Setup Your Email Using SMTP",
            suffix: null,
            children: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Styles.brandBackgroundColor, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0), // Padding
                  ),
                  child: const Text(
                    "Instructions",
                    style: AppTextStyles.regular,
                  ),
                  onPressed: () => ShowSmtpSetupDialog(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _smtpServerController,
                        labelText: 'SMTP Server',
                        validator: (value) =>
                            _validateNotEmpty(value, 'SMTP Server'),
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: _smtpPortController,
                        labelText: 'SMTP Port',
                        keyboardType: TextInputType.number,
                        validator: _validatePort,
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: _smtpUsernameController,
                        labelText: 'SMTP Username',
                        validator: (value) =>
                            _validateNotEmpty(value, 'SMTP Username'),
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: _smtpPasswordController,
                        labelText: 'SMTP Password',
                        obscureText: true,
                        validator: (value) =>
                            _validateNotEmpty(value, 'SMTP Password'),
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton.icon(
                        onPressed: () => _submitForm(context),
                        icon: const Icon(Icons.save, color: Colors.white,),
                        label: const Text(
                          'Save Settings',
                          style: AppTextStyles.regular,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Styles.brandBackgroundColor, // Button color
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 12.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: AppTextStyles.regularBlack,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
