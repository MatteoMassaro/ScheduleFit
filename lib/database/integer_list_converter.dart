import 'dart:convert';

import 'package:drift/drift.dart';

class IntegerListConverter extends TypeConverter<List<int>, String> {
  const IntegerListConverter();

  @override
  List<int> fromSql(String fromDb) {
    return List<int>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<int> value) {
    return json.encode(value);
  }
}
