import 'package:flutter/material.dart';

import '../domain/mapper/user.dart';

class UserListSearch extends SearchDelegate<String?> {
  final List<User> users;

  UserListSearch({required this.users});

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for AppBar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the results based on the search query
    final results = users.where((element) => element.name.contains(query));
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(results.elementAt(index).name),
          onTap: () {
            close(context, results.elementAt(index).name);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    final suggestions =
    users.where((element) => element.name.toLowerCase().startsWith(query));
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(suggestions.elementAt(index).name),
          onTap: () {
            close(context, suggestions.elementAt(index).name);
          },
        );
      },
    );
  }
}