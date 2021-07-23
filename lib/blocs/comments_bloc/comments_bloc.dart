import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deev_api_test/models/comment.dart';
import 'package:deev_api_test/repo/comment_repo.dart';
import 'package:equatable/equatable.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.commentRepo}) : super(CommentsInitialState());
  final CommentRepo commentRepo;

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is CommentsRequestedEvent) {
      yield CommentsLoadInProgressState();
      try {
        final List<Comment> commentList =
            await commentRepo.getComments(event.postId);
        yield CommentsLoadSuccessState(commentList: commentList);
      } catch (e) {
        yield CommentsoadFailureState();
      }
    }

    if (event is CommentPostEvent) {
      yield CommentPostInProgressState();
      try {
        await commentRepo.postComment(event.comment);
        yield CommentsPostSuccessState();
      } catch (e) {
        yield CommentsPostFailureState();
      }
    }
  }
}
