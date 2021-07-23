part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoadInProgressState extends PhotoState {}

class PhotoLsoadFailureState extends PhotoState {}

class PhotoLoadSuccessState extends PhotoState {
  final List<Photo> photoList;

  PhotoLoadSuccessState({required this.photoList});

  @override
  List<Object> get props => [
        photoList,
      ];
}
