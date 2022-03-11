class CartListModel {
  List<Data>? data;

  CartListModel({this.data});

  CartListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
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
