import '../../infrastructure/data_source/model/photos.dart';
import '../../infrastructure/data_source/model_search/search_model.dart';

abstract class IPhotosRepo{
  Future<List<Photos>> getPhotos(int page,int pageSize);
  Future<Search> searchPhoto({required String query, required int page} );
  Future downloadPhotos({required String url});
}