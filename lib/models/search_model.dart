

// ignore_for_file: non_constant_identifier_names

class SearchModel
{
  late bool status;
  late ShearchedData? data;
  SearchModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = status ? ShearchedData.fromJson(json['data']) : null;
  }
}

class ShearchedData 
{
  int? current_page;
  List<SearchedModel> data = [];
  ShearchedData.fromJson(Map<String , dynamic> json)
  {
    current_page = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(SearchedModel.fromJson(element));
    });
  }
  
}

class SearchedModel
{
  int? id;
  dynamic price;
  String? image;
  bool? in_favorites;
  bool? in_cart; 
  String? name;
  SearchedModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}