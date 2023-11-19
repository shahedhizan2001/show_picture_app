import 'package:injectable/injectable.dart';
import 'package:photo_app/feature/photo/domain/repo/repo.dart';

import '../infrastructure/data_source/model/photos.dart';
import '../infrastructure/data_source/model_search/search_model.dart';

@injectable
class PhotosFacade {
  final IPhotosRepo _repo;

  PhotosFacade({required IPhotosRepo repo}) : _repo = repo;

  Future<List<Photos>> getPhotos(int page,int pageSize) async {
    final result = await _repo.getPhotos(page,pageSize);
    return result;
  }
  Future<Search> searchPhoto({required String query, required int page})async{
    return await _repo.searchPhoto(query: query,page: page);
  }
  Future downloadPhotos({required String url}) async{
    return await _repo.downloadPhotos(url: url);
  }
}
