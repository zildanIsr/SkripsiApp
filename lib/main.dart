import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/auth.dart';

import 'package:flutter_application_1/Routes/routes.dart';
import 'package:flutter_application_1/pages/auth_view.dart';
import 'package:flutter_application_1/widgets/bottom_navbar.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.put(AuthController());

    return GetMaterialApp(
      // home: FutureBuilder(
      //   future: auth.checkToken(),
      //   builder: (context, AsyncSnapshot<bool> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Scaffold(
      //         body: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     }
      //     if (snapshot.hasData) {
      //       return AuthView();
      //     }
      //     return const BottomNavbar();
      //   },
      // ),
      home: FutureBuilder(
        future: auth.checkToken(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          var data = snapshot.data;

          print(data);

          if (data == true) {
            return const BottomNavbar();
          }

          return AuthView();
        },
      ),
      getPages: AppPage.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink,
            accentColor: Colors.lightGreen,
          ),
          iconTheme: const IconThemeData(color: Colors.pinkAccent)),
    );
  }
}
