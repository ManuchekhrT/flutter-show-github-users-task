import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;

  String name;
  int followersCount;
  int followingCount;

  User({
    required this.login,
    required this.id,
    required this.avatarUrl,

    required this.name,
    required this.followersCount,
    required this.followingCount
  });

  @override
  List<Object?> get props => [id, login, avatarUrl];
}