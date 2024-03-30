import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_string.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/shared/custom_vertical_sized_box.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController numberController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController wardController = TextEditingController();
final TextEditingController cityController = TextEditingController();

CollectionReference users = FirebaseFirestore.instance.collection('users');
FirebaseAuth auth = FirebaseAuth.instance;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);
  
  
  
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: kPrimaryColor,
              controller: emailController,
              validator: (value) {
                if (!RegExp(validationEmail).hasMatch(value!)) {
                  return 'Invalid Email';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Your Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.mail),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              cursorColor: kPrimaryColor,
              controller: passwordController,
              validator: (value) {
                if (value.toString().length < 6) {
                  return 'Password should be longer or equal to 6 characters';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Your Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            TextFormField(
              cursorColor: kPrimaryColor,
              controller: nameController,
              validator: (value) {
                if (value.toString().length <= 2 ||
                    !RegExp(validationName).hasMatch(value!)) {
                  return 'Enter valid Name';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Your Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            TextFormField(
              cursorColor: kPrimaryColor,
              controller: numberController,
              validator: (value) {
                if (value.toString().length <= 2) {
                  return 'Enter valid Number';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Your Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.numbers_outlined),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            TextFormField(
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (value.toString().length <= 2 ||
                    !RegExp(validationName).hasMatch(value!)) {
                  return 'Enter valid Address';
                } else {
                  return null;
                }
              },
              controller: addressController,
              decoration: const InputDecoration(
                hintText: "Your Address",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_on_outlined),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            TextFormField(
              cursorColor: kPrimaryColor,
              controller: wardController,
              validator: (value) {
                if (value.toString().length <= 2 ||
                    !RegExp(validationName).hasMatch(value!)) {
                  return 'Enter valid ward';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Your Ward",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.add_home_work),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            TextFormField(
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (value.toString().length <= 2 ||
                    !RegExp(validationName).hasMatch(value!)) {
                  return 'Enter valid city';
                } else {
                  return null;
                }
              },
              controller: cityController,
              decoration: const InputDecoration(
                hintText: "Your City",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_city),
                ),
              ),
            ),
            const CustomVerticalSizedBox(16),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  signUpUsingFirebase(
                    name: nameController.text.trim(),
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return const Material(child: HomeScreeen());
                      },
                    ),
                  );
                }
              },
              child: Text("Sign Up".toUpperCase()),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            const CustomVerticalSizedBox(16),
          ],
        ),
      );
  }
}

bool isSignedIn = false;
var displayUserName = '';
void signUpUsingFirebase(
    {required String name,
    required String email,
    required String password,
    context}) async {
  try {
    await auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      displayUserName = name;
      auth.currentUser!.updateDisplayName(displayUserName);
    });
    users.add({
      'number': numberController.text,
      'address': addressController.text,
      'ward': wardController.text,
      'city': cityController.text,
    });
  } on FirebaseAuthException catch (error) {
    String title = error.code.replaceAll(RegExp('-'), ' ').toUpperCase();
    String message = '';

    if (error.code == 'weak-password') {
      message = 'The password provided is too weak..';
    } else if (error.code == 'email-already-in-use') {
      message = 'The account already exists for that email..';
    } else {
      message = error.message.toString();
    }

    SnackBar(
      backgroundColor: Colors.green,
      content: Text(title),
    );
  } catch (error) {
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(error.toString()),
    );
  }
}
