import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deev_api_test/models/post.dart';
import 'package:deev_api_test/repo/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepo postRepo;
  PostBloc({required this.postRepo}) : super(PostsInitialState());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostRequestedEvent) {
      yield PostLoadInProgressState();
      try {
        final List<Post> postsList = await postRepo.getPosts(event.userId);
        yield PostLoadSuccessState(postList: postsList);
      } catch (e) {
        yield PostsLoadFailureState();
      }
    }
    if (event is PostSetInitialEvent) {
      yield PostsInitialState();
    }
  }
}
