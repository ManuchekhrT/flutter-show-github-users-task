import 'package:dartz/dartz.dart';
import 'package:show_github_users/commons/errors/failure.dart';
import 'package:show_github_users/data/datasources/user_list_datasource.dart';
import 'package:show_github_users/domain/mapper/mapper.dart';
import 'package:show_github_users/domain/mapper/user.dart';
import 'package:show_github_users/domain/repositories/user_list_repository.dart';
import '../../commons/network/network_info.dart';

class UserListRepositoryImpl implements UserListRepository {
  final NetworkInfo networkInfo;
  final UserListDatasource userListDatasource;

  UserListRepositoryImpl(
      {required this.networkInfo, required this.userListDatasource});

  @override
  Future<Either<Failure, List<User>>> fetchUsers() async {
    try {
      final users = await userListDatasource.fetchUsers();
      final newUsers = users.map((e) => Mapper.toUser(e)).toList();
      return Right(newUsers);
    } catch (e) {
      return Left(Failure());
    }
  }
}
