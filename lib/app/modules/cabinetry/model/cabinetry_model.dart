class CabinetryModel {
  bool? success;
  String? message;
  CabinetData? data;

  CabinetryModel({
    this.success,
    this.message,
    this.data,
  });

  factory CabinetryModel.fromJson(Map<String, dynamic> json) {
    return CabinetryModel(
      data: json['data'] != null ? CabinetData.fromJson(json['data']) : null,
    );
  }
}

class CabinetData {
  List<Category>? categories;

  CabinetData({
    this.categories,
  });

  factory CabinetData.fromJson(List<dynamic> json) {
    return CabinetData(
      categories: json.isNotEmpty ? json.map((category) => Category.fromJson(category)).toList() : null,
    );
  }
}

class Category {
  String? categoryId;
  String? categoryName;
  List<Cabinet>? cabinet;

  Category({
    this.categoryId,
    this.categoryName,
    this.cabinet,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      cabinet: json['data'] != null ? (json['data'] as List).map((cabinetJson) => Cabinet.fromJson(cabinetJson)).toList() : null,
    );
  }
}

class Cabinet {
  String? id;
  String? title;
  String? subTitle;
  String? code;
  String? colorName;
  String? description;
  String? categoryId;
  String? branchId;
  String? branchName;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  int? v;

  Cabinet({
    this.id,
    this.title,
    this.subTitle,
    this.code,
    this.colorName,
    this.description,
    this.categoryId,
    this.branchId,
    this.branchName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cabinet.fromJson(Map<String, dynamic> json) {
    return Cabinet(
      id: json['_id'],
      title: json['title'],
      subTitle: json['subTitle'],
      code: json['code'],
      colorName: json['colorName'],
      description: json['description'],
      categoryId: json['categoryId'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
