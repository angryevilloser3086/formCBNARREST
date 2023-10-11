import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'custom_dialog.dart';

class GetImagePermission {
  late Permission permission;
  final String subHeading;

  GetImagePermission.gallery(
      {this.subHeading = 'Photos permission is needed to select photos'}) {
    if (Platform.isIOS || Platform.isAndroid) {
      permission = Permission.photos;
      permission = Permission.photosAddOnly;
      permission = Permission.storage;
    } else {
      permission = Permission.storage;
    }
  }

  GetImagePermission.camera(
      {this.subHeading = "Camera permission is needed to click photos"}) {
    if (Platform.isIOS || Platform.isAndroid) {
      permission = Permission.photos;
      permission = Permission.photosAddOnly;
      permission = Permission.camera;
      permission = Permission.microphone;
      permission = Permission.manageExternalStorage;
    } else {
      permission = Permission.camera;
    }
  }

  Future<bool> getPermission(BuildContext context) async {
    PermissionStatus permissionStatus = await permission.status;
    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context, subHeading);
      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return true;
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context, subHeading);

      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return true;
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context, subHeading);
      } else {
        permissionStatus = await permission.request();
      }

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return true;
      }
    }
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  _showOpenAppSettingsDialog(context, String subHeading) {
    return CustomDialog.show(
      context,
      'Permission needed',
      subHeading,
      'Open settings',
      openAppSettings,
    );
  }
}
