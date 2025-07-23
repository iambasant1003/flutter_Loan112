class CreateLeadModel {
  int? statusCode;
  Data? data;
  bool? success;
  String? message;

  CreateLeadModel({this.statusCode, this.data, this.success, this.message});

  CreateLeadModel.fromJson(Map<String, dynamic> json) {
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
  int? leadStatusId;
  String? leadStatus;
  String? leadId;

  Data({this.leadStatusId, this.leadStatus, this.leadId});

  Data.fromJson(Map<String, dynamic> json) {
    leadStatusId = json['leadStatusId'];
    leadStatus = json['leadStatus'];
    leadId = json['leadId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadStatusId'] = this.leadStatusId;
    data['leadStatus'] = this.leadStatus;
    data['leadId'] = this.leadId;
    return data;
  }
}
