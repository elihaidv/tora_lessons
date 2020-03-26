import 'package:json_annotation/json_annotation.dart';

part 'Models.g.dart';

@JsonSerializable()
class Lesson {
  String id;
  String title;
  String description;
  String image;
  String url;
  Rav rav;

  Lesson(this.id, this.title, this.description, this.image, this.rav, this.url);

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

@JsonSerializable()
class Rav {
  String id;
  String name;
  String image;

  Rav(this.id, this.name, this.image);

  factory Rav.fromJson(Map<String, dynamic> json) => _$RavFromJson(json);
  Map<String, dynamic> toJson() => _$RavToJson(this);
}