import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:show_github_users/data/datasources/user_list_datasource.dart';
import 'package:show_github_users/data/dto/user_detail_dto.dart';
import 'package:show_github_users/data/dto/user_dto.dart';
import '../../commons/exceptions/exceptions.dart';

class UserListDatasourceImpl implements UserListDatasource {
  static const String baseUrl = 'https://api.github.com';
  static const String bearerToken = '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';

  final http.Client client;
  final Map<String, String> headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': 'Bearer $bearerToken',
    'X-GitHub-Api-Version': '2022-11-28'
  };

  UserListDatasourceImpl({required this.client});

  @override
  Future<List<UserDto>> fetchUsers() async {
    final url = Uri.parse('$baseUrl/users');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<UserDto> usersDto = [];
      for (final user in data) {
        final userDetailResponse = await http.get(
            Uri.parse('$baseUrl/users/${user['login']}'),
            headers: headers);
        if (userDetailResponse.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(userDetailResponse.body);
          final UserDetailDto userDetailDto = UserDetailDto.fromJson(data);
          usersDto.add(UserDto(
              login: user['login'],
              id: user['id'],
              avatarUrl: user['avatar_url'],
              name: userDetailDto.name,
              followingCount: userDetailDto.following,
              followersCount: userDetailDto.followers));
        }
      }
      return usersDto;
    } else {
      throw ServerException();
    }
  }
}
