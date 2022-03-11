class MyOrdersModel {
  List<Data>? data;

  MyOrdersModel({this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  Courier? courier;
  int? productTotalSum;
  int? deliveryPrice;
  int? productCount;
  String? address;
  String? mapLocation;
  int? status;
  PaymentType? paymentType;
  PaymentType? deliveryType;
  List<OrderProducts>? orderProducts;
  OrderReceipt? orderReceipt;
  String? date;

  Data(
      {this.id,
      this.courier,
      this.productTotalSum,
      this.deliveryPrice,
      this.productCount,
      this.address,
      this.mapLocation,
      this.status,
      this.paymentType,
      this.deliveryType,
      this.orderProducts,
      this.orderReceipt,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courier =
        json['courier'] != null ? new Courier.fromJson(json['courier']) : null;
    productTotalSum = json['product_total_sum'];
    deliveryPrice = json['delivery_price'];
    productCount = json['product_count'];
    address = json['address'];
    mapLocation = json['map_location'];
    status = json['status'];
    paymentType = json['paymentType'] != null
        ? new PaymentType.fromJson(json['paymentType'])
        : null;
    deliveryType = json['deliveryType'] != null
        ? new PaymentType.fromJson(json['deliveryType'])
        : null;
    if (json['orderProducts'] != null) {
      orderProducts = <OrderProducts>[];
      json['orderProducts'].forEach((v) {
        orderProducts!.add(new OrderProducts.fromJson(v));
      });
    }
    orderReceipt = json['orderReceipt'] != null
        ? new OrderReceipt.fromJson(json['orderReceipt'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.courier != null) {
      data['courier'] = this.courier!.toJson();
    }
    data['product_total_sum'] = this.productTotalSum;
    data['delivery_price'] = this.deliveryPrice;
    data['product_count'] = this.productCount;
    data['address'] = this.address;
    data['map_location'] = this.mapLocation;
    data['status'] = this.status;
    if (this.paymentType != null) {
      data['paymentType'] = this.paymentType!.toJson();
    }
    if (this.deliveryType != null) {
      data['deliveryType'] = this.deliveryType!.toJson();
    }
    if (this.orderProducts != null) {
      data['orderProducts'] =
          this.orderProducts!.map((v) => v.toJson()).toList();
    }
    if (this.orderReceipt != null) {
      data['orderReceipt'] = this.orderReceipt!.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}

class Courier {
  int? id;
  String? token;
  String? deviceToken;
  String? language;
  String? phone;
  String? name;
  String? lastname;
  String? photo;
  dynamic? balance;
  dynamic? rating;
  String? passportPhoto;
  String? driverLicensePhoto;

  Courier(
      {this.id,
      this.token,
      this.deviceToken,
      this.language,
      this.phone,
      this.name,
      this.lastname,
      this.photo,
      this.balance,
      this.rating,
      this.passportPhoto,
      this.driverLicensePhoto});

  Courier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    deviceToken = json['device_token'];
    language = json['language'];
    phone = json['phone'];
    name = json['name'];
    lastname = json['lastname'];
    photo = json['photo'];
    balance = json['balance'];
    rating = json['rating'];
    passportPhoto = json['passportPhoto'];
    driverLicensePhoto = json['driverLicensePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['device_token'] = this.deviceToken;
    data['language'] = this.language;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['photo'] = this.photo;
    data['balance'] = this.balance;
    data['rating'] = this.rating;
    data['passportPhoto'] = this.passportPhoto;
    data['driverLicensePhoto'] = this.driverLicensePhoto;
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

class OrderProducts {
  int? totalSum;
  int? count;
  Product? product;

  OrderProducts({this.totalSum, this.count, this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    totalSum = json['total_sum'];
    count = json['count'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_sum'] = this.totalSum;
    data['count'] = this.count;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? parameters;
  int? price;
  dynamic? rating;
  String? photo;
  List<Gallery>? gallery;

  Product(
      {this.id,
      this.name,
      this.description,
      this.parameters,
      this.price,
      this.rating,
      this.photo,
      this.gallery});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    parameters = json['parameters'];
    price = json['price'];
    rating = json['rating'];
    photo = json['photo'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['parameters'] = this.parameters;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['photo'] = this.photo;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallery {
  int? id;
  String? photo;

  Gallery({this.id, this.photo});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    return data;
  }
}

class OrderReceipt {
  int? id;
  int? amount;
  dynamic? deliveryPrice;
  String? receiptId;
  int? status;
  String? date;

  OrderReceipt(
      {this.id,
      this.amount,
      this.deliveryPrice,
      this.receiptId,
      this.status,
      this.date});

  OrderReceipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    deliveryPrice = json['delivery_price'];
    receiptId = json['receipt_id'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['delivery_price'] = this.deliveryPrice;
    data['receipt_id'] = this.receiptId;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
