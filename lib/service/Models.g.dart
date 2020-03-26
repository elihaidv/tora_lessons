// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return Lesson(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String,
    json['image'] as String,
    json['rav'] == null
        ? null
        : Rav.fromJson(json['rav'] as Map<String, dynamic>),
    json['url'] as String,
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'url': instance.url,
      'rav': instance.rav,
    };

Rav _$RavFromJson(Map<String, dynamic> json) {
  return Rav(
    json['id'] as String,
    json['name'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$RavToJson(Rav instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
