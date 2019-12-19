import 'package:json_annotation/json_annotation.dart';

part 'postModelClass.g.dart';

@JsonSerializable()
class Post {
  final String login;
  final int followers;
  final int following;
  final String avatar_url;
  final String repoUrl;

  Post(
      {this.login,
      this.followers,
      this.following,
      this.avatar_url,
      this.repoUrl});

//  factory Post.fromJson(Map<String, dynamic> json) {
//    return Post(
//      login: json['login'],
//      followers: json['followers'],
//      following: json['following'],
//      imageUrl: json['avatar_url'],
//      repoUrl: json['repos_url'],
//    );
//  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
