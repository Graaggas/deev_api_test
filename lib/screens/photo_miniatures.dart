import 'package:deev_api_test/blocs/bloc/photo_bloc.dart';
import 'package:deev_api_test/repo/photo_repo.dart';
import 'package:deev_api_test/screens/photo_widget.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoMiniatures extends StatelessWidget {
  const PhotoMiniatures({Key? key, required this.albumId}) : super(key: key);

  final int albumId;

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<PhotoBloc>(context)
    //     .add(PhotoRequestedEvent(albumId: albumId));

    return Container(
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
        child: RepositoryProvider(
          create: (context) =>
              PhotoRepo(apiClient: APIClient(httpClient: http.Client())),
          child: BlocProvider<PhotoBloc>(
            create: (context) => PhotoBloc(
              photoRepo: context.read<PhotoRepo>(),
            ),
            child: BlocConsumer<PhotoBloc, PhotoState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is PhotoInitial) {
                  BlocProvider.of<PhotoBloc>(context)
                      .add(PhotoRequestedEvent(albumId: albumId));
                }
                if (state is PhotoLoadSuccessState) {
                  return GridView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return PhotoWidget(photo: state.photoList[index]);
                      });
                }
                return Container();
              },
            ),
          ),
        ),

        // BlocConsumer<PhotoBloc, PhotoState>(
        //   listener: (context, state) {},
        //   builder: (context, state) {
        //     if (state is PhotoLoadSuccessState) {
        //       print("PhotoList\n\t albumId = $albumId");
        //       print("PhotoList contents: \n\t ");
        //       state.photoList.forEach((element) {
        //         print("\t\t ${element.id}");
        //       });

        //       return GridView.builder(
        //           itemCount: 3,
        //           shrinkWrap: true,
        //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 3, crossAxisSpacing: 8),
        //           itemBuilder: (context, index) {
        //             return PhotoWidget(photo: state.photoList[index]);
        //           });
        //     }
        //     return Container();
        //   },
        // ),
      ),
    );
  }
}
