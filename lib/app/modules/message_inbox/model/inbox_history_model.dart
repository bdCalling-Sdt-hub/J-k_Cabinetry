class InboxHistoryModel {
  bool? success;
  int? code;
  String? message;
  InboxHistoryData? data;

  InboxHistoryModel({this.success, this.code, this.message, this.data});

  InboxHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? InboxHistoryData.fromJson(json['data']) : null;
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

class InboxHistoryData {
  List<MessageAttributes>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  InboxHistoryData(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  InboxHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <MessageAttributes>[];
      json['results'].forEach((v) {
        results!.add(MessageAttributes.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
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
  String? chatId;
  User? senderId;
  User? receiverId;
  MessageContent? messageContent;
  List<String>? seenBy;
  List<String>? deletedBy;
  List<String>? unsentBy;
  String? createdAt;
  String? updatedAt;
  int? v;

  MessageAttributes(
      {this.sId,
      this.chatId,
      this.senderId,
      this.receiverId,
      this.messageContent,
      this.seenBy,
      this.deletedBy,
      this.unsentBy,
      this.createdAt,
      this.updatedAt,
      this.v});

  MessageAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatId = json['chatId'];
    senderId =
        json['senderId'] != null ? User.fromJson(json['senderId']) : null;
    receiverId =
        json['receiverId'] != null ? User.fromJson(json['receiverId']) : null;
    messageContent =
        json['content'] != null ? MessageContent.fromJson(json['content']) : null;
    if (json['seenBy'] != null) {
      seenBy = List<String>.from(json['seenBy']);
    }
    if (json['deletedBy'] != null) {
      deletedBy = List<String>.from(json['deletedBy']);
    }
    if (json['unsentBy'] != null) {
      unsentBy = List<String>.from(json['unsentBy']);
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['chatId'] = chatId;
    if (senderId != null) {
      data['senderId'] = senderId!.toJson();
    }
    if (receiverId != null) {
      data['receiverId'] = receiverId!.toJson();
    }
    if (messageContent != null) {
      data['content'] = messageContent!.toJson();
    }
    if (seenBy != null) {
      data['seenBy'] = seenBy;
    }
    if (deletedBy != null) {
      data['deletedBy'] = deletedBy;
    }
    if (unsentBy != null) {
      data['unsentBy'] = unsentBy;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}

class User {
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
  int? v;
  String? addressLine2;

  User(
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
      this.v,
      this.addressLine2});

  User.fromJson(Map<String, dynamic> json) {
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
    v = json['__v'];
    addressLine2 = json['addressLine2'];
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
    data['__v'] = v;
    data['addressLine2'] = addressLine2;
    return data;
  }
}

class MessageContent {
  String? messageType;
  String? text;
  List<String>? fileUrls;
  String? sId;

  MessageContent({this.messageType, this.text, this.fileUrls, this.sId});

  MessageContent.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    text = json['text'];
    fileUrls = json['fileUrls'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageType'] = messageType;
    data['text'] = text;
    data['fileUrls'] = fileUrls;
    data['_id'] = sId;
    return data;
  }
}
