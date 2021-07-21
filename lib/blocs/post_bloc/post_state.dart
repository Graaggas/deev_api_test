part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitialState extends PostState {}

class PostLoadInProgressState extends PostState {}

class PostLoadFailureState extends PostState {}

class PostLoadSuccessState extends PostState {
  final List<Post> postList;

  PostLoadSuccessState({required this.postList});

  @override
  List<Object> get props => [
        postList,
      ];
}
