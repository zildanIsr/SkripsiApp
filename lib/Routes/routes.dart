import 'package:flutter_application_1/pages/auth_view.dart';
import 'package:flutter_application_1/pages/history_view.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/maps_view.dart';
import 'package:flutter_application_1/pages/profile_view.dart';
import 'package:flutter_application_1/pages/editprofil_view.dart';
import 'package:flutter_application_1/widgets/bottom_navbar.dart';
import 'package:get/get.dart';

import '../pages/detail_pengguna.dart';
import '../pages/detail_perawat.dart';
import '../pages/layananhomecare_view.dart';
import '../pages/list_address.dart';
import '../pages/listperawat_view.dart';
import '../pages/on_maps.dart';
import '../pages/perawatregister_view.dart';

class AppPage {
  static List<GetPage> routes = [
    GetPage(name: navbar, page: () => const BottomNavbar()),
    GetPage(name: home, page: () => const Homepage()),
    GetPage(name: history, page: () => const HistoryView()),
    GetPage(name: maps, page: () => const MapsView()),
    GetPage(name: profile, page: () => const ProfileView()),
    GetPage(name: login, page: () => const Login()),
    GetPage(name: edit, page: () => const EditProfile()),
    GetPage(name: auth, page: () => AuthView()),
    GetPage(name: regisPerawat, page: () => const RegisterPerawatView()),
    GetPage(name: layananHomecare, page: () => const LayananHomecareView()),
    GetPage(name: detailUser, page: () => const DetailPengguna()),
    GetPage(name: listAddress, page: () => const ListAddress()),
    GetPage(name: onMapsMaker, page: () => const OnMapView()),
    GetPage(name: listNurse, page: () => const ListPerawatView()),
    GetPage(
        name: nurseDetail,
        page: () => const DetailPerawat(
              strNumber: '',
            )),
  ];

  static getnavbar() => navbar;
  static gethome() => home;
  static gethistory() => history;
  static getmaps() => maps;
  static getprofile() => profile;
  static getlogin() => login;
  static getEdit() => edit;
  static getAuth() => auth;
  static getRegisNurse() => regisPerawat;
  static getlayananHc() => layananHomecare;
  static getdetailUser() => detailUser;
  static getAddressUser() => listAddress;
  static getMapsMaker() => onMapsMaker;
  static getListNurse() => listNurse;
  static getnurseDetail() => nurseDetail;

  static String navbar = '/';
  static String home = '/homepage';
  static String history = '/history';
  static String maps = '/maps';
  static String profile = '/profile';
  static String login = '/login';
  static String edit = '/edit-profil';
  static String auth = '/auth';
  static String regisPerawat = '/regis-perawat';
  static String layananHomecare = '/layanan-hc';
  static String detailUser = '/detail-user';
  static String listAddress = '/address-user';
  static String onMapsMaker = '/maps-maker';
  static String listNurse = '/list-Nurse';
  static String nurseDetail = '/nurse-detail';
}
