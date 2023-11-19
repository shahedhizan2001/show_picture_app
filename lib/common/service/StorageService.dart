import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late final SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setFavorite(List<String> favorite) async =>
      await _sharedPreferences.setStringList('favorite', favorite);

  static List<String>? getFavorite =
      _sharedPreferences.getStringList('favorite');

  static Future<bool> setDownloadPhotos(List<String> download) async =>
      await _sharedPreferences.setStringList('download', download);

  static List<String>? getDownloadPhotos =
  _sharedPreferences.getStringList('download');


}
