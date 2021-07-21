import 'package:deev_api_test/blocs/post_bloc/post_bloc.dart';
import 'package:deev_api_test/models/post.dart';
import 'package:deev_api_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      child: Text("View all"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state is PostInitialState) {
                  BlocProvider.of<PostBloc>(context).add(PostRequestedEvent(
                    userId: user.id,
                  ));
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
                if (state is PostLoadFailureState) {
                  return Center(
                    child: Text("Error loading"),
                  );
                }
                return Container();
              }),

              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.black26,
              //     border: Border.all(
              //       color: Colors.black26,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Text("111"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
