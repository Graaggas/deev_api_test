part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class PhotoRequestedEvent extends PhotoEvent {
  final int albumId;
  PhotoRequestedEvent({required this.albumId});

  @override
  List<Object> get props => [
        albumId,
      ];
}
