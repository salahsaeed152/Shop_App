class SearchModel {

  bool status;
  SearchDataModel data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }

}

class SearchDataModel {
  int currentPage;
  List<DataModel> data = [];
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int previousPage;
  String previousPageUrl;
  int to;
  int total;

  SearchDataModel.fromJson(Map<String, dynamic>json){
    currentPage = json['currentPage'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
    firstPageUrl = json['firstPageUrl'];
    from = json['from'];
    lastPage = json['lastPage'];
    lastPageUrl = json['lastPageUrl'];
    nextPageUrl = json['nextPageUrl'];
    path = json['path'];
    previousPage = json['previousPage'];
    previousPageUrl = json['previousPageUrl'];
    to = json['to'];
    total = json['total'];
  }

}

class DataModel {
  int id;
  dynamic price;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  DataModel.fromJson(Map<String, dynamic>json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'] != null ? inFavorites = json['in_favorites'] : false;
    inCart = json['in_cart'] != null ? inCart = json['in_cart'] : false;
  }

}