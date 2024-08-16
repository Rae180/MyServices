import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/utils/helpers/pick_image.dart';
import 'package:start/features/provider/profile/bloc/profile_bloc.dart';
import 'package:start/features/provider/profile/model/profile_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserDetailsPage extends StatefulWidget {
  final ProfileModel userData;
  static const routeName = 'Profile_Details_Screen';

  const UserDetailsPage({super.key, required this.userData});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _birthDateController;
  late TextEditingController _genderController;
  late TextEditingController _statusController;
  late TextEditingController _hourlyRateController;
  late TextEditingController _jobDescriptionController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.userData.firstName);
    _lastNameController = TextEditingController(text: widget.userData.lastName);
    _emailController = TextEditingController(text: widget.userData.email);
    _phoneController = TextEditingController(text: widget.userData.phoneNum);
    _addressController =
        TextEditingController(text: widget.userData.mainAddress);
    _birthDateController =
        TextEditingController(text: widget.userData.birthDate);
    _genderController = TextEditingController(text: widget.userData.gender);
    _statusController = TextEditingController(text: widget.userData.status);
    _hourlyRateController =
        TextEditingController(text: widget.userData.hourlyRate.toString());
    _jobDescriptionController =
        TextEditingController(text: widget.userData.jobDescription);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    _statusController.dispose();
    _hourlyRateController.dispose();
    _jobDescriptionController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedUserData = ProfileModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phoneNum: _phoneController.text,
      mainAddress: _addressController.text,
      birthDate: _birthDateController.text,
      gender: _genderController.text,
      status: _statusController.text,
      hourlyRate: int.tryParse(_hourlyRateController.text),
      jobDescription: _jobDescriptionController.text,
    );

    BlocProvider.of<ProfileBloc>(context)
        .add(UpdateProfileEvent(profileModel: updatedUserData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is SuccessUpdateState) {
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        final source = await showPickerImageSheet(context);
                        if (source != null) {
                          File? image = await pickImage(context, source);
                          if (image != null) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(UpdateimageEvent(file: image));
                          }
                        }
                      },
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                            imageUrl: ApiConstants.STORAGE_URL +
                                widget.userData.image!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildEditableInfoRow(
                        AppLocalizations.of(context)!.firstname,
                        _firstNameController),
                    _buildEditableInfoRow(
                        AppLocalizations.of(context)!.lastname,
                        _lastNameController),
                    _buildEditableInfoRow(
                        AppLocalizations.of(context)!.email, _emailController),
                    _buildEditableInfoRow(
                        AppLocalizations.of(context)!.phonenumber,
                        _phoneController),
                    _buildEditableInfoRow(AppLocalizations.of(context)!.address,
                        _addressController),
                    _buildEditableInfoRow(
                        AppLocalizations.of(context)!.birthdaydate,
                        _birthDateController),
                    _buildEditableInfoRow(AppLocalizations.of(context)!.gender,
                        _genderController),
                    _buildEditableInfoRow(
                        AppLocalizations.of(context)!.hourlyrate,
                        _hourlyRateController),
                    _buildEditableJobDescriptionRow(
                        AppLocalizations.of(context)!.jobdescription,
                        _jobDescriptionController),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.status}: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.lightGreen,
                          ),
                        ),
                        Text(
                          _statusController.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableInfoRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.lightGreen,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableJobDescriptionRow(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.lightGreen,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: null,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
