class SignInModel {
  Data? data;

  SignInModel({this.data});

  SignInModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  Code? code;

  Data({this.token, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.code != null) {
      data['code'] = this.code?.toJson();
    }
    return data;
  }
}

class Code {
  int? userId;
  String? phone;
  String? code;
  int? smsExpire;

  int? id;

  Code({this.userId, this.phone, this.code, this.smsExpire, this.id});

  Code.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    phone = json['phone'];
    code = json['code'];
    smsExpire = json['sms_expire'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['sms_expire'] = this.smsExpire;
    data['id'] = this.id;

    return data;
  }
}
