class OrderResponseModel {
  bool? success;
  String? message;
  OrderData? data;

  OrderResponseModel({this.success, this.message, this.data});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
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

class OrderData {
  String? orderId;
  String? createdAt;
  List<Products>? products;
  num? total;
  num? salesTaxAmount;
  num? salesTax;
  num? subTotal;
  num? shipping;

  OrderData({
    this.orderId,
    this.createdAt,
    this.products,
    this.total,
    this.salesTaxAmount,
    this.salesTax,
    this.subTotal,
    this.shipping,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    createdAt = json['createdAt'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    salesTaxAmount = json['salesTaxAmount'];
    salesTax = json['salesTax'];
    subTotal = json['subTotal'];
    shipping = json['shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['createdAt'] = createdAt;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['salesTaxAmount'] = salesTaxAmount;
    data['salesTax'] = salesTax;
    data['subTotal'] = subTotal;
    data['shipping'] = shipping;
    return data;
  }
}

class Products {
  String? name;
  int? quantity;
  String? assembly;
  num? total;
  String? sId;

  Products({this.name, this.quantity, this.assembly, this.total, this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    assembly = json['assembly'];
    total = json['total'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['assembly'] = assembly;
    data['total'] = total;
    data['_id'] = sId;
    return data;
  }
}
