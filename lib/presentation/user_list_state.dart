import 'package:equatable/equatable.dart';

import '../domain/mapper/user.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListError extends UserListState {
  final String errorMessage;

  const UserListError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class UserListSuccess extends UserListState {
  final List<User> users;

  const UserListSuccess(this.users);

  @override
  List<Object> get props => [users];
}


