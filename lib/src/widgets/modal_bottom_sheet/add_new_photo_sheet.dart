import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:pryvee/config/ui_icons.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';

Future<void> showAddNewPhotoSheet(BuildContext context) async {
  final user = Provider.of<UserProvider>(context, listen: false);
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext builder) => StatefulBuilder(
      builder: (BuildContext buildContext, StateSetter setState) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(8.0),
              topLeft: const Radius.circular(8.0),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  height: 4.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                SizedBox(height: 8.0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    Navigator.of(context).pop();
                    var file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      String url =
                          await user.updateProfilePicAPI(File(file.path));
                      if (url == null) {
                        showToast(context,
                            "Error Occured while uploading profile pic");
                      }
                    }
                  },
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        UiIcons.safebox,
                        size: 16.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          "Gallery",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 14.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    Navigator.of(context).pop();
                    var file = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (file != null) {
                      String url =
                          await user.updateProfilePicAPI(File(file.path));
                      if (url == null) {
                        showToast(context,
                            "Error Occured while updating profile pic");
                      }
                    }
                  },
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        UiIcons.photo_camera,
                        size: 16.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          "Camera",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 14.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
