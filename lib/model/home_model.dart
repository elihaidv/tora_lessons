import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_music_app/model/song_model.dart';
import 'package:flutter_music_app/provider/view_state_refresh_list_model.dart';
import 'package:flutter_music_app/service/Models.dart';
import 'package:flutter_music_app/service/ServerAccess.dart';

class HomeModel extends ViewStateRefreshListModel {

  List<Lesson> _forYou;
  List<Lesson> get forYou => _forYou;

  List<Rav> _ravs;
  List<Rav> get ravs => _ravs;

  @override
  Future<List<Lesson>> loadData({int pageNum}) async {
    List<Future> futures = [];
    final client = RestClient(Dio());

    futures.add( client.getLessons());
    futures.add( client.getRavs());

    var result = await Future.wait(futures);
    _forYou = result[0];
    _ravs = result[1];
    return result[0];
  }
}
