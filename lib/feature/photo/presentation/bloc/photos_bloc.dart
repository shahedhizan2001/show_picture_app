import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:photo_app/common/service/StorageService.dart';
import 'package:photo_app/feature/photo/infrastructure/data_source/model_search/search_model.dart';
import 'package:photo_app/feature/photo/presentation/ui/screens/download_screen.dart';
import 'package:photo_app/feature/photo/presentation/ui/screens/favorite_screen.dart';
import 'package:photo_app/feature/photo/presentation/ui/screens/photos_screen.dart';

import '../../application/facade.dart';
import '../../infrastructure/data_source/model/photos.dart';

part 'photos_event.dart';

part 'photos_state.dart';

@injectable
class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosFacade _photosFacade;

  PhotosBloc(this._photosFacade) : super(PhotosInitial()) {
    on<GetPhotos>(getPhotosEvent);
    on<GhangeIndex>(changeIndexEvent);
    on<Favorite>(Favorites);
    on<DownloadPhotos>(downloadPhoto);
    on<GetFavourite>(getFAvourite);
    on<GetDownload>(getDownloadPhotos);

    // on<SearchPhotos>(searchPhotosEvent);
  }

  changeIndexEvent(GhangeIndex event, Emitter emit) {
    value = event.index;
    emit(ChangeIndexState());
  }

  getFAvourite(event, emit) {
    favoriteList = StorageService.getFavorite!;
    emit(FavoriteState());
  }

  getDownloadPhotos(event, emit) {
    downloadList = StorageService.getDownloadPhotos!;
    emit(DownloadState());
  }

  void Favorites(Favorite event, Emitter emit) {
    favoriteList = StorageService.getFavorite!;
    if (!favoriteList.contains(event.photoUrl)) {
      favoriteList.add(event.photoUrl);
      StorageService.setFavorite(favoriteList);
    } else {
      favoriteList.remove(event.photoUrl);
      StorageService.setFavorite(favoriteList);
    }
    print(StorageService.getFavorite);
    emit(FavoriteState());
  }

  downloadPhoto(DownloadPhotos event, Emitter emit) async {
    emit(DownloadImageLoading());
    await _photosFacade.downloadPhotos(url: event.url).then((value) {
    downloadList.add(event.url);
      StorageService.setDownloadPhotos(downloadList);
      emit(DownloadImageSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(DownloadImageFailure(error: "failed"));
    });
  }

  getPhotosEvent(GetPhotos event, Emitter emit) async{
    emit(GetPhotosLoading());
   await _photosFacade.getPhotos(event.page,event.pageSize).then((value) {
      print(value);
      emit(GetPhotosSuccess(photos: value));
    }).catchError((error) {
      print(error.toString());
      emit(GetPhotosFailure(error: "Failed"));
    });
  }
  // searchPhotosEvent(SearchPhotos event, Emitter emit) async{
  //   emit(SearchPhotosLoading());
  //   await _photosFacade.searchPhoto(query: event.query,page: event.page).then((value) {
  //     emit(SearchPhotosSuccess(search: value));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SearchPhotosFailure(error: "Failed"));
  //   });
  // }
  List<String> downloadList = [];
  List<String> favoriteList = [];
  int value = 0;
  final List<Photos> allPhotos = [];
  final List<Result> searchPhotos = [];
  final List screens = [PhotosPage(), FavoriteScreen(), DownloadScreen()];
}
