class SinglePartModel {
  bool? success;
  String? message;
  SinglePartData? data;

  SinglePartModel({this.success, this.message, this.data});

  SinglePartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new SinglePartData.fromJson(json['data']) : null;
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

class SinglePartData {
  String? sId;
  List<String>? images;
  String? title;
  String? subTitle;
  String? description;
  num? price;
  StockItemCategoryId? stockItemCategoryId;
  StockItemId? stockItemId;
  String? branchName;
  String? branchId;
  String? createdAt;
  String? updatedAt;
  num? iV;
  num? dealerPrice;

  SinglePartData(
      {this.sId,
      this.images,
      this.title,
      this.subTitle,
      this.description,
      this.price,
      this.dealerPrice,
      this.stockItemCategoryId,
      this.stockItemId,
      this.branchName,
      this.branchId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SinglePartData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    images = json['images'].cast<String>();
    title = json['title'];
    subTitle = json['subTitle'];
    description = json['description'];
    price = json['price'];
    dealerPrice = json['dealerPrice'];
    stockItemCategoryId = json['stockItemCategoryId'] != null
        ? new StockItemCategoryId.fromJson(json['stockItemCategoryId'])
        : null;
    stockItemId = json['stockItemId'] != null
        ? new StockItemId.fromJson(json['stockItemId'])
        : null;
    branchName = json['branchName'];
    branchId = json['branchId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['images'] = images;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['description'] = description;
    data['price'] = price;
    data['dealerPrice'] = dealerPrice;
    if (stockItemCategoryId != null) {
      data['stockItemCategoryId'] = stockItemCategoryId!.toJson();
    }
    if (stockItemId != null) {
      data['stockItemId'] = stockItemId!.toJson();
    }
    data['branchName'] = branchName;
    data['branchId'] = branchId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class StockItemCategoryId {
  String? sId;
  String? title;
  String? stockItemId;
  String? branchName;
  String? branchId;
  String? createdAt;
  String? updatedAt;
  num? iV;

  StockItemCategoryId(
      {this.sId,
        this.title,
        this.stockItemId,
        this.branchName,
        this.branchId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  StockItemCategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    stockItemId = json['stockItemId'];
    branchName = json['branchName'];
    branchId = json['branchId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['stockItemId'] = stockItemId;
    data['branchName'] = branchName;
    data['branchId'] = branchId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class StockItemId {
  String? sId;
  String? title;
  String? branchName;
  num? iV;

  StockItemId({this.sId, this.title, this.branchName, this.iV});

  StockItemId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    branchName = json['branchName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['branchName'] = branchName;
    data['__v'] = iV;
    return data;
  }
}
