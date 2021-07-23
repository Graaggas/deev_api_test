import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deev_api_test/models/photo.dart';
import 'package:deev_api_test/repo/photo_repo.dart';
import 'package:equatable/equatable.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc({required this.photoRepo}) : super(PhotoInitial());
  final PhotoRepo photoRepo;

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    if (event is PhotoRequestedEvent) {
      yield PhotoLoadInProgressState();
      try {
        // final List<Photo> photoList = await photoRepo.getPhotos(event.albumId);
        final List<Photo> photoList = await photoRepo.getPhotos(event.albumId);
        print("photoInProgress//");
        yield PhotoLoadSuccessState(photoList: []);
      } catch (e) {
        print("error photo load: $e");
        yield PhotoLsoadFailureState();
      }
    }
  }
}
