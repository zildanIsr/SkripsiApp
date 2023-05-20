import '../Models/storage_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  addStringToSF(StorageItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(newItem.key, newItem.value);
  }

  addIntToSF(StorageItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(newItem.key, newItem.value);
  }

  addDoubleToSF(StorageItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(newItem.key, newItem.value);
  }

  addBoolToSF(StorageItem newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(newItem.key, newItem.value);
  }

  Future<String?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    var stringValue = prefs.getString(key);
    return stringValue;
  }

  getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    var boolValue = prefs.getBool(key);
    return boolValue;
  }

  getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    var intValue = prefs.getInt(key);
    return intValue;
  }

  getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    var doubleValue = prefs.getDouble('doubleValue');
    return doubleValue;
  }

  deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  containkey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
