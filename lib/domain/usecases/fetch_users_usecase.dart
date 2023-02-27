import 'package:dartz/dartz.dart';
import 'package:show_github_users/domain/mapper/user.dart';
import '../../commons/errors/failure.dart';
import '../repositories/user_list_repository.dart';

class FetchUsersUseCase {
  final UserListRepository repository;

  FetchUsersUseCase({required this.repository});

  Future<Either<Failure, List<User>>> call() async {
    return repository.fetchUsers();
  }
}