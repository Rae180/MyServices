import 'package:flutter/material.dart';
import 'package:start/features/home/view/widgets/custom_TextFormField.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = 'SignupScreen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController? firstNameController = TextEditingController();
  final TextEditingController? lastNameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? phoneNumberController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? REpasswordController = TextEditingController();
  final TextEditingController? addressController = TextEditingController();
  String? SelectedGender;

  void onFieldSubmitted(String value) {}

  @override
  void dispose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    emailController?.dispose();
    phoneNumberController?.dispose();
    passwordController?.dispose();
    REpasswordController?.dispose();
    addressController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0x8fc965),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Join now to get Started!',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Create a new Account to connect with Providers!'),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' First Name',
                          style: TextStyle(),
                        )
                      ],
                    ),
                    controller: firstNameController,
                    KeyboardTybe: TextInputType.name,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' Last Name',
                        ),
                      ],
                    ),
                    controller: lastNameController,
                    KeyboardTybe: TextInputType.name,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' Email',
                        )
                      ],
                    ),
                    controller: emailController,
                    KeyboardTybe: TextInputType.emailAddress,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' Phone Number',
                        ),
                      ],
                    ),
                    controller: phoneNumberController,
                    KeyboardTybe: TextInputType.number,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' Password',
                        ),
                      ],
                    ),
                    controller: passwordController,
                    KeyboardTybe: TextInputType.visiblePassword,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.password_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' Confirm password',
                        ),
                      ],
                    ),
                    controller: REpasswordController,
                    KeyboardTybe: TextInputType.visiblePassword,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          ' Address',
                        ),
                      ],
                    ),
                    controller: addressController,
                    KeyboardTybe: TextInputType.name,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: const Color.fromARGB(14, 0, 0, 0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 20,
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: SelectedGender,
                      hint: const Text(
                        'Select Gender',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 143, 201, 101),
                      ),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          SelectedGender = newValue;
                        });
                      },
                      items: <String>['male', 'female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 120,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 143, 201, 101),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
