import 'package:flutter_application_1/pages/auth_view.dart';
import 'package:flutter_application_1/pages/history_view.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/maps_view.dart';
import 'package:flutter_application_1/pages/profile_view.dart';
import 'package:flutter_application_1/pages/register_view.dart';
import 'package:flutter_application_1/widgets/bottom_navbar.dart';
import 'package:get/get.dart';

class AppPage {

  static List<GetPage> routes = [
    GetPage(name: navbar, page: () => const BottomNavbar()),
    GetPage(name: home, page: () => const Homepage()),
    GetPage(name: history, page: () => const HistoryView()),
    GetPage(name: maps, page: () => const MapsView()),
    GetPage(name: profile, page: () => const ProfileView()),
    GetPage(name: login, page: () => const Login()),
    GetPage(name: regis, page: () => const RegisterView()),
    GetPage(name: auth, page: () => const AuthView()),
  ];

  static getnavbar() => navbar;
  static gethome() => home;
  static gethistory() => history;
  static getmaps() => maps;
  static getprofile() => profile;
  static getlogin() => login;
  static getRegis() => regis;
  static getAuth() => auth;

  static String navbar = '/';
  static String home = '/homepage';
  static String history = '/history';
  static String maps = '/maps';
  static String profile = '/profile';
  static String login = '/login';
  static String regis = '/register';
  static String auth = '/auth';
}