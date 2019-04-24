// GENERATED CODE - DO NOT MODIFY BY HAND

part of thumbnail;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Thumbnail> _$thumbnailSerializer = new _$ThumbnailSerializer();

class _$ThumbnailSerializer implements StructuredSerializer<Thumbnail> {
  @override
  final Iterable<Type> types = const [Thumbnail, _$Thumbnail];
  @override
  final String wireName = 'Thumbnail';

  @override
  Iterable serialize(Serializers serializers, Thumbnail object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object>[];
  }

  @override
  Thumbnail deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new ThumbnailBuilder().build();
  }
}

class _$Thumbnail extends Thumbnail {
  factory _$Thumbnail([void Function(ThumbnailBuilder) updates]) =>
      (new ThumbnailBuilder()..update(updates)).build();

  _$Thumbnail._() : super._();

  @override
  Thumbnail rebuild(void Function(ThumbnailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ThumbnailBuilder toBuilder() => new ThumbnailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Thumbnail;
  }

  @override
  int get hashCode {
    return 439250697;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('Thumbnail').toString();
  }
}

class ThumbnailBuilder implements Builder<Thumbnail, ThumbnailBuilder> {
  _$Thumbnail _$v;

  ThumbnailBuilder();

  @override
  void replace(Thumbnail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Thumbnail;
  }

  @override
  void update(void Function(ThumbnailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Thumbnail build() {
    final _$result = _$v ?? new _$Thumbnail._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
