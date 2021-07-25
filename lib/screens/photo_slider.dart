import 'package:deev_api_test/blocs/bloc/photo_bloc.dart';
import 'package:deev_api_test/models/photo.dart';
import 'package:deev_api_test/repo/photo_repo.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class PhotoSlider extends StatelessWidget {
  const PhotoSlider({Key? key, required this.albumId}) : super(key: key);

  final int albumId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: RepositoryProvider(
          create: (context) => PhotoRepo(
            apiClient: APIClient(httpClient: http.Client()),
          ),
          child: BlocProvider<PhotoBloc>(
            create: (context) => PhotoBloc(
              photoRepo: context.read<PhotoRepo>(),
            ),
            child: BlocConsumer<PhotoBloc, PhotoState>(
                builder: (context, state) {
                  BlocProvider.of<PhotoBloc>(context)
                      .add(PhotoRequestedEvent(albumId: albumId));

                  if (state is PhotoLoadSuccessState) {
                    return Text(state.photoList[0].url);
                  }

                  if (state is PhotoLoadInProgressState) {
                    return Center(
                      child: JumpingText(
                        'Loading...',
                      ),
                    );
                  }
                  if (state is PhotoInitial) {
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    );
                  }
                  return Container();
                },
                listener: (_, __) {}),
          ),
        ));
  }
}
