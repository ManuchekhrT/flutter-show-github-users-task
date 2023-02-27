import 'package:show_github_users/data/dto/user_dto.dart';

abstract class UserListDatasource {
  Future<List<UserDto>> fetchUsers();
}