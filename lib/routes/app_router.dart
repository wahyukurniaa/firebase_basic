import 'package:firebase_basic/early/choose_screen.dart';
import 'package:firebase_basic/home/home_screen.dart';
import 'package:firebase_basic/routes/app_routes.dart';
import 'package:firebase_basic/signin/login_screen.dart';
import 'package:firebase_basic/signup/signup_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static router() {
    return {
      AppRoutes.chooseScreen.name: (context) => const ChooseScreen(),
      AppRoutes.signinScreen.name: (context) => SignInScreen(),
      AppRoutes.signupScreen.name: (context) => const SignUpScreen(),
      AppRoutes.homeScreen.name: (context) => const HomeScreen(),
    };
  }

  static getRouter() {
    return [
      GetPage(
        name: AppRoutes.chooseScreen.name,
        page: () => const ChooseScreen(),
      ),
      GetPage(
        name: AppRoutes.signinScreen.name,
        page: () => SignInScreen(),
      ),
      GetPage(
        name: AppRoutes.signupScreen.name,
        page: () => const SignUpScreen(),
      ),
      GetPage(
        name: AppRoutes.homeScreen.name,
        page: () => const HomeScreen(),
      )
    ];
  }
}
