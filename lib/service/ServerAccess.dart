import 'package:flutter_music_app/service/Models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'ServerAccess.g.dart';

@RestApi(baseUrl: "https://5e791189491e9700162de807.mockapi.io/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/lessons")
  Future<List<Lesson>> getLessons();


  @GET("/lessonsRav")
  Future<List<Lesson>> getLessonsByRav(@Query("rav") String id);

  @GET("/ravs")
  Future<List<Rav>> getRavs();
}