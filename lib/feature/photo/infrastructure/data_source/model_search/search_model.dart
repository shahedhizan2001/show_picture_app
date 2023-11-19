// To parse this JSON data, do
//
//     final photos = photosFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'search_model.freezed.dart';
part 'search_model.g.dart';

Search searchFromJson(String str) =>Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

@freezed
class Search with _$Search {
  const factory Search({
    int? total,
    int? totalPages,
    List<Result>? results,
  }) = _Search;

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    String? id,
    String? slug,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? promotedAt,
    int? width,
    int? height,
    String? color,
    String? blurHash,
    String? description,
    String? altDescription,
    List<Breadcrumb>? breadcrumbs,
    Urls? urls,
    ResultLinks? links,
    int? likes,
    bool? likedByUser,
    List<dynamic>? currentUserCollections,
    dynamic sponsorship,
    ResultTopicSubmissions? topicSubmissions,
    User? user,
    List<Tag>? tags,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class Breadcrumb with _$Breadcrumb {
  const factory Breadcrumb({
    String? slug,
    String? title,
    int? index,
    Type? type,
  }) = _Breadcrumb;

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => _$BreadcrumbFromJson(json);
}

enum Type {
  landing_page,
  search
}

final typeValues = EnumValues({
  "landing_page": Type.landing_page,
  "search": Type.search
});

@freezed
class ResultLinks with _$ResultLinks {
  const factory ResultLinks({
    String? self,
    String? html,
    String? download,
    String? downloadLocation,
  }) = _ResultLinks;

  factory ResultLinks.fromJson(Map<String, dynamic> json) => _$ResultLinksFromJson(json);
}

@freezed
class Tag with _$Tag {
  const factory Tag({
    Type? type,
    String? title,
    Source? source,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
class Source with _$Source {
  const factory Source({
    Ancestry? ancestry,
    String? title,
    String? subtitle,
    String? description,
    String? metaTitle,
    String? metaDescription,
    CoverPhoto? coverPhoto,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}

@freezed
class Ancestry with _$Ancestry {
  const factory Ancestry({
    Category? type,
    Category? category,
    Category? subcategory,
  }) = _Ancestry;

  factory Ancestry.fromJson(Map<String, dynamic> json) => _$AncestryFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    String? slug,
    String? prettySlug,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@freezed
class CoverPhoto with _$CoverPhoto {
  const factory CoverPhoto({
    String? id,
    String? slug,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? promotedAt,
    int? width,
    int? height,
    String? color,
    String? blurHash,
    String? description,
    String? altDescription,
    List<Breadcrumb>? breadcrumbs,
    Urls? urls,
    ResultLinks? links,
    int? likes,
    bool? likedByUser,
    List<dynamic>? currentUserCollections,
    dynamic sponsorship,
    CoverPhotoTopicSubmissions? topicSubmissions,
    bool? premium,
    bool? plus,
    User? user,
  }) = _CoverPhoto;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => _$CoverPhotoFromJson(json);
}
@freezed
class CoverPhotoTopicSubmissions with _$CoverPhotoTopicSubmissions {
  const factory CoverPhotoTopicSubmissions({
    ArtsCulture? texturesPatterns,
    ArtsCulture? currentEvents,
    ArtsCulture? nature,
    ArtsCulture? people,
  }) = _CoverPhotoTopicSubmissions;

  factory CoverPhotoTopicSubmissions.fromJson(Map<String, dynamic> json) => _$CoverPhotoTopicSubmissionsFromJson(json);
}

@freezed
class ArtsCulture with _$ArtsCulture {
  const factory ArtsCulture({
    Status? status,
    DateTime? approvedOn,
  }) = _ArtsCulture;

  factory ArtsCulture.fromJson(Map<String, dynamic> json) => _$ArtsCultureFromJson(json);
}

enum Status {
  APPROVED
}

final statusValues = EnumValues({
  "approved": Status.APPROVED
});

@freezed
class Urls with _$Urls {
  const factory Urls({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    String? smallS3,
  }) = _Urls;

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    String? id,
    DateTime? updatedAt,
    String? username,
    String? name,
    String? firstName,
    String? lastName,
    String? twitterUsername,
    String? portfolioUrl,
    String? bio,
    String? location,
    UserLinks? links,
    ProfileImage? profileImage,
    String? instagramUsername,
    int? totalCollections,
    int? totalLikes,
    int? totalPhotos,
    bool? acceptedTos,
    bool? forHire,
    Social? social,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserLinks with _$UserLinks {
  const factory UserLinks({
    String? self,
    String? html,
    String? photos,
    String? likes,
    String? portfolio,
    String? following,
    String? followers,
  }) = _UserLinks;

  factory UserLinks.fromJson(Map<String, dynamic> json) => _$UserLinksFromJson(json);
}

@freezed
class ProfileImage with _$ProfileImage {
  const factory ProfileImage({
    String? small,
    String? medium,
    String? large,
  }) = _ProfileImage;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => _$ProfileImageFromJson(json);
}

@freezed
class Social with _$Social {
  const factory Social({
    String? instagramUsername,
    String? portfolioUrl,
    String? twitterUsername,
    dynamic paypalEmail,
  }) = _Social;

  factory Social.fromJson(Map<String, dynamic> json) => _$SocialFromJson(json);
}

@freezed
class ResultTopicSubmissions with _$ResultTopicSubmissions {
  const factory ResultTopicSubmissions({
    ArtsCulture? people,
    Nature? nature,
    ArtsCulture? travel,
    Nature? streetPhotography,
    ArtsCulture? spirituality,
    ArtsCulture? artsCulture,
  }) = _ResultTopicSubmissions;

  factory ResultTopicSubmissions.fromJson(Map<String, dynamic> json) => _$ResultTopicSubmissionsFromJson(json);
}

@freezed
class Nature with _$Nature {
  const factory Nature({
    String? status,
  }) = _Nature;

  factory Nature.fromJson(Map<String, dynamic> json) => _$NatureFromJson(json);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}