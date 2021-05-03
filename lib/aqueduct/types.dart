import 'dart:ffi';

class TypeInt {
  final String type;
  final Int64 value;

  TypeInt(this.type, this.value);

  TypeInt.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
    'tyoe': type,
    'value': value,
  };
}