part of 'photos_bloc.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class ChangeIndexState extends PhotosState {}

class GetPhotosLoading extends PhotosState {}

class GetPhotosSuccess extends PhotosState {
  final List<Photos> photos;

  GetPhotosSuccess({required this.photos});
}

class GetPhotosFailure extends PhotosState {
  final String error;

  GetPhotosFailure({required this.error});
}

class SearchPhotosLoading extends PhotosState {}

class SearchPhotosSuccess extends PhotosState {
  final Search search;

  SearchPhotosSuccess({required this.search});
}

class SearchPhotosFailure extends PhotosState {
  final String error;

  SearchPhotosFailure({required this.error});
}

class FavoriteState extends PhotosState {}

class DownloadState extends PhotosState {}

class DownloadImageLoading extends PhotosState {}

class DownloadImageSuccess extends PhotosState {}

class DownloadImageFailure extends PhotosState {
  final String error;

  DownloadImageFailure({required this.error});
}
