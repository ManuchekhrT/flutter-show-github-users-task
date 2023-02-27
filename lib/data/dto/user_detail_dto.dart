import 'package:equatable/equatable.dart';

class UserDetailDto extends Equatable {
  final int id;
  final int followers;
  final int following;
  final String name;

  const UserDetailDto({
    required this.id,
    required this.followers,
    required this.following,
    required this.name
  });

  @override
  List<Object?> get props => [id, followers, following, name];


  factory UserDetailDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDto(
      id: json['id'],
      followers: json['followers'],
      following: json['following'],
      name: json['name']
    );
  }
}