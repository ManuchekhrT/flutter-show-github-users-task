import 'package:bloc/bloc.dart';
import 'package:show_github_users/domain/usecases/fetch_users_usecase.dart';
import 'package:show_github_users/presentation/user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final FetchUsersUseCase fetchUsersUseCase;

  UserListCubit({required this.fetchUsersUseCase}) : super(UserListInitial());

  void fetchUsers() async {
    // Show loading
    emit(UserListLoading());

    // Fetch the list
    final usersResult = await fetchUsersUseCase();

    // Handle success or error
    final updatedState = usersResult.fold(
          (e) => const UserListError("Fetching users error"),
          (list) => UserListSuccess(list),
    );

    emit(updatedState);
  }
}
