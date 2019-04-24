library Id;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'Id.g.dart';

abstract class Id implements Built<Id, IdBuilder> {
  // fields go here
  String get videoId;

  Id._();

  factory Id([updates(IdBuilder b)]) = _$Id;

  String toJson() {
    return json.encode(serializers.serializeWith(Id.serializer, this));
  }

  static Id fromJson(String jsonString) {
    return serializers.deserializeWith(Id.serializer, json.decode(jsonString));
  }

  static Serializer<Id> get serializer => _$IdSerializer;
}
