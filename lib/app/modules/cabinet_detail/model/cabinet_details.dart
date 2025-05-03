class CabinetDetailsModel {
  final bool? success;
  final String? message;
  final List<CabinetGroup>? data;

  CabinetDetailsModel({
     this.success,
     this.message,
    this.data,
  });

  factory CabinetDetailsModel.fromJson(Map<String, dynamic> json) =>
      CabinetDetailsModel(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: json['data'] != null
            ? (json['data'] as List<dynamic>).map((e) => CabinetGroup.fromJson(e as Map<String, dynamic>)).toList() : null,
      );
}

class CabinetGroup {
  final StockItem? stockItem;
  final List<CategoryParts>? categories;

  CabinetGroup({
     this.stockItem,
    this.categories,
  });

  factory CabinetGroup.fromJson(Map<String, dynamic> json) => CabinetGroup(
    stockItem: StockItem.fromJson(json['stockItem'] as Map<String, dynamic>),
    categories: json['categories'] != null
        ? (json['categories'] as List<dynamic>)
        .map((e) => CategoryParts.fromJson(e as Map<String, dynamic>))
        .toList()
        : null,
  );
}

class StockItem {
  final String? id;
  final String? name;

  StockItem({
    this.id,
    this.name,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
    id: json['_id'] as String?,
    name: json['name'] as String?,
  );
}

class CategoryParts {
  final Category? category;
  final List<Part>? parts;

  CategoryParts({
     this.category,
    this.parts,
  });

  factory CategoryParts.fromJson(Map<String, dynamic> json) => CategoryParts(
    category: Category.fromJson(json['category'] as Map<String, dynamic>),
    parts: json['parts'] != null
        ? (json['parts'] as List<dynamic>)
        .map((e) => Part.fromJson(e as Map<String, dynamic>))
        .toList()
        : null,
  );
}

class Category {
  final String? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['_id'] as String?,
    name: json['name'] as String?,
  );
}

class Part {
  final String? id;
  final String? image;
  final String? title;
  final String? subTitle;
  final String? description;
  final double? price;
  final String? stockItemCategoryId;
  final String? stockItemId;
  final String? branchName;
  final String? branchId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Part({
    this.id,
    this.image,
    this.title,
    this.subTitle,
    this.description,
    this.price,
    this.stockItemCategoryId,
    this.stockItemId,
    this.branchName,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
    id: json['_id'] as String?,
    image: json['image'] as String?,
    title: json['title'] as String?,
    subTitle: json['subTitle'] as String?,
    description: json['description'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    stockItemCategoryId: json['stockItemCategoryId'] as String?,
    stockItemId: json['stockItemId'] as String?,
    branchName: json['branchName'] as String?,
    branchId: json['branchId'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'] as String)
        : null,
    v: json['__v'] as int?,
  );
}
