class MomoResults {
  String apiStatus;
  String apiVersion;
  Data data;
  String refId;

  MomoResults({this.apiStatus, this.apiVersion, this.data, this.refId});

  MomoResults.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    refId = json['ref_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['ref_id'] = this.refId;
    return data;
  }
}

class Data {
  String externalId;
  String amount;
  String currency;
  Payer payer;
  String payerMessage;
  String payeeNote;
  String status;
  String reason;

  Data(
      {this.externalId,
      this.amount,
      this.currency,
      this.payer,
      this.payerMessage,
      this.payeeNote,
      this.status,
      this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    externalId = json['externalId'];
    amount = json['amount'];
    currency = json['currency'];
    payer = json['payer'] != null ? new Payer.fromJson(json['payer']) : null;
    payerMessage = json['payerMessage'];
    payeeNote = json['payeeNote'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['externalId'] = this.externalId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    if (this.payer != null) {
      data['payer'] = this.payer.toJson();
    }
    data['payerMessage'] = this.payerMessage;
    data['payeeNote'] = this.payeeNote;
    data['status'] = this.status;
    data['reason'] = this.reason;
    return data;
  }
}

class Payer {
  String partyIdType;
  String partyId;

  Payer({this.partyIdType, this.partyId});

  Payer.fromJson(Map<String, dynamic> json) {
    partyIdType = json['partyIdType'];
    partyId = json['partyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partyIdType'] = this.partyIdType;
    data['partyId'] = this.partyId;
    return data;
  }
}