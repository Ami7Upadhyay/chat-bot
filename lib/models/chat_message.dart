import 'Message.dart';

class ChatMessage {
  ChatMessage({
    this.message,
  });

  List<ChatingMessage>? message;

  ChatMessage.fromJson(dynamic json) {
    if (json['message'] != null) {
      message = [];
      json['message'].forEach((v) {
        message?.add(ChatingMessage.fromJson(v));
      });
    }
  }
  

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
