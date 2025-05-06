/// Fahim's version 👇
class CabinetDetailsModel {
  bool? success;
  String? message;
  Data? data;

  CabinetDetailsModel({this.success, this.message, this.data});

  CabinetDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? subTitle;
  String? description;
  String? categoryId;
  String? branchName;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.title,
        this.subTitle,
        this.description,
        this.categoryId,
        this.branchName,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subTitle = json['subTitle'];
    description = json['description'];
    categoryId = json['categoryId'];
    branchName = json['branchName'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['branchName'] = branchName;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}











/// Shuvo vai's version
// class CabinetDetailsModel {
//   final bool? success;
//   final String? message;
//   final List<CabinetGroup>? data;
//
//   CabinetDetailsModel({
//      this.success,
//      this.message,
//     this.data,
//   });
//
//   factory CabinetDetailsModel.fromJson(Map<String, dynamic> json) =>
//       CabinetDetailsModel(
//         success: json['success'] as bool,
//         message: json['message'] as String,
//         data: json['data'] != null
//             ? (json['data'] as List<dynamic>).map((e) => CabinetGroup.fromJson(e as Map<String, dynamic>)).toList() : null,
//       );
// }
//
// class CabinetGroup {
//   final StockItem? stockItem;
//   final List<CategoryParts>? categories;
//
//   CabinetGroup({
//      this.stockItem,
//     this.categories,
//   });
//
//   factory CabinetGroup.fromJson(Map<String, dynamic> json) => CabinetGroup(
//     stockItem: StockItem.fromJson(json['stockItem'] as Map<String, dynamic>),
//     categories: json['categories'] != null
//         ? (json['categories'] as List<dynamic>)
//         .map((e) => CategoryParts.fromJson(e as Map<String, dynamic>))
//         .toList()
//         : null,
//   );
// }
//
// class StockItem {
//   final String? id;
//   final String? name;
//
//   StockItem({
//     this.id,
//     this.name,
//   });
//
//   factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
//     id: json['_id'] as String?,
//     name: json['name'] as String?,
//   );
// }
//
// class CategoryParts {
//   final Category? category;
//   final List<Part>? parts;
//
//   CategoryParts({
//      this.category,
//     this.parts,
//   });
//
//   factory CategoryParts.fromJson(Map<String, dynamic> json) => CategoryParts(
//     category: Category.fromJson(json['category'] as Map<String, dynamic>),
//     parts: json['parts'] != null
//         ? (json['parts'] as List<dynamic>)
//         .map((e) => Part.fromJson(e as Map<String, dynamic>))
//         .toList()
//         : null,
//   );
// }
//
// class Category {
//   final String? id;
//   final String? name;
//
//   Category({
//     this.id,
//     this.name,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json['_id'] as String?,
//     name: json['name'] as String?,
//   );
// }
//
// class Part {
//   final String? id;
//   final String? image;
//   final String? title;
//   final String? subTitle;
//   final String? description;
//   final double? price;
//   final String? stockItemCategoryId;
//   final String? stockItemId;
//   final String? branchName;
//   final String? branchId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//
//   Part({
//     this.id,
//     this.image,
//     this.title,
//     this.subTitle,
//     this.description,
//     this.price,
//     this.stockItemCategoryId,
//     this.stockItemId,
//     this.branchName,
//     this.branchId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Part.fromJson(Map<String, dynamic> json) => Part(
//     id: json['_id'] as String?,
//     image: json['image'] as String?,
//     title: json['title'] as String?,
//     subTitle: json['subTitle'] as String?,
//     description: json['description'] as String?,
//     price: (json['price'] as num?)?.toDouble(),
//     stockItemCategoryId: json['stockItemCategoryId'] as String?,
//     stockItemId: json['stockItemId'] as String?,
//     branchName: json['branchName'] as String?,
//     branchId: json['branchId'] as String?,
//     createdAt: json['createdAt'] != null
//         ? DateTime.parse(json['createdAt'] as String)
//         : null,
//     updatedAt: json['updatedAt'] != null
//         ? DateTime.parse(json['updatedAt'] as String)
//         : null,
//     v: json['__v'] as int?,
//   );
// }
