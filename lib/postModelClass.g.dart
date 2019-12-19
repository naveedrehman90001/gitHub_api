// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    login: json['login'] as String,
    followers: json['followers'] as int,
    following: json['following'] as int,
    avatar_url: json['avatar_url'] as String,
    repoUrl: json['repoUrl'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'login': instance.login,
      'followers': instance.followers,
      'following': instance.following,
      'imageUrl': instance.avatar_url,
      'repoUrl': instance.repoUrl,
    };
