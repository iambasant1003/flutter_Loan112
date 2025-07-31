class GetLoanHistoryModel {
  int? status;
  String? message;
  List<Data>? data;

  GetLoanHistoryModel({this.status, this.message, this.data});

  GetLoanHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? loanActiveStatus;
  String? leadId;
  String? loanNo;
  int? loanRecommended;
  int? roi;
  int? repaymentAmount;
  String? repaymentDate;
  int? tenure;
  String? disbursalDate;
  int? penalRoi;
  String? loanStatus;
  int? loanTotalPayableAmount;
  int? loanTotalReceivedAmount;
  int? loanTotalPenaltyAmount;
  int? loanTotalOutstandingAmount;

  Data(
      {this.loanActiveStatus,
      this.leadId,
      this.loanNo,
      this.loanRecommended,
      this.roi,
      this.repaymentAmount,
      this.repaymentDate,
      this.tenure,
      this.disbursalDate,
      this.penalRoi,
      this.loanStatus,
      this.loanTotalPayableAmount,
      this.loanTotalReceivedAmount,
      this.loanTotalPenaltyAmount,
      this.loanTotalOutstandingAmount});

  Data.fromJson(Map<String, dynamic> json) {
    loanActiveStatus = json['loan_active_status'];
    leadId = json['lead_id'];
    loanNo = json['loan_no'];
    loanRecommended = json['loan_recommended'];
    roi = json['roi'];
    repaymentAmount = json['repayment_amount'];
    repaymentDate = json['repayment_date'];
    tenure = json['tenure'];
    disbursalDate = json['disbursal_date'];
    penalRoi = json['penal_roi'];
    loanStatus = json['loan_status'];
    loanTotalPayableAmount = json['loan_total_payable_amount'];
    loanTotalReceivedAmount = json['loan_total_received_amount'];
    loanTotalPenaltyAmount = json['loan_total_penalty_amount'];
    loanTotalOutstandingAmount = json['loan_total_outstanding_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_active_status'] = this.loanActiveStatus;
    data['lead_id'] = this.leadId;
    data['loan_no'] = this.loanNo;
    data['loan_recommended'] = this.loanRecommended;
    data['roi'] = this.roi;
    data['repayment_amount'] = this.repaymentAmount;
    data['repayment_date'] = this.repaymentDate;
    data['tenure'] = this.tenure;
    data['disbursal_date'] = this.disbursalDate;
    data['penal_roi'] = this.penalRoi;
    data['loan_status'] = this.loanStatus;
    data['loan_total_payable_amount'] = this.loanTotalPayableAmount;
    data['loan_total_received_amount'] = this.loanTotalReceivedAmount;
    data['loan_total_penalty_amount'] = this.loanTotalPenaltyAmount;
    data['loan_total_outstanding_amount'] = this.loanTotalOutstandingAmount;
    return data;
  }
}
