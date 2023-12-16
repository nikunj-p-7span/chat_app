import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IAuthService {
  /// This function is used for initializing the underlying database implementation for
  /// getting and setting the user data

  /// This function is used for setting the accesstoken that a user gets from
  /// the API and store it in the local database.

  init();
  setUserData(User user);
}

final class AuthService implements IAuthService {
  const AuthService();

  @override
  setUserData(User user) {}

  @override
  init() {}
}
