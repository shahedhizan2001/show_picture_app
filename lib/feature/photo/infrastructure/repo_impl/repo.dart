import 'package:injectable/injectable.dart';
import 'package:photo_app/feature/photo/domain/repo/repo.dart';
import 'package:photo_app/feature/photo/infrastructure/data_source/model/photos.dart';
import 'package:photo_app/feature/photo/infrastructure/remote/remote.dart';

import '../data_source/model_search/search_model.dart';

@Injectable(as :IPhotosRepo)
class RepoImpl extends IPhotosRepo{
  final PhotoRemote _remote;

  RepoImpl({required PhotoRemote remote}) : _remote = remote;

  @override
  Future<List<Photos>> getPhotos(int page,int pageSize) async{
    final result= await _remote.getPhotos(page,pageSize);
    return result;
  }
  Future<Search> searchPhoto({required String query, required int page})async{
    return await _remote.searchPhoto(query: query,page: page);
  }

  @override
  Future downloadPhotos({required String url}) async{
   return await _remote.downloadPhotos(url: url);
  }

}