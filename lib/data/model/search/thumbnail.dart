library thumbnail;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:youtube_search/data/model/serializer/serializers.dart';

part 'thumbnail.g.dart';

abstract class Thumbnail implements Built<Thumbnail, ThumbnailBuilder> {
  // fields go here

  Thumbnail._();

  factory Thumbnail([updates(ThumbnailBuilder b)]) = _$Thumbnail;

  String toJson() {
    return json.encode(serializers.serializeWith(Thumbnail.serializer, this));
  }

  static Thumbnail fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thumbnail.serializer, json.decode(jsonString));
  }

  static Serializer<Thumbnail> get serializer => _$thumbnailSerializer;
}
