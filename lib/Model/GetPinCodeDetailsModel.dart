class GetPinCodeDetailsModel {
  int? statusCode;
  Data? data;
  bool? success;
  String? message;

  GetPinCodeDetailsModel(
      {this.statusCode, this.data, this.success, this.message});

  GetPinCodeDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? pincode;
  int? pincodeCityId;
  int? stateId;
  String? stateName;
  String? cityName;
  String? stateCode;
  String? cityCode;

  Data(
      {this.pincode,
      this.pincodeCityId,
      this.stateId,
      this.stateName,
      this.cityName,
      this.stateCode,
      this.cityCode});

  Data.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    pincodeCityId = json['pincodeCityId'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    stateCode = json['stateCode'];
    cityCode = json['cityCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pincode'] = this.pincode;
    data['pincodeCityId'] = this.pincodeCityId;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['cityName'] = this.cityName;
    data['stateCode'] = this.stateCode;
    data['cityCode'] = this.cityCode;
    return data;
  }
}
