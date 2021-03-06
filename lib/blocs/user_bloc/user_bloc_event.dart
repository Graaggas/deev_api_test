part of 'user_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

class UserBlocRequestedEvent extends UserBlocEvent {
  @override
  List<Object> get props => [];
}

class UserBlocInitialRequestedEvent extends UserBlocEvent {
  @override
  List<Object> get props => [];
}
