class AllChatsModel {
  bool? success;
  int? code;
  String? message;
  AllChatsData? data;

  AllChatsModel({this.success, this.code, this.message, this.data});

  AllChatsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? AllChatsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AllChatsData {
  List<MessageAttributes>? attributes;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  AllChatsData({
    this.attributes,
    this.page,
    this.limit,
    this.totalPages,
    this.totalResults,
  });

  AllChatsData.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      attributes = <MessageAttributes>[];
      json['results'].forEach((v) {
        attributes!.add(MessageAttributes.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['results'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    data['totalResults'] = totalResults;
    return data;
  }
}

class MessageAttributes {
  String? sId;
  String? chatType;
  List<String>? participants; // We don't have a Participants object like the golf tournament one had
  bool? isGroupChat;
  SenderId? senderId;
  ReceiverId? receiverId;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastMessage;

  MessageAttributes(
      {this.sId,
        this.chatType,
        this.participants,
        this.isGroupChat,
        this.senderId,
        this.receiverId,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.lastMessage});

  MessageAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatType = json['chatType'];
    participants = json['participants'].cast<String>();
    isGroupChat = json['isGroupChat'];
    senderId = json['senderId'] != null
        ? SenderId.fromJson(json['senderId'])
        : null;
    receiverId = json['receiverId'] != null
        ? ReceiverId.fromJson(json['receiverId'])
        : null;
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['chatType'] = chatType;
    data['participants'] = participants;
    data['isGroupChat'] = isGroupChat;
    if (senderId != null) {
      data['senderId'] = senderId!.toJson();
    }
    if (receiverId != null) {
      data['receiverId'] = receiverId!.toJson();
    }
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['lastMessage'] = lastMessage;
    return data;
  }
}

class SenderId {
  String? sId;
  String? companyName;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? state;
  String? city;
  String? zipCode;
  String? businessLicense;
  String? profileImage;
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
  String? branchID;
  String? role;
  bool? isBlocked;
  bool? isverified;
  bool? isSuspend;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SenderId(
      {this.sId,
        this.companyName,
        this.firstName,
        this.lastName,
        this.phone,
        this.address,
        this.state,
        this.city,
        this.zipCode,
        this.businessLicense,
        this.profileImage,
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
        this.branchID,
        this.role,
        this.isBlocked,
        this.isverified,
        this.isSuspend,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SenderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyName = json['companyName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zipCode'];
    businessLicense = json['businessLicense'];
    profileImage = json['profileImage'];
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
    branchID = json['branchID'];
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
    data['state'] = state;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['businessLicense'] = businessLicense;
    data['profileImage'] = profileImage;
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
    data['branchID'] = branchID;
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

class ReceiverId {
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
  String? profileImage;
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
  String? branchID;
  String? role;
  bool? isBlocked;
  bool? isverified;
  bool? isSuspend;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReceiverId(
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
        this.profileImage,
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
        this.branchID,
        this.role,
        this.isBlocked,
        this.isverified,
        this.isSuspend,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ReceiverId.fromJson(Map<String, dynamic> json) {
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
    profileImage = json['profileImage'];
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
    branchID = json['branchID'];
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
    data['profileImage'] = profileImage;
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
    data['branchID'] = branchID;
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
