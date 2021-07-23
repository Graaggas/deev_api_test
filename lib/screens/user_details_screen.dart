import 'package:deev_api_test/blocs/album_bloc/album_bloc.dart';
import 'package:deev_api_test/blocs/photo_bloc/photo_bloc.dart';
import 'package:deev_api_test/blocs/post_bloc/post_bloc.dart';
import 'package:deev_api_test/models/post.dart';
import 'package:deev_api_test/models/user.dart';
import 'package:deev_api_test/screens/photo_miniatures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(PostRequestedEvent(userId: user.id));
    BlocProvider.of<AlbumBloc>(context)
        .add(AlbumForUserRequestedEvent(userId: user.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text(user.name),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.email),
                    SizedBox(
                      width: 10,
                    ),
                    Text(user.email),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10,
                    ),
                    Text(user.phone),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.web),
                    SizedBox(
                      width: 10,
                    ),
                    Text(user.website),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Company:"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 30.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.people),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(user.company.name),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.task),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(user.company.bs),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.spellcheck_sharp),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "''${user.company.catchPhrase}''",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Address:"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 30.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_city),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(user.address.city),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.streetview),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(user.address.street),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.roofing),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user.address.suite,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.code),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user.address.zipcode,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_history),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user.address.geo.lat,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user.address.geo.lng,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Posts"),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/posts_page_screen',
                            arguments: user.id);
                      },
                      child: Text("View all"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<PostBloc, PostState>(listener: (context, state) {
                // print("listener, state is ${state.toString()}");
              }, builder: (context, state) {
                if (state is PostsInitialState) {
                  return Center(
                    child: JumpingDotsProgressIndicator(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  );
                }
                if (state is PostLoadInProgressState) {
                  return Center(
                    child: JumpingText(
                      'Loading...',
                    ),
                  );
                }
                if (state is PostLoadSuccessState) {
                  // return Text(state.postList[0].body);
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    state.postList[index].title,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.postList[index].body,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                if (state is PostsLoadFailureState) {
                  return Center(
                    child: Text("Error loading"),
                  );
                }
                return Container();
              }),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Albums"),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("View all"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
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
                if (state is AlbumForUserLoadSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return PhotoMiniatures(
                            albumId: state.albumList[index].id);
                        // BlocProvider.of<PhotoBloc>(context).add(
                        //     PhotoRequestedEvent(
                        //         albumId: state.albumList[index].id));

                        // return Container(
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: Colors.black26,
                        //     border: Border.all(
                        //       color: Colors.black26,
                        //       width: 1,
                        //     ),
                        //     borderRadius: BorderRadius.circular(4),
                        //   ),
                        //   child: BlocConsumer<PhotoBloc, PhotoState>(
                        //     listener: (context, state) {
                        //       print("LISTENER");
                        //     },
                        //     builder: (context, state) {
                        //       if (state is PhotoLoadSuccessState) {
                        //         return Text(
                        //             state.photoList[index].id.toString());
                        //       }
                        //       if (state is PhotoInitial) {
                        //         return Center(
                        //           child: JumpingDotsProgressIndicator(
                        //             color: Colors.black,
                        //             fontSize: 24,
                        //           ),
                        //         );
                        //       }
                        //       if (state is PhotoLoadInProgressState) {
                        //         return Center(
                        //           child: JumpingText(
                        //             'Loading...',
                        //           ),
                        //         );
                        //       }
                        //       if (state is PhotoLsoadFailureState) {
                        //         return Center(
                        //           child: Text("Error loading"),
                        //         );
                        //       }

                        //       return Container();
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  );
                }

                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
