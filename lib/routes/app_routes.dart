enum AppRoutes { chooseScreen, homeScreen, signinScreen, signupScreen }

extension AppRoutesExtension on AppRoutes {
  String get name {
    switch (this) {
      case AppRoutes.chooseScreen:
        return '/';
      case AppRoutes.signinScreen:
        return '/SignIn';
      case AppRoutes.signupScreen:
        return '/SignUp';
      case AppRoutes.homeScreen:
        return '/Home';
      default:
        return '';
    }
  }
}
