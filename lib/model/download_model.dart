import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_music_app/config/storage_manager.dart';
import 'package:flutter_music_app/model/song_model.dart';
import 'package:flutter_music_app/provider/view_state_list_model.dart';
import 'package:flutter_music_app/service/Models.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

const String kLocalStorageSearch = 'kLocalStorageSearch';
const String kDownloadList = 'kDownloadList';
const String kDirectoryPath = 'kDirectoryPath';

/// 我的下载列表
class DownloadListModel extends ViewStateListModel<Lesson> {
  DownloadModel downloadModel;

  DownloadListModel({this.downloadModel});
  @override
  Future<List<Lesson>> loadData() async {
    LocalStorage localStorage = LocalStorage(kLocalStorageSearch);
    await localStorage.ready;
    List<Lesson> downloadList =
        (localStorage.getItem(kDownloadList) ?? []).map<Lesson>((item) {
      return Lesson.fromJson(item);
    }).toList();
    downloadModel.setDownloads(downloadList);
    setIdle();
    return downloadList;
  }
}

class DownloadModel with ChangeNotifier {
  DownloadModel() {
    _directoryPath = StorageManager.sharedPreferences.getString(kDirectoryPath);
  }
  List<Lesson> _downloadLesson;
  List<Lesson> get downloadLesson => _downloadLesson;

  setDownloads(List<Lesson> downloadLesson) {
    _downloadLesson = downloadLesson;
    notifyListeners();
  }

  download(Lesson song) {
    if (_downloadLesson.contains(song)) {
      removeFile(song);
    } else {
      downloadFile(song);
    }
  }

  String getLessonUrl(Lesson s) {
    return 'http://music.163.com/song/media/outer/url?id=${s.id}.mp3';
  }
  

  Future downloadFile(Lesson s) async {
    final bytes = await readBytes(getLessonUrl(s));
    final dir = await getApplicationDocumentsDirectory();
    setDirectoryPath(dir.path);
    final file = File('${dir.path}/${s.id}.mp3');

    if (await file.exists()) {
      return;
    }

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      _downloadLesson.add(s);
      saveData();
      notifyListeners();
    }
  }

  String _directoryPath;
  String get getDirectoryPath => _directoryPath;
  setDirectoryPath(String directoryPath) {
    _directoryPath = directoryPath;
    StorageManager.sharedPreferences.setString(kDirectoryPath, _directoryPath);
  }

  Future removeFile(Lesson s) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${s.id}.mp3');
    setDirectoryPath(dir.path);
    if (await file.exists()) {
      await file.delete();
      _downloadLesson.remove(s);
      saveData();
      notifyListeners();
    }
  }

  saveData() async {
    LocalStorage localStorage = LocalStorage(kLocalStorageSearch);
    await localStorage.ready;
    localStorage.setItem(kDownloadList, _downloadLesson);
  }

  isDownload(Lesson newLesson) {
    bool isDownload = false;
    for (int i = 0; i < _downloadLesson.length; i++) {
      if (_downloadLesson[i].id == newLesson.id) {
        isDownload = true;
        break;
      }
    }
    return isDownload;
  }
}
