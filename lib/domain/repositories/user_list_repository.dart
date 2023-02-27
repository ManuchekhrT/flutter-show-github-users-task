import 'package:dartz/dartz.dart';
import '../../commons/errors/failure.dart';
import '../mapper/user.dart';

abstract class UserListRepository {
  Future<Either<Failure, List<User>>> fetchUsers();
}