import 'package:show_github_users/data/dto/user_detail_dto.dart';
import 'package:show_github_users/data/dto/user_dto.dart';
import 'package:show_github_users/domain/mapper/user.dart';
import 'package:show_github_users/domain/mapper/user_detail.dart';

class Mapper {
  static User toUser(UserDto userDto) {
    return User(
      login: userDto.login,
      id: userDto.id,
      avatarUrl: userDto.avatarUrl,
      name: userDto.name ?? '',
      followersCount: userDto.followersCount ?? 0,
      followingCount: userDto.followingCount ?? 0
    );
  }

  static UserDetail toUserDetail(UserDetailDto userDetailDto) {
    return UserDetail(
        id: userDetailDto.id,
        followers: userDetailDto.followers,
        following: userDetailDto.following);
  }
}
