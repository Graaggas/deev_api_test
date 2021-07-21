part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostRequestedEvent extends PostEvent {
  final int userId;

  PostRequestedEvent({required this.userId});

  @override
  List<Object> get props => [
        userId,
      ];
}
