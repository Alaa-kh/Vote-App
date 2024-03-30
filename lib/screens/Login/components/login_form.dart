import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_string.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (!RegExp(validationEmail).hasMatch(value!)) {
                  return 'Invalid Email';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'Password should be longer or equal to 6 characters';
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  logInUsingFirebase(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context);
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

bool isSignedIn = false;
final GetStorage authBox = GetStorage();
FirebaseAuth auth = FirebaseAuth.instance;
var displayUserName = '';
void logInUsingFirebase(
    {required String email, required String password, context}) async {
  try {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      displayUserName = auth.currentUser!.displayName!;
      isSignedIn = true;
      authBox.write('auth', isSignedIn);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return Material(child: HomeScreeen());
          },
        ),
      );
    });
  } on FirebaseAuthException catch (error) {
    String title = error.code.replaceAll(RegExp('-'), ' ').toUpperCase();
    String message = '';
    if (error.code == 'user-not-found') {
      message =
          "Account doesn't exists for that $email.. Create your account by signing up..";
    } else if (error.code == 'wrong-password') {
      message = 'Invalid Password... Plfease try again!';
    } else {
      message = error.message.toString();
    }

    SnackBar(
      backgroundColor: Colors.red,
      content: Text(title),
    );
  } catch (error) {
    SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
    );
  }
}
