

// ignore_for_file: empty_constructor_bodies, non_constant_identifier_names

class HomeModel
{
  late bool status;
  late HomeData? data;
  HomeModel.fromJson(Map<String , dynamic> json)
  {
      status = json['status'];
      data = status ? HomeData.fromJson(json['data']) : null;
  }
} 

class HomeData
{
  List<BannersModel> banners = [];
  List<ProductModel> products = [];
    HomeData.fromJson(Map<String , dynamic> json)
    {
      json['banners'].forEach((element)
      {
        banners.add(BannersModel.fromJson(element));
      });
      json['products'].forEach((element)
      {
        products.add(ProductModel.fromJson(element));
      });
    }
}     
class BannersModel
{
  int? id;
  String? image;
  BannersModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}
class ProductModel
{
  int? id;
  dynamic price;
  dynamic old_Price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromJson(Map<String , dynamic> json)
  {
      id = json['id'];
      price = json['price'];
      old_Price = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      in_favorites = json['in_favorites'];
      in_cart = json['in_cart'];
  }
  


}