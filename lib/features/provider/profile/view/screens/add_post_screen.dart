import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start/core/utils/helpers/pick_image.dart';
import 'package:start/features/Auth/view/widgets/custom_TextFormField.dart';
import 'package:start/features/provider/profile/bloc/mypost_bloc.dart';
import 'package:start/main.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? image;
  final formKey = GlobalKey<FormState>();
  List<File>? images = [];
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        print('image is null');
        return;
      }

      final ImageTemporary = File(image.path);
      setState(() => images!.add(ImageTemporary));
      // setState(() => this.image = ImageTemporary);
      print(image);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addpost),
      ),
      body: BlocListener<MypostBloc, MypostState>(
        listener: (context, state) {
          if (state is SuccessAddState) {
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...images!.map(
                        (image) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: image != null
                              ? DottedBorder(
                                  strokeWidth: 3,
                                  color:
                                      const Color.fromARGB(255, 142, 201, 84),
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      DottedBorder(
                        radius: const Radius.circular(
                          20,
                        ),
                        strokeWidth: 3,
                        color: const Color.fromARGB(255, 142, 201, 84),
                        child: InkWell(
                          splashColor: Colors.black12,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Chose one Option!',
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          pickImage(ImageSource.camera),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons.camera,
                                            color: Color.fromARGB(
                                                255, 143, 201, 101),
                                            size: 60,
                                          ),
                                          Text(
                                            'Camera',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          pickImage(ImageSource.gallery),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons.photo_album_outlined,
                                            color: Color.fromARGB(
                                                255, 143, 201, 101),
                                            size: 60,
                                          ),
                                          Text(
                                            'Gallery',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            width: 200,
                            height: 200,
                            child: image == null
                                ? const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.blueGrey,
                                  )
                                : Image.file(
                                    image!,
                                    width: 170,
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: () async {
                //     final source = await showPickerImageSheet(context);
                //     if (source != null) {
                //       File? image1 = await pickImage(context, source);
                //       if (image1 != null) {
                //         setState(() {
                //           image = image1;
                //         });
                //       }
                //     }
                //   },
                //   child: Center(
                //     child: ClipRRect(
                //         borderRadius: BorderRadius.circular(100.0),
                //         child: Container(
                //             width: 200,
                //             height: 50,
                //             color: Colors.red,
                //             child: Center(
                //                 child: Text(
                //                     AppLocalizations.of(context)!.addimage)))),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // if (image != null)
                //   SizedBox(
                //     height: 200,
                //     width: double.infinity,
                //     child: Image.file(
                //       image!,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                const Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          AppLocalizations.of(context)!.notes,
                          style: const TextStyle(),
                        )
                      ],
                    ),
                    controller: controller,
                    KeyboardTybe: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validatoruser: (value) {
                      if (value.toString().isEmpty) {
                        return AppLocalizations.of(context)!.notes;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<MypostBloc, MypostState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.lightGreen)),
                          onPressed: () {
                            final bool? isValid =
                                formKey.currentState?.validate();
                            FocusScope.of(context).unfocus();
                            if (images!.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .pleasepickanimage),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ));
                              return;
                            } else if (isValid!) {
                              formKey.currentState!.save();
                              BlocProvider.of<MypostBloc>(context).add(
                                  AddPostEvent(
                                      note: controller.text.trim(),
                                      image: images!));
                            }
                          },
                          child: state is LoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  AppLocalizations.of(context)!.addpost,
                                  style: const TextStyle(color: Colors.white),
                                ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
