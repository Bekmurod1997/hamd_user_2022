class DeliveryPriceModel {
  Data? data;

  DeliveryPriceModel({this.data});

  DeliveryPriceModel.fromJson(Map<String, dynamic> json) {
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
  dynamic? deliveryPrice;

  Data({this.deliveryPrice});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryPrice = json['delivery_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_price'] = this.deliveryPrice;
    return data;
  }
}
