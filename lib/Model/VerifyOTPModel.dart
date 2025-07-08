
class VerifyOTPModel {
  int? statusCode;
  Data? data;
  bool? success;
  String? message;

  VerifyOTPModel({this.statusCode, this.data, this.success, this.message});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? custId;
  String? leadId;
  String? firstName;
  String? middleName;
  String? lastName;
  int? mobile;
  String? pancard;
  String? personalEmail;
  int? isRegister;
  int? custIdDecode;
  String? token;

  Data(
      {this.custId,
      this.leadId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobile,
      this.pancard,
      this.personalEmail,
      this.isRegister,
      this.custIdDecode,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    custId = json['custId'];
    leadId = json['leadId'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    pancard = json['pancard'];
    personalEmail = json['personalEmail'];
    isRegister = json['isRegister'];
    custIdDecode = json['custIdDecode'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custId'] = this.custId;
    data['leadId'] = this.leadId;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['pancard'] = this.pancard;
    data['personalEmail'] = this.personalEmail;
    data['isRegister'] = this.isRegister;
    data['custIdDecode'] = this.custIdDecode;
    data['token'] = this.token;
    return data;
  }
}
