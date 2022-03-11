class PlasticCardVerifiedModel {
  Data? data;
  Verify? verify;

  PlasticCardVerifiedModel({this.data, this.verify});

  PlasticCardVerifiedModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    verify =
        json['verify'] != null ? new Verify.fromJson(json['verify']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.verify != null) {
      data['verify'] = this.verify!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? cardNumber;
  String? cardPhoneNumber;
  String? cardExpire;
  PaymentType? paymentType;
  String? date;

  Data(
      {this.id,
      this.cardNumber,
      this.cardPhoneNumber,
      this.cardExpire,
      this.paymentType,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNumber = json['card_number'];
    cardPhoneNumber = json['card_phone_number'];
    cardExpire = json['card_expire'];
    paymentType = json['paymentType'] != null
        ? new PaymentType.fromJson(json['paymentType'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_number'] = this.cardNumber;
    data['card_phone_number'] = this.cardPhoneNumber;
    data['card_expire'] = this.cardExpire;
    if (this.paymentType != null) {
      data['paymentType'] = this.paymentType!.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}

class PaymentType {
  int? id;
  String? name;
  String? description;
  String? photo;

  PaymentType({this.id, this.name, this.description, this.photo});

  PaymentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photo'] = this.photo;
    return data;
  }
}

class Verify {
  String? jsonrpc;
  String? id;
  Result? result;

  Verify({this.jsonrpc, this.id, this.result});

  Verify.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  bool? sent;
  String? phone;
  int? wait;

  Result({this.sent, this.phone, this.wait});

  Result.fromJson(Map<String, dynamic> json) {
    sent = json['sent'];
    phone = json['phone'];
    wait = json['wait'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sent'] = this.sent;
    data['phone'] = this.phone;
    data['wait'] = this.wait;
    return data;
  }
}
