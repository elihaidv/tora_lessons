import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/provider/view_state_refresh_list_model.dart';
import 'package:flutter_music_app/service/Models.dart';
import 'package:flutter_music_app/service/ServerAccess.dart';

class LessonListModel extends ViewStateRefreshListModel<Lesson> {
  final String input;

  LessonListModel({this.input});

  @override
  Future<List<Lesson>> loadData({int pageNum}) async {
    final client = RestClient(Dio());
    return client.getLessons();
  
  }
}

class LessonModel with ChangeNotifier {
  String _url;
  String get url => _url;
  setUrl(String url) {
    _url = url;
    notifyListeners();
  }

  AudioPlayer _audioPlayer = AudioPlayer();
  AudioPlayer get audioPlayer => _audioPlayer;

  List<Lesson> _songs;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  setPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  bool _isRepeat = true;
  bool get isRepeat => _isRepeat;
  changeRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  bool _showList = false;
  bool get showList => _showList;
  setShowList(bool showList) {
    _showList = showList;
    notifyListeners();
  }

  int _currentLessonIndex = 0;

  List<Lesson> get songs => _songs;
  setLessons(List<Lesson> songs) {
    _songs = songs;
    notifyListeners();
  }

  addLessons(List<Lesson> songs) {
    _songs.addAll(songs);
    notifyListeners();
  }

  int get length => _songs.length;
  int get songNumber => _currentLessonIndex + 1;

  setCurrentIndex(int index) {
    _currentLessonIndex = index;
    notifyListeners();
  }

  /// 在播放列表界面点击后立刻播放
  bool _playNow = false;
  bool get playNow => _playNow;
  setPlayNow(bool playNow) {
    _playNow = playNow;
    notifyListeners();
  }

  Lesson get currentLesson => _songs[_currentLessonIndex];

  Lesson get nextLesson {
    if (isRepeat) {
      if (_currentLessonIndex < length) {
        _currentLessonIndex++;
      }
      if (_currentLessonIndex == length) {
        _currentLessonIndex = 0;
      }
    } else {
      Random r = new Random();
      _currentLessonIndex = r.nextInt(_songs.length);
    }
    notifyListeners();
    return _songs[_currentLessonIndex];
  }

  Lesson get prevLesson {
    if (isRepeat) {
      if (_currentLessonIndex > 0) {
        _currentLessonIndex--;
      }
      if (_currentLessonIndex == 0) {
        _currentLessonIndex = length - 1;
      }
    } else {
      Random r = new Random();
      _currentLessonIndex = r.nextInt(_songs.length);
    }
    notifyListeners();
    return _songs[_currentLessonIndex];
  }

  Duration _position;
  Duration get position => _position;
  void setPosition(Duration position) {
    _position = position;
    notifyListeners();
  }

  Duration _duration;
  Duration get duration => _duration;
  void setDuration(Duration duration) {
    _duration = duration;
    notifyListeners();
  }
}
