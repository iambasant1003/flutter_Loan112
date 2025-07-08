
import 'package:shared_preferences/shared_preferences.dart';


class MySharedPreferences {
  static const setLoginData = 'logInData';
  static const isPermissionGiven = 'permissionGiven';
  static const userSessionData = 'userSessionData';

  static Future<SharedPreferences> _getPreferences() async {
    return SharedPreferences.getInstance();
  }



  static Future<void> setPermissionStatus(bool permission) async {
    bool data = permission;
    final prefs = await _getPreferences();
    await prefs.setBool(isPermissionGiven, data);
  }

  static Future<bool> getPermissionStatus() async {
    final prefs = await _getPreferences();
    bool? isPermission = prefs.getBool(isPermissionGiven);

    if (isPermission != null) {
      return isPermission;
    } else {
      return false;
    }
  }


  static Future<void> setLogInPIn(String logInPIN) async {
    String data = logInPIN;
    final prefs = await _getPreferences();
    await prefs.setString(setLoginData, data);
  }

  static Future<String> getLogInPIn() async {
    final prefs = await _getPreferences();
    String? loginPIN = prefs.getString(setLoginData);

    if (loginPIN != null) {
      return loginPIN;
    } else {
      return "";
    }
  }

  static Future<void> setUserSessionData(String userdata) async {
    String data = userdata;
    final prefs = await _getPreferences();
    await prefs.setString(userSessionData, data);
  }

  static Future<dynamic> getUserSessionData() async {
    final prefs = await _getPreferences();
    String? loginPIN = prefs.getString(userSessionData);

    if (loginPIN != null) {
      return loginPIN;
    } else {
      return null;
    }
  }



  static Future<void> logOutFunctionData() async {
    // final prefs = await _getPreferences();
    // prefs.remove(fieldOfficerDashboardDataString);
    // prefs.remove(fieldOfficerDataString);
    // prefs.remove(setLoginPIN);
    // prefs.remove(saveHomeModel);
    // prefs.remove(_saveAreaWiseCasesModel);
  }
}
