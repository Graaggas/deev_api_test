part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumsInitialState extends AlbumState {}

class AlbumLoadInProgressState extends AlbumState {}

class AlbumLsoadFailureState extends AlbumState {}

class AlbumLoadSuccessState extends AlbumState {
  final List<AlbumPhoto> albumList;

  AlbumLoadSuccessState({required this.albumList});

  @override
  List<Object> get props => [
        albumList,
      ];
}
