library serializers;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  YoutubeSearchResult,
  SearchItem,
  Id,
  SearchSnippet,
  Thumbnails,
  Thumbnail,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
