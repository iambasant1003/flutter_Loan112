
class GetUtilityDocTypeModel {
  int? statusCode;
  List<DataUtilityModel>? data;
  String? message;
  bool? success;

  GetUtilityDocTypeModel(
      {this.statusCode, this.data, this.message, this.success});

  GetUtilityDocTypeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <DataUtilityModel>[];
      json['data'].forEach((v) {
        data!.add(new DataUtilityModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class DataUtilityModel {
  int? docsId;
  String? docType;
  int? isRequired;

  DataUtilityModel({this.docsId, this.docType, this.isRequired});

  DataUtilityModel.fromJson(Map<String, dynamic> json) {
    docsId = json['docsId'];
    docType = json['docType'];
    isRequired = json['isRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docsId'] = this.docsId;
    data['docType'] = this.docType;
    data['isRequired'] = this.isRequired;
    return data;
  }
}
