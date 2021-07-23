import 'package:deev_api_test/blocs/photo_bloc/photo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class PhotoMiniatures extends StatelessWidget {
  const PhotoMiniatures({Key? key, required this.albumId}) : super(key: key);
  final int albumId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoadSuccessState) {
            return Text(state.photoList.toString());
          }
          if (state is PhotoInitial) {
            BlocProvider.of<PhotoBloc>(context)
                .add(PhotoRequestedEvent(albumId: albumId));

            print("INITIAL");
            return Center(
              child: JumpingDotsProgressIndicator(
                color: Colors.black,
                fontSize: 24,
              ),
            );
          }
          if (state is PhotoLoadInProgressState) {
            return Center(
              child: JumpingText(
                'Loading...',
              ),
            );
          }
          if (state is PhotoLsoadFailureState) {
            return Center(
              child: Text("Error loading"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
