class BranchModel {
  bool? success;
  String? message;
  List<BranchData>? data;

  BranchModel({this.success, this.message, this.data});

  BranchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BranchData>[];
      json['data'].forEach((v) {
        data!.add(BranchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchData {
  String? sId;
  int? id;
  String? name;
  String? address;
  String? mobile;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? tax;
  String? fbLink;
  String? instaLink;
  String? youtubeLink;

  BranchData({
    this.sId,
    this.id,
    this.name,
    this.address,
    this.mobile,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.tax,
    this.fbLink,
    this.instaLink,
    this.youtubeLink,
  });

  BranchData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    address = json['address'];
    mobile = json['mobile'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    tax = json['tax'];
    fbLink = json['fbLink'];
    instaLink = json['instaLink'];
    youtubeLink = json['youtubeLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['mobile'] = mobile;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['tax'] = tax;
    data['fbLink'] = fbLink;
    data['instaLink'] = instaLink;
    data['youtubeLink'] = youtubeLink;
    return data;
  }
}