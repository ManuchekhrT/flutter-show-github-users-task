import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_github_users/presentation/user_list_bloc.dart';
import 'package:show_github_users/presentation/user_list_search.dart';
import 'package:show_github_users/presentation/user_list_state.dart';
import 'user_list_item.dart';
import '../../../../injection_container.dart' as di;
import '../domain/mapper/user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;
  List<User> users = [];

  final int tabCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabCount, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserListCubit>(
            create: (BuildContext context) => di.sl<UserListCubit>(),
          )
        ],
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('GitHub Users'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: UserListSearch(users: users));
                  },
                )
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'A-H'),
                  Tab(text: 'I-P'),
                  Tab(text: 'Q-Z'),
                ],
              ),
            ),
            body: BlocBuilder<UserListCubit, UserListState>(
              builder: (context, state) {
                if (state is UserListInitial) {
                  _loadGithubUsers(context);
                  return Container();
                } else if (state is UserListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is UserListSuccess) {
                  users = state.users;
                  final aToH = filterUsers(users, 'A', 'H');
                  final iToP = filterUsers(users, 'I', 'P');
                  final qToZ = filterUsers(users, 'Q', 'Z');
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      ListView(
                        children: [
                          if (aToH.isNotEmpty) _buildUserList(aToH),
                        ],
                      ),
                      ListView(
                        children: [
                          if (iToP.isNotEmpty) _buildUserList(iToP),
                        ],
                      ),
                      ListView(
                        children: [
                          if (qToZ.isNotEmpty) _buildUserList(qToZ),
                        ],
                      ),
                    ],
                  );
                } else if (state is UserListError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const Center(
                    child: Text('Unknown state'),
                  );
                }
              },
            ),
          );
        }));
  }

  Widget _buildUserList(List<User> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final user in users) UserListItem(user: user),
      ],
    );
  }

  List<User> filterUsers(List<User> users, String startLetter, String endLetter) {
    final newUsers = users.where((user) {
      final name = user.name ?? '';
      final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '';

      return firstLetter.compareTo(startLetter) >= 0 &&
          firstLetter.compareTo(endLetter) <= 0;
    }).toList();
    newUsers.sort((a, b) => a.name.compareTo(b.name));
    return newUsers;
  }

  void _loadGithubUsers(BuildContext context) {
    final cubit = context.read<UserListCubit>();
    cubit.fetchUsers();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}