class PartResponseModel {
  bool? success;
  String? message;
  List<PartData>? data;

  PartResponseModel({this.success, this.message, this.data});

  factory PartResponseModel.fromJson(Map<String, dynamic> json) {
    return PartResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PartData.fromJson(e))
          .toList(),
    );
  }
}

class PartData {
  StockItem? stockItem;
  List<CategoryWithParts>? categoriesWithParts;

  PartData({this.stockItem, this.categoriesWithParts});

  factory PartData.fromJson(Map<String, dynamic> json) {
    return PartData(
      stockItem: json['stockItem'] != null
          ? StockItem.fromJson(json['stockItem'])
          : null,
      categoriesWithParts: (json['categoriesWithParts'] as List<dynamic>?)
          ?.map((e) => CategoryWithParts.fromJson(e))
          .toList(),
    );
  }
}

class StockItem {
  String? id;
  String? title;
  String? branchName;

  StockItem({this.id, this.title, this.branchName});

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      branchName: json['branchName'] as String?,
    );
  }
}

class CategoryWithParts {
  Category? category;
  List<Part>? parts;

  CategoryWithParts({this.category, this.parts});

  factory CategoryWithParts.fromJson(Map<String, dynamic> json) {
    return CategoryWithParts(
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => Part.fromJson(e))
          .toList(),
    );
  }
}

class Category {
  String? id;
  String? title;
  String? stockItemId;
  String? branchName;
  String? branchId;

  Category({
    this.id,
    this.title,
    this.stockItemId,
    this.branchName,
    this.branchId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      stockItemId: json['stockItemId'] as String?,
      branchName: json['branchName'] as String?,
      branchId: json['branchId'] as String?,
    );
  }
}

class Part {
  String? id;
  String? title;
  String? subTitle;
  double? price;
  double? dealerPrice;
  String? description;
  List<dynamic>? images;
  String? stockItemCategoryId;
  String? stockItemId;
  String? branchName;
  String? branchId;

  Part({
      this.id,
      this.title,
      this.subTitle,
      this.price,
      this.dealerPrice,
      this.description,
      this.images,
      this.stockItemCategoryId,
      this.stockItemId,
      this.branchName,
      this.branchId,
    });

  factory Part.fromJson(Map<String, dynamic> json) {
      return Part(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        subTitle: json['subTitle'] as String?,
        price: _toDouble(json['price']),
        dealerPrice: _toDouble(json['dealerPrice']),
        description: json['description'] as String?,
        images: json['images'] as List<dynamic>?,
        stockItemCategoryId: json['stockItemCategoryId'] as String?,
        stockItemId: json['stockItemId'] as String?,
        branchName: json['branchName'] as String?,
        branchId: json['branchId'] as String?,
      );
    }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return double.tryParse(value.toString());
    if (value is String) return double.tryParse(value);
    return null;
  }
}