// contribute_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udayah/models/hr_emails.dart';
import 'package:udayah/provider/hr_emails.dart';
import 'package:udayah/styles/fonts.dart';
import 'package:udayah/styles/styles.dart';
import 'package:udayah/validators/validator.dart';
import 'package:udayah/widgets/alerts.dart';


class ContributeDialog extends StatefulWidget {
  final String addedBy; // Pass the added_by email

  const ContributeDialog({Key? key, required this.addedBy}) : super(key: key);

  @override
  _ContributeDialogState createState() => _ContributeDialogState();
}

class _ContributeDialogState extends State<ContributeDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<HrEmailProvider>(context, listen: false);
      final hrEmail = HrEmail(
        emailAddress: _emailController.text,
        companyName: _companyController.text,
        website: _websiteController.text,
        addedBy: widget.addedBy,
      );

      try {
        await provider.addHrEmail(hrEmail);
        // ShowCustomDialog(context, "Email added successfully!");
        // Show snackbar on success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Thanks for your contribution !" , style: AppTextStyles.regular,)),
        );
        Navigator.of(context).pop();
      } catch (e) {
        // Show snackbar on failure
         ShowCustomDialog(context, "Failed to add email: $e");

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Styles.brandBackgroundColor,
      title: Text('Contribute HR Email', style: AppTextStyles.regular, ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                style: AppTextStyles.regular,
                decoration: InputDecoration(labelText: 'HR Email',labelStyle: AppTextStyles.regular, ),
                validator: Validators.validateEmail,
              ),
              TextFormField(
                controller: _companyController,
                style: AppTextStyles.regular,
                decoration: InputDecoration(labelText: 'Company Name', labelStyle: AppTextStyles.regular),
                validator: Validators.validateCompanyName,
              ),
              TextFormField(
                controller: _websiteController,
                style: AppTextStyles.regular,
                decoration: InputDecoration(labelText: 'Website', labelStyle: AppTextStyles.regular),
                validator: Validators.validateWebsite,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel',style: AppTextStyles.regular,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Submit', style: AppTextStyles.regular,),
          onPressed: () => _submit(context),
        ),
      ],
    );
  }
}
