import 'package:flutter/material.dart';
import '../domain/mapper/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.name,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.followersCount} / ${user.followingCount}',
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w400)),
          ],
        ));
  }
}
