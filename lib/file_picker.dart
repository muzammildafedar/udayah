import 'dart:io' as io;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:udayah/provider/mailer.dart';

Future<void> _pickResume(BuildContext context) async {
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
