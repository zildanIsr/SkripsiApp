
import 'package:get/get.dart';
import '../Models/user_model.dart';

class UserController extends GetxController {

  var user = User(
      localId : '1234',
      email : 'email',
      displayName : 'Nama',
      idToken : '',
      refreshToken : 'refreshToken',
      expiresIn : 'expired',
  ).obs;

  getUser (Map<String, dynamic> json) {

    user.update((val) {
      val?.localId = json['localId'];
      val?.email = json['email'];
      val?.displayName = json['displayName'];
      val?.idToken = json['idToken'];
      val?.refreshToken = json['refreshToken'];
      val?.expiresIn = json['expiresIn'];
    });
  }
}