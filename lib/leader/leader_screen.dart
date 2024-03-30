import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/background.dart';
import 'package:flutter_application_1/responsive.dart';
import 'package:flutter_application_1/screens/Login/components/login_screen_top_image.dart';
import 'package:flutter_application_1/shared/custom_vertical_sized_box.dart';

class LeaderScreen extends StatelessWidget {
  const LeaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLeaderScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/result');
                            },
                            child: Text(
                              "Login as an admin".toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            child: Text(
                              "Follow-up".toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLeaderScreen extends StatelessWidget {
  const MobileLeaderScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/result');
                },
                child: Text(
                  "Login as an admin".toUpperCase(),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
        const CustomVerticalSizedBox(12),
        SizedBox(
          width: 330,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text(
              "Follow-up".toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}
