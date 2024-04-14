import 'dart:io';
import 'dart:typed_data';

import 'package:cash_ctrl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class ProfileCompletionProvider extends ChangeNotifier {
  File? file;

  Future<void> pickImage(BuildContext context,
      {ImageSource imageSource = ImageSource.gallery}) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      _editImage(File(pickedFile.path), context);
    } else {
      context.showSnackBar('No image was selected, please try again.');
    }
  }

  Future<void> _editImage(File image, BuildContext context) async {
    final editedImage = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: image,
        ),
      ),
    );
    if (editedImage is Uint8List) {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String filePath =
          '$dir/edited_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File editedFile = File(filePath);
      await editedFile.writeAsBytes(editedImage);
      file = editedFile;
      notifyListeners();
    }
  }
}
