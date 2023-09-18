NtfModel ntfModelFromJson(str) => NtfModel.fromJson(str);

class NtfModel {
  NtfModel({
    this.messages,
  });

  List<Message>? messages;

  factory NtfModel.fromJson(Map<String, dynamic> json) => NtfModel(
        messages: json["messages"] == null
            ? null
            : List<Message>.from(
                json["messages"].map((x) => Message.fromJson(x))),
      );
}

class Message {
  Message({
    this.id,
    this.userId,
    this.message,
    this.type = false,
    this.createdAt,
    this.updatedAt,
    this.senderId = "",
    this.isRegular = "",
    this.sender,
    this.receiver,
  });

  int? id;
  int? userId;
  String? message;
  bool type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String senderId;
  String isRegular;
  Person? sender;
  Person? receiver;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        senderId: json["sender_id"] == null ? null : json["sender_id"],
        isRegular: json["is_regular"] == null ? null : json["is_regular"],
        sender: json["sender"] == null ? null : Person.fromJson(json["sender"]),
        receiver:
            json["receiver"] == null ? null : Person.fromJson(json["receiver"]),
      );
}

class Person {
  Person({
    this.id = -1,
    this.name = "",
  });

  int id;
  String name;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );
}
