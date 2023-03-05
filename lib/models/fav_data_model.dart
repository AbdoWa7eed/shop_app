
// ignore_for_file: unnecessary_new, non_constant_identifier_names

class FavoritesModel {
  late bool status;
  late Data? data;
  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    status ? data = Data.fromJson(json['data']) : data = Data();
  }
}

class Data {
  int? current_page = 0;
  List<FavData>? data = [];

  Data();

  Data.fromJson(Map<String, dynamic> json)
  {
    current_page = json['current_page'];
    json['data'].forEach((element)
    {
      data!.add(FavData.fromJson(element));
    });
  }

}

class FavData
{
  int? id;
  Product? product;
  FavData.fromJson(Map<String, dynamic> json)
  {
      id = json['id'];
     product =  Product.fromJson(json['product']);
  }
}
class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
