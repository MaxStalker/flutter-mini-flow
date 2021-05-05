import 'dart:convert';

// TODO: Reformat to CadenceValue similar to Go

/// Representation of Cadence Int
class CadenceInt {
  final String type;
  final num value;

  CadenceInt(this.value, {this.type = "Int"});

  CadenceInt.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
    'type': type,
    'value': value,
  };

  String toJsonString() {
    return json.encode(this.toJson());
  }

  List<int> toMessage(){
    return utf8.encode(this.toJsonString());
  }
}

/// Representation of Cadence String
class CadenceString {
  final String type;
  final String value;

  CadenceString(this.value, {this.type = "String"});

  CadenceString.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
    'type': type,
    'value': value,
  };

  String toJsonString() {
    return json.encode(this.toJson());
  }

  List<int> toMessage(){
    return utf8.encode(this.toJsonString());
  }
}