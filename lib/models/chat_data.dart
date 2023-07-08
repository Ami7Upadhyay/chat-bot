/// id : "chatcmpl-7Urfzwtu5YkC0JzZW3ctEKyPgI98h"
/// object : "chat.completion"
/// created : 1687590527
/// model : "gpt-3.5-turbo-0301"
/// choices : [{"index":0,"message":{"role":"assistant","content":"An inherited widget is a type of widget in Flutter that allows data to be passed down the widget tree to its children. It is used to share data between widgets that are not directly related to each other without having to manually pass it down. \n\nWhen an inherited widget is created, it defines a piece of data that can be accessed by its descendants. The descendants can then access this data by using the InheritedWidget.of(context) method. This method searches up the widget tree until it finds the nearest ancestor that is an instance of the inherited widget and returns the data associated with it.\n\nInherited widgets are useful for situations where data needs to be shared across multiple widgets in a widget tree. For example, an inherited widget can be used to pass a theme or localization data down to all of its descendants."},"finish_reason":"stop"}]
/// usage : {"prompt_tokens":11,"completion_tokens":161,"total_tokens":172}

class ChatData {
  ChatData({
    String? id,
    String? object,
    num? created,
    String? model,
    List<Choices>? choices,
    Usage? usage,
  }) {
    _id = id;
    _object = object;
    _created = created;
    _model = model;
    _choices = choices;
    _usage = usage;
  }

  ChatData.fromJson(dynamic json) {
    _id = json['id'];
    _object = json['object'];
    _created = json['created'];
    _model = json['model'];
    if (json['choices'] != null) {
      _choices = [];
      json['choices'].forEach((v) {
        _choices?.add(Choices.fromJson(v));
      });
    }
    _usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
  }
  String? _id;
  String? _object;
  num? _created;
  String? _model;
  List<Choices>? _choices;
  Usage? _usage;
  ChatData copyWith({
    String? id,
    String? object,
    num? created,
    String? model,
    List<Choices>? choices,
    Usage? usage,
  }) =>
      ChatData(
        id: id ?? _id,
        object: object ?? _object,
        created: created ?? _created,
        model: model ?? _model,
        choices: choices ?? _choices,
        usage: usage ?? _usage,
      );
  String? get id => _id;
  String? get object => _object;
  num? get created => _created;
  String? get model => _model;
  List<Choices>? get choices => _choices;
  Usage? get usage => _usage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['object'] = _object;
    map['created'] = _created;
    map['model'] = _model;
    if (_choices != null) {
      map['choices'] = _choices?.map((v) => v.toJson()).toList();
    }
    if (_usage != null) {
      map['usage'] = _usage?.toJson();
    }
    return map;
  }
}

/// prompt_tokens : 11
/// completion_tokens : 161
/// total_tokens : 172

class Usage {
  Usage({
    num? promptTokens,
    num? completionTokens,
    num? totalTokens,
  }) {
    _promptTokens = promptTokens;
    _completionTokens = completionTokens;
    _totalTokens = totalTokens;
  }

  Usage.fromJson(dynamic json) {
    _promptTokens = json['prompt_tokens'];
    _completionTokens = json['completion_tokens'];
    _totalTokens = json['total_tokens'];
  }
  num? _promptTokens;
  num? _completionTokens;
  num? _totalTokens;
  Usage copyWith({
    num? promptTokens,
    num? completionTokens,
    num? totalTokens,
  }) =>
      Usage(
        promptTokens: promptTokens ?? _promptTokens,
        completionTokens: completionTokens ?? _completionTokens,
        totalTokens: totalTokens ?? _totalTokens,
      );
  num? get promptTokens => _promptTokens;
  num? get completionTokens => _completionTokens;
  num? get totalTokens => _totalTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prompt_tokens'] = _promptTokens;
    map['completion_tokens'] = _completionTokens;
    map['total_tokens'] = _totalTokens;
    return map;
  }
}

/// index : 0
/// message : {"role":"assistant","content":"An inherited widget is a type of widget in Flutter that allows data to be passed down the widget tree to its children. It is used to share data between widgets that are not directly related to each other without having to manually pass it down. \n\nWhen an inherited widget is created, it defines a piece of data that can be accessed by its descendants. The descendants can then access this data by using the InheritedWidget.of(context) method. This method searches up the widget tree until it finds the nearest ancestor that is an instance of the inherited widget and returns the data associated with it.\n\nInherited widgets are useful for situations where data needs to be shared across multiple widgets in a widget tree. For example, an inherited widget can be used to pass a theme or localization data down to all of its descendants."}
/// finish_reason : "stop"

class Choices {
  Choices({
    num? index,
    Message? message,
    String? finishReason,
  }) {
    _index = index;
    _message = message;
    _finishReason = finishReason;
  }

  Choices.fromJson(dynamic json) {
    _index = json['index'];
    _message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    _finishReason = json['finish_reason'];
  }
  num? _index;
  Message? _message;
  String? _finishReason;
  Choices copyWith({
    num? index,
    Message? message,
    String? finishReason,
  }) =>
      Choices(
        index: index ?? _index,
        message: message ?? _message,
        finishReason: finishReason ?? _finishReason,
      );
  num? get index => _index;
  Message? get message => _message;
  String? get finishReason => _finishReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    map['finish_reason'] = _finishReason;
    return map;
  }
}

/// role : "assistant"
/// content : "An inherited widget is a type of widget in Flutter that allows data to be passed down the widget tree to its children. It is used to share data between widgets that are not directly related to each other without having to manually pass it down. \n\nWhen an inherited widget is created, it defines a piece of data that can be accessed by its descendants. The descendants can then access this data by using the InheritedWidget.of(context) method. This method searches up the widget tree until it finds the nearest ancestor that is an instance of the inherited widget and returns the data associated with it.\n\nInherited widgets are useful for situations where data needs to be shared across multiple widgets in a widget tree. For example, an inherited widget can be used to pass a theme or localization data down to all of its descendants."

class Message {
  Message({
    String? role,
    String? content,
  }) {
    _role = role;
    _content = content;
  }

  Message.fromJson(dynamic json) {
    _role = json['role'];
    _content = json['content'];
  }
  String? _role;
  String? _content;
  Message copyWith({
    String? role,
    String? content,
  }) =>
      Message(
        role: role ?? _role,
        content: content ?? _content,
      );
  String? get role => _role;
  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = _role;
    map['content'] = _content;
    return map;
  }
}
