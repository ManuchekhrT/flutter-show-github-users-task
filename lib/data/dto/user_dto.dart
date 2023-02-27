import 'package:equatable/equatable.dart';

class UserDto extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;

  String? name = '';
  int? followingCount = 0;
  int? followersCount = 0;

  UserDto({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.followingCount,
    required this.followersCount
  });

  @override
  List<Object?> get props => [id, login];

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],

      name: '',
      followingCount: 0,
      followersCount: 0,
    );
  }
}