import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/feature/photo/infrastructure/data_source/model_search/search_model.dart';

import '../data_source/model/photos.dart';

@injectable
class PhotoRemote {
  final _dio = Dio();

  Future<List<Photos>> getPhotos(int page , int pageSize) async {
    try {
      final response = await _dio.get(
          "https://api.unsplash.com/photos/?client_id=15m_zdELDVazk0kEKXlH4wPd_hU4syxDq1Ta5Hg440M&&page=$page&&per_page=$pageSize");
      final result=photosFromJson(response.data);
      return result;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<Search> searchPhoto({required String query, required int page}) async {
    try {
      final response = await _dio.get(
          "https://api.unsplash.com/search/photos/?client_id=15m_zdELDVazk0kEKXlH4wPd_hU4syxDq1Ta5Hg440M&&page=$page&&query=$query");
      print(response.data.toString());
      return Search.fromJson(response.data);
    } catch (errror) {
      print(errror.toString());
      throw errror;
    }
  }

  Future<void> downloadPhotos({required String url}) async {
    var status = await Permission.storage.request();
    try {
      if (status.isGranted) {
        final response = await _dio.get(
          url,
          options: Options(responseType: ResponseType.bytes),
        );
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello",
        );
        print(result);
      } else {
        throw Exception('Storage permission denied');
      }
    } catch (error) {
      print(error.toString());
    }
  }
}



