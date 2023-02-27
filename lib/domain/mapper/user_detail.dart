import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final int id;
  final int followers;
  final int following;

  const UserDetail({
    required this.id,
    required this.followers,
    required this.following
  });

  @override
  List<Object?> get props => [id, followers, following];
}