
import 'package:loan112_app/Model/DashBoarddataModel.dart';
import 'package:loan112_app/Services/http_client_php.dart';
import '../Constant/ApiUrlConstant/ApiUrlConstant.dart';
import '../Services/ApiResponseStatus.dart';
import '../Utils/Debugprint.dart';

class DashBoardRepository{
  final ApiClassPhp apiClassPhp;
  DashBoardRepository(this.apiClassPhp);


  ApiResponseStatus mapApiResponseStatus(dynamic responseBody) {
    final Map<String, dynamic> decoded = responseBody;

    final int? logicalStatusCode = decoded['Status'];

    if (logicalStatusCode == null) {
      // Fallback: if no logical status code found, treat as failure
      return ApiResponseStatus.notFound;
    }

    return mapStatusCodePhp(logicalStatusCode);
  }

  Future<ApiResponse<DashBoarddataModel>> dashBoardApiCallFunction(Map<String,String> dataObj) async {
    final response = await apiClassPhp.post(dashBoard, dataObj, isHeader: true);
    DebugPrint.prt("API Response AreaWise Data ${response.data}");

    final Map<String, dynamic> responseData = response.data;
    final ApiResponseStatus status = mapApiResponseStatus(responseData);

    if (status == ApiResponseStatus.success) {
      final data = DashBoarddataModel.fromJson(responseData);
      DebugPrint.prt("ResponseData In success $responseData");
      return ApiResponse.success(data);
    } else {
      final error = DashBoarddataModel.fromJson(responseData);
      return ApiResponse.error(status, error: error);
    }
  }


}