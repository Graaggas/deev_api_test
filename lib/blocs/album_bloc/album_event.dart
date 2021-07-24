part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class AlbumRequestedEvent extends AlbumEvent {
  AlbumRequestedEvent({required this.userId});
  final int userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
