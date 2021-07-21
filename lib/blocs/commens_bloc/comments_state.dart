part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitialState extends CommentsState {}

class CommentsLoadInProgressState extends CommentsState {}

class CommentsoadFailureState extends CommentsState {}

class CommentsLoadSuccessState extends CommentsState {
  final List<Comment> commentList;

  CommentsLoadSuccessState({required this.commentList});

  @override
  List<Object> get props => [
        commentList,
      ];
}
