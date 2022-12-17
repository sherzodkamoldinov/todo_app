import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/data/repository/storage_repository.dart';
import 'package:todo_app/utils/utils.dart';

import '../utils/const.dart';

class UserProvider extends ChangeNotifier {
  String userName = '';
  File? userImageFile;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  changeUserName(String newUsername) async {
    await StorageRepository.putString(key: CustomFields.userName, value: newUsername);
    userName = newUsername;
    notify(false);
  }

  changeUserPassword(String newPassword) async {
    await StorageRepository.putString(key: CustomFields.userPassword, value: newPassword);
  }

  readLocale() {
    userName = StorageRepository.getString(CustomFields.userName);
    String imagePath = StorageRepository.getString(CustomFields.userImagePath);
    if (imagePath.isNotEmpty) {
      userImageFile = File(imagePath);
      notify(false);
    }
  }

  getUserImageFromGallery(BuildContext context) async {
    notify(true);
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userImageFile = File(pickedFile.path);
      await StorageRepository.putString(key: CustomFields.userImagePath, value: pickedFile.path);
    } else {
      CustomSnackbar.showSnackbar(context, 'Image is not selected', SnackbarType.warning);
    }

    notify(false);
  }

  getUserImageFromCamera(BuildContext context) async {
    notify(true);
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      userImageFile = File(pickedFile.path);
      await StorageRepository.putString(key: CustomFields.userImagePath, value: pickedFile.path);
    } else {
      CustomSnackbar.showSnackbar(context, 'Image is not selected', SnackbarType.warning);
    }

    notify(false);
  }

  notify(bool status) {
    _isLoading = status;
    notifyListeners();
  }
}
