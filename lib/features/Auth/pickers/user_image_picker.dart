import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagepickfn;

  const UserImagePicker({super.key, required this.imagepickfn});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile =
        await _picker.pickImage(source: src, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagepickfn(_pickedImage!);
    } else {
      print('No Image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_back_outlined,color: Color.fromARGB(255, 143, 201, 101),),
              label:  Text(
                '${AppLocalizations.of(context)!.addimage}\n ${AppLocalizations.of(context)!.fromcamera}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 143, 201, 101),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery,),
              icon: const Icon(Icons.image_outlined,color: Color.fromARGB(255, 143, 201, 101),),
              label:  Text(
                '${AppLocalizations.of(context)!.addimage}\n ${AppLocalizations.of(context)!.fromgallery}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 143, 201, 101),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
