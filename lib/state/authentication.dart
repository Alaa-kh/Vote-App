import "package:flutter/material.dart";

const String kAuthError = 'error';
const String kAuthSuccess = 'success';
const String kAuthLoading = 'loading';
const String kAuthSignInGoogle = 'google';
const String kAuthSignInAnonymous = 'anonymous';

class AuthenticationState with ChangeNotifier {
  String? _authStatus;
  String? _username;
  String? _uid;

  String? get authStatus => _authStatus;
  String? get username => _username;
  String? get uid => _uid;

  AuthenticationState() {}

  void checkAuthentication() async {
    _authStatus = kAuthLoading;

    notifyListeners();
  }

  void logout() {}
}
