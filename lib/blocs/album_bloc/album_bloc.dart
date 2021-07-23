import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deev_api_test/models/album.dart';
import 'package:deev_api_test/repo/album_repo.dart';
import 'package:equatable/equatable.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc({required this.albumRepo}) : super(AlbumsInitialState());

  final AlbumRepo albumRepo;

  @override
  Stream<AlbumState> mapEventToState(
    AlbumEvent event,
  ) async* {
    if (event is AlbumRequestedEvent) {
      yield AlbumLoadInProgressState();
      try {
        final List<AlbumPhoto> albumList =
            await albumRepo.getAlbums(event.userId);
        yield AlbumLoadSuccessState(albumList: albumList);
      } catch (e) {
        yield AlbumLsoadFailureState();
      }
    }
  }
}
