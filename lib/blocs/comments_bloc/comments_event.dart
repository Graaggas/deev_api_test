part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class CommentsRequestedEvent extends CommentsEvent {
  final int postId;

  CommentsRequestedEvent({required this.postId});

  @override
  List<Object> get props => [
        postId,
      ];
}

class CommentPostEvent extends CommentsEvent {
  final Comment comment;

  CommentPostEvent({required this.comment});
  @override
  List<Object> get props => [
        comment,
      ];
}
