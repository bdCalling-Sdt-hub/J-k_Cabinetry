class PaymentResponseModel {
  bool? success;
  String? message;
  PaymentResponseData? data;

  PaymentResponseModel({this.success, this.message, this.data});

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? PaymentResponseData.fromJson(json['data']) : null;
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

class PaymentResponseData {
  String? userId;
  String? branchId;
  String? companyName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? orderId;
  String? country;
  String? status;
  bool? isBillingSame;
  List<Products>? products;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PaymentResponseData(
      {this.userId,
        this.branchId,
        this.companyName,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.address,
        this.city,
        this.state,
        this.zipCode,
        this.orderId,
        this.country,
        this.status,
        this.isBillingSame,
        this.products,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PaymentResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    branchId = json['branchId'];
    companyName = json['companyName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    orderId = json['orderId'];
    country = json['country'];
    status = json['status'];
    isBillingSame = json['isBillingSame'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['branchId'] = branchId;
    data['companyName'] = companyName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['orderId'] = orderId;
    data['country'] = country;
    data['status'] = status;
    data['isBillingSame'] = isBillingSame;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Products {
  String? image;
  String? name;
  int? quantity;
  String? assembly;
  double? total;
  String? sId;

  Products(
      {this.image,
        this.name,
        this.quantity,
        this.assembly,
        this.total,
        this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    quantity = json['quantity'];
    assembly = json['assembly'];
    total = json['total']?.toDouble();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['quantity'] = quantity;
    data['assembly'] = assembly;
    data['total'] = total;
    data['_id'] = sId;
    return data;
  }
}
