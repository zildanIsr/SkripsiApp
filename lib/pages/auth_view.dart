import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/bottom_navbar.dart';
import 'package:flutter_login/flutter_login.dart';

import '../Controllers/auth.dart';
import 'package:get/get.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class AuthView extends StatelessWidget {
  AuthView({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);
  final authController = Get.put(AuthController());

  Future<String?> _authUser(LoginData data) {
    //debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      var responses = await authController.signInAuth(
          data.name.toLowerCase(), data.password.toLowerCase());
      if (responses >= 400) {
        return 'Email atau password salah';
      } else if (responses == 500) {
        return 'Login Gagal';
      } else if (responses == 201) {
        authController.isLogin.value = true;
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup data: ${data.name}, ${data.password}, ');
    return Future.delayed(loginTime).then((_) {
      authController.signUpAuth(data.name, data.password);
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'oke';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
          pageColorLight: Colors.redAccent.shade100,
          pageColorDark: Colors.pink.shade500),
      messages: LoginMessages(
          forgotPasswordButton: 'Lupa Password?',
          signupButton: 'Register',
          confirmPasswordError: 'Password salah',
          recoverPasswordIntro: 'Setel ulang password anda',
          recoverPasswordDescription:
              'Kami akan mengirim anda email untuk mengganti password',
          goBackButton: 'Kembali'),
      title: 'Home Nursing',
      //logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavbar(),
        ));

        // Get.to(() =>
        //     authController.isLogin.value ? const BottomNavbar() : AuthView());
      },
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton: true,
    );
  }
}
