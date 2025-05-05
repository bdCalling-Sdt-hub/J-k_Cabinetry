class AuthSuccessModel {
  int? statusCode;
  bool? success;
  String? message;
  String? token;
  List<Data>? data;

  AuthSuccessModel(
      {this.statusCode, this.success, this.message, this.token, this.data});

  AuthSuccessModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    token = json['token'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? companyName;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? addressLine2;
  String? state;
  String? city;
  String? zipCode;
  String? businessLicense;
  String? driveingLicense;
  bool? showroom;
  bool? builder;
  bool? designer;
  bool? contractor;
  bool? dealer;
  String? salesRepresentativeName;
  String? selectYourAgency;
  String? email;
  String? password;
  String? confirmPassword;
  bool? termsAndCondition;
  String? branch;
  String? role;
  bool? isBlocked;
  bool? isverified;
  bool? isSuspend;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.companyName,
        this.firstName,
        this.lastName,
        this.phone,
        this.address,
        this.addressLine2,
        this.state,
        this.city,
        this.zipCode,
        this.businessLicense,
        this.driveingLicense,
        this.showroom,
        this.builder,
        this.designer,
        this.contractor,
        this.dealer,
        this.salesRepresentativeName,
        this.selectYourAgency,
        this.email,
        this.password,
        this.confirmPassword,
        this.termsAndCondition,
        this.branch,
        this.role,
        this.isBlocked,
        this.isverified,
        this.isSuspend,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyName = json['companyName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    address = json['address'];
    addressLine2 = json['addressLine2'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zipCode'];
    businessLicense = json['businessLicense'];
    driveingLicense = json['driveingLicense'];
    showroom = json['showroom'];
    builder = json['builder'];
    designer = json['designer'];
    contractor = json['contractor'];
    dealer = json['dealer'];
    salesRepresentativeName = json['salesRepresentativeName'];
    selectYourAgency = json['selectYourAgency'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    termsAndCondition = json['termsAndCondition'];
    branch = json['branch'];
    role = json['role'];
    isBlocked = json['isBlocked'];
    isverified = json['isverified'];
    isSuspend = json['isSuspend'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['companyName'] = companyName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['address'] = address;
    data['addressLine2'] = addressLine2;
    data['state'] = state;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['businessLicense'] = businessLicense;
    data['driveingLicense'] = driveingLicense;
    data['showroom'] = showroom;
    data['builder'] = builder;
    data['designer'] = designer;
    data['contractor'] = contractor;
    data['dealer'] = dealer;
    data['salesRepresentativeName'] = salesRepresentativeName;
    data['selectYourAgency'] = selectYourAgency;
    data['email'] = email;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['termsAndCondition'] = termsAndCondition;
    data['branch'] = branch;
    data['role'] = role;
    data['isBlocked'] = isBlocked;
    data['isverified'] = isverified;
    data['isSuspend'] = isSuspend;
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
