/// [post] send message
class ChatModel {
  bool? success;
  int? code;
  String? message;
  ChatData? data;

  ChatModel({this.success, this.code, this.message, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? ChatData.fromJson(json['data']) : null;
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

class ChatData {
  String? chatId;
  String? senderId;
  String? receiverId;
  Content? content;
  List<String> seenBy = [];
  List<String> deletedBy = [];
  List<String> unsentBy = [];
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ChatData(
      {this.chatId,
      this.senderId,
      this.receiverId,
      this.content,
      List<String>? seenBy,
      List<String>? deletedBy,
      List<String>? unsentBy,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV}) {
    this.seenBy = seenBy ?? [];
    this.deletedBy = deletedBy ?? [];
    this.unsentBy = unsentBy ?? [];
  }

  ChatData.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    seenBy = List<String>.from(json['seenBy'] ?? []);
    deletedBy = List<String>.from(json['deletedBy'] ?? []);
    unsentBy = List<String>.from(json['unsentBy'] ?? []);
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['seenBy'] = seenBy;
    data['deletedBy'] = deletedBy;
    data['unsentBy'] = unsentBy;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Content {
  String? messageType;
  String? text;
  List<String>? fileUrls;
  String? sId;

  Content({this.messageType, this.text, this.fileUrls, this.sId});

  Content.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    text = json['text'];
    fileUrls =
        json['fileUrls'] != null ? List<String>.from(json['fileUrls']) : null;
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
