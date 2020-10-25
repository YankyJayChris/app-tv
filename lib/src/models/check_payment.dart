class CheckPaymentRepo {
  String apiStatus;
  String apiVersion;
  String message;
  Data data;
  int days;

  CheckPaymentRepo(
      {this.apiStatus, this.apiVersion, this.message, this.data, this.days});

  CheckPaymentRepo.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['days'] = this.days;
    return data;
  }
}

class Data {
  int id;
  int userId;
  String paymentId;
  String amount;
  String currency;
  String provider;
  String phoneNumber;
  String date;
  String endDate;
  String status;
  String period;

  Data(
      {this.id,
      this.userId,
      this.paymentId,
      this.amount,
      this.currency,
      this.provider,
      this.phoneNumber,
      this.date,
      this.endDate,
      this.status,
      this.period});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
    amount = json['amount'];
    currency = json['currency'];
    provider = json['provider'];
    phoneNumber = json['phone_number'];
    date = json['date'];
    endDate = json['end_date'];
    status = json['status'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['payment_id'] = this.paymentId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['provider'] = this.provider;
    data['phone_number'] = this.phoneNumber;
    data['date'] = this.date;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['period'] = this.period;
    return data;
  }
}