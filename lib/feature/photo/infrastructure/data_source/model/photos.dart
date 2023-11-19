// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'photos.freezed.dart';
part 'photos.g.dart';

List<Photos> photosFromJson(List<dynamic> list) => List<Photos>.from(list.map((x) => Photos.fromJson(x)));

String photosToJson(List<Photos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Photos with _$Photos {
  const factory Photos({
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
    List<dynamic>? breadcrumbs,
    Urls? urls,
    PhotosLinks? links,
    int? likes,
    bool? likedByUser,
    List<dynamic>? currentUserCollections,
    Sponsorship? sponsorship,
    TopicSubmissions? topicSubmissions,
    User? user,
  }) = _Photos;

  factory Photos.fromJson(Map<String, dynamic> json) => _$PhotosFromJson(json);
}

@freezed
class PhotosLinks with _$PhotosLinks {
  const factory PhotosLinks({
    String? self,
    String? html,
    String? download,
    String? downloadLocation,
  }) = _PhotosLinks;

  factory PhotosLinks.fromJson(Map<String, dynamic> json) => _$PhotosLinksFromJson(json);
}

@freezed
class Sponsorship with _$Sponsorship {
  const factory Sponsorship({
    List<String>? impressionUrls,
    String? tagline,
    String? taglineUrl,
    User? sponsor,
  }) = _Sponsorship;

  factory Sponsorship.fromJson(Map<String, dynamic> json) => _$SponsorshipFromJson(json);
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
class TopicSubmissions with _$TopicSubmissions {
  const factory TopicSubmissions({
    Nature? nature,
  }) = _TopicSubmissions;

  factory TopicSubmissions.fromJson(Map<String, dynamic> json) => _$TopicSubmissionsFromJson(json);
}

@freezed
class Nature with _$Nature {
  const factory Nature({
    String? status,
  }) = _Nature;

  factory Nature.fromJson(Map<String, dynamic> json) => _$NatureFromJson(json);
}

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