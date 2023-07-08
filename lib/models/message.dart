class ChatingMessage {
  ChatingMessage({
    this.user,
    this.ai,
  });

  String? user;
  String? ai;

  ChatingMessage.fromJson(dynamic json) {
    user = json['user'];
    ai = json['ai'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['ai'] = ai;
    return map;
  }
}
