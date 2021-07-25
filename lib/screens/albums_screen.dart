import 'package:deev_api_test/blocs/album_bloc/album_bloc.dart';
import 'package:deev_api_test/blocs/bloc/photo_bloc.dart';
import 'package:deev_api_test/models/album.dart';
import 'package:deev_api_test/repo/photo_repo.dart';
import 'package:deev_api_test/screens/photo_widget.dart';
import 'package:http/http.dart' as http;
import 'package:deev_api_test/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserId: $userId"),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumsInitialState) {
            return Center(
              child: JumpingDotsProgressIndicator(
                color: Colors.black,
                fontSize: 24,
              ),
            );
          }
          if (state is AlbumLoadInProgressState) {
            return Center(
              child: JumpingText(
                'Loading...',
              ),
            );
          }
          if (state is AlbumLoadSuccessState) {
            return ListView.builder(
                shrinkWrap: true,
                // physics: ScrollPhysics(),
                itemCount: state.albumList.length,
                itemBuilder: (context, index) {
                  var albumId = state.albumList[index].id;

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/photo_slider', arguments: albumId);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.albumList[index].title),
                                ],
                              ),
                              Text(
                                  "Id: ${state.albumList[index].id.toString()}"),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
