class SendOTPModel {
  int? statusCode;
  String? data;
  bool? success;
  String? message;

  SendOTPModel({this.statusCode, this.data, this.success, this.message});

  SendOTPModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['data'] = this.data;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
