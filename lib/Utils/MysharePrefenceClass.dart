
import 'package:shared_preferences/shared_preferences.dart';


class MySharedPreferences {
  static const setLoginData = 'logInData';
  static const isPermissionGiven = 'permissionGiven';
  static const userSessionDataNode = 'userSessionDataNode';
  static const userSessionDataPhp = "useSessionDataPhp";
  static const savePhpOtpModel = 'savePhpOtpModel';
  static const saveLeadId = 'saveLeadId';
  static const saveCustomerDetails = "saveCustomerDetails";


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



  static Future<void> setLeadId(String leadId) async {
    String data = leadId;
    final prefs = await _getPreferences();
    await prefs.setString(saveLeadId, data);
  }

  static Future<String> getLeadId() async {
    final prefs = await _getPreferences();
    String? leadId = prefs.getString(saveLeadId);

    if (leadId != null) {
      return leadId;
    } else {
      return "";
    }
  }


  static Future<void> setPhpOTPModel(String userdata) async {
    String data = userdata;
    final prefs = await _getPreferences();
    await prefs.setString(savePhpOtpModel, data);
  }

  static Future<dynamic> getPhpOTPModel() async {
    final prefs = await _getPreferences();
    String? otpModel = prefs.getString(savePhpOtpModel);

    if (otpModel != null) {
      return otpModel;
    } else {
      return null;
    }
  }


  static Future<void> setUserSessionDataNode(String userdata) async {
    String data = userdata;
    final prefs = await _getPreferences();
    await prefs.setString(userSessionDataNode, data);
  }

  static Future<dynamic> getUserSessionDataNode() async {
    final prefs = await _getPreferences();
    String? loginPIN = prefs.getString(userSessionDataNode);

    if (loginPIN != null) {
      return loginPIN;
    } else {
      return null;
    }
  }


  static Future<void> setUserSessionDataPhp(String userdata) async {
    String data = userdata;
    final prefs = await _getPreferences();
    await prefs.setString(userSessionDataPhp, data);
  }

  static Future<dynamic> getUserSessionDataPhp() async {
    final prefs = await _getPreferences();
    String? loginPIN = prefs.getString(userSessionDataPhp);

    if (loginPIN != null) {
      return loginPIN;
    } else {
      return null;
    }
  }

  static Future<void> setCustomerDetails(String customerData) async {
    String data = customerData;
    final prefs = await _getPreferences();
    await prefs.setString(data, saveCustomerDetails);
  }

  static Future<dynamic> getCustomerDetails() async {
    final prefs = await _getPreferences();
    String? customerDetails = prefs.getString(saveCustomerDetails);

    if (customerDetails != null) {
      return customerDetails;
    } else {
      return null;
    }
  }







  static Future<bool> logOutFunctionData() async {
    final prefs = await _getPreferences();
    final removedLogin = await prefs.remove(setLoginData);
    final removedNode = await prefs.remove(userSessionDataNode);
    final removedPhp = await prefs.remove(userSessionDataPhp);
    final removedOtp = await prefs.remove(savePhpOtpModel);
    final removeCustomerDetails = await prefs.remove(saveCustomerDetails);

    return removedLogin || removedNode || removedPhp || removedOtp || removeCustomerDetails;
  }


}
