part of 'photos_bloc.dart';

@immutable
abstract class PhotosEvent {}

class GetPhotos extends PhotosEvent {
  final int page;
  final int pageSize;

  GetPhotos({required this.pageSize, required this.page});
}

class GetFavourite extends PhotosEvent {

  GetFavourite();
}

class GetDownload extends PhotosEvent {

  GetDownload();
}
class GhangeIndex extends PhotosEvent{
  final int index;

  GhangeIndex({required this.index});
}
class SearchPhotos extends PhotosEvent {
  final String query;
  final int page;

  SearchPhotos({required this.page,required this.query});
}
class Favorite extends PhotosEvent {
 final String photoUrl;


  Favorite({required this.photoUrl});}

class DownloadPhotos extends PhotosEvent {
  final String url;


  DownloadPhotos({required this.url});}