import 'package:flutter/material.dart';
import 'package:flutter_music_app/model/song_model.dart';
import 'package:flutter_music_app/provider/view_state_list_model.dart';
import 'package:flutter_music_app/service/Models.dart';
import 'package:localstorage/localstorage.dart';

const String kLocalStorageSearch = 'kLocalStorageSearch';
const String kFavoriteList = 'kFavoriteList';

/// 我的收藏列表
class FavoriteListModel extends ViewStateListModel<Lesson> {
  FavoriteModel favoriteModel;

  FavoriteListModel({this.favoriteModel});
  @override
  Future<List<Lesson>> loadData() async {
    LocalStorage localStorage = LocalStorage(kLocalStorageSearch);
    await localStorage.ready;
    List<Lesson> favoriteList =
        (localStorage.getItem(kFavoriteList) ?? []).map<Lesson>((item) {
      return Lesson.fromJson(item);
    }).toList();
    favoriteModel.setFavorites(favoriteList);
    setIdle();
    return favoriteList;
  }
}

class FavoriteModel with ChangeNotifier {
  List<Lesson> _favoriteLesson;
  List<Lesson> get favoriteLesson => _favoriteLesson;

  setFavorites(List<Lesson> favoriteLesson) {
    _favoriteLesson = favoriteLesson;
    notifyListeners();
  }

  collect(Lesson song) {
    if (_favoriteLesson.contains(song)) {
      _favoriteLesson.remove(song);
    } else {
      _favoriteLesson.add(song);
    }
    saveData();
    notifyListeners();
  }

  saveData() async {
    LocalStorage localStorage = LocalStorage(kLocalStorageSearch);
    await localStorage.ready;
    localStorage.setItem(kFavoriteList, _favoriteLesson);
  }

  isCollect(Lesson newLesson) {
    bool isCollect = false;
    for (int i = 0; i < _favoriteLesson.length; i++) {
      if (_favoriteLesson[i].id == newLesson.id) {
        isCollect = true;
        break;
      }
    }
    return isCollect;
  }
}
