import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deev_api_test/models/user.dart';
import 'package:deev_api_test/repo/user_repo.dart';
import 'package:equatable/equatable.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserRepo userRepo;

  UserBloc({required this.userRepo}) : super(UserBlocInitialState());

  @override
  Stream<UserBlocState> mapEventToState(
    UserBlocEvent event,
  ) async* {
    if (event is UserBlocRequestedEvent) {
      yield UserBlocLoadInProgressState();
      try {
        final List<User> usersList = await userRepo.getUsers();
        yield UserBlocLoadSuccessState(userList: usersList);
      } catch (e) {
        yield UserBlocLoadFailureState();
      }
    }
  }
}
