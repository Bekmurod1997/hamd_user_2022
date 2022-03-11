class ProductsByCategoryModel {
  List<Data>? data;

  ProductsByCategoryModel({this.data});

  ProductsByCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  String? parameters;
  dynamic? price;
  dynamic? rating;
  String? photo;
  List<Gallery>? gallery;

  Data(
      {this.id,
      this.name,
      this.description,
      this.parameters,
      this.price,
      this.rating,
      this.photo,
      this.gallery});

  Data.fromJson(Map<String, dynamic> json) {
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
