import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/Welcome/welcome_screen.dart';
import 'package:flutter_application_1/screens/result_screen.dart';
import 'package:flutter_application_1/state/authentication.dart';
import 'package:flutter_application_1/state/vote.dart';
import 'package:flutter_application_1/utilities.dart';
import 'package:get_storage/get_storage.dart';

import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(VoteApp());
}

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VoteState()),
          ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ],
        child:
            Consumer<AuthenticationState>(builder: (context, authState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                    body: WelcomeScreen(),
                  ),
              '/home': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(kAppName),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: HomeScreeen(),
                  ),
              '/result': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Result',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.home,
                          color: kPrimaryColor,
                        ),
                        color: kPrimaryColor,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: ResultScreen(),
                  )
            },
          );
        }));
  }

  PopupMenuButton getActions(
      BuildContext context, AuthenticationState authState) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          authState.logout();
          gotoLoginScreen(context, authState);
        }
      },
    );
  }
}
