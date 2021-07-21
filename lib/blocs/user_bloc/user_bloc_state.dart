part of 'user_bloc.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();

  @override
  List<Object> get props => [];
}

class UserBlocInitialState extends UserBlocState {}

class UserBlocLoadInProgressState extends UserBlocState {}

class UserBlocLoadFailureState extends UserBlocState {}

class UserBlocLoadSuccessState extends UserBlocState {
  final List<User> userList;

  UserBlocLoadSuccessState({required this.userList});

  @override
  List<Object> get props => [
        userList,
      ];
}
