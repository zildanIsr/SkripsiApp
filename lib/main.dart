import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/user_controller.dart';
import 'package:flutter_application_1/Routes/routes.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(UserController());

    return GetMaterialApp(
      initialRoute: auth.user.value.idToken.isEmpty ? AppPage.getAuth() : AppPage.getnavbar(),
      getPages: AppPage.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.lightGreen,
        ),
        iconTheme: const IconThemeData(
          color: Colors.pinkAccent
        )
      ),
    );
  }
}

