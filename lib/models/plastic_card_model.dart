class PlaticCardTypeModel {
  List<Data>? data;

  PlaticCardTypeModel({this.data});

  PlaticCardTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
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
      data['paymentType'] = this.paymentType?.toJson();
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
