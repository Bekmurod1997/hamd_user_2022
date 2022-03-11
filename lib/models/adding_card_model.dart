class AddingCardModel {
  Data? data;

  AddingCardModel({this.data});

  AddingCardModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? productId;
  String? productName;
  int? productPrice;
  String? productPhoto;
  int? amount;
  int? totalPrice;

  Data(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productPhoto,
      this.amount,
      this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productPhoto = json['product_photo'];
    amount = json['amount'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_photo'] = this.productPhoto;
    data['amount'] = this.amount;
    data['total_price'] = this.totalPrice;
    return data;
  }
}
