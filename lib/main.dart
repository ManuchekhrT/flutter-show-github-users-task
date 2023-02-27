import 'package:flutter/material.dart';
import 'package:show_github_users/presentation/user_list_page.dart';
import 'injection_container.dart' as di;


void main() async {
  // Initialize the injection container
  await di.init();

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * USED by the plain Provider version
    return
      MaterialApp(
        title: 'GitHub User Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserListPage(),
      );
  }
}
