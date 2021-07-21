import 'package:deev_api_test/blocs/commens_bloc/comments_bloc.dart';
import 'package:deev_api_test/blocs/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class OpenedPostScreen extends StatelessWidget {
  const OpenedPostScreen({Key? key, required this.postId}) : super(key: key);
  final int postId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CommentsBloc>(context)
        .add(CommentsRequestedEvent(postId: postId));
    return Scaffold(
      appBar: AppBar(
        title: Text("Post $postId"),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoadSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                          children: [
                            Text(
                              state.postList
                                  .firstWhere((element) => element.id == postId)
                                  .title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              state.postList
                                  .firstWhere((element) => element.id == postId)
                                  .body,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Comments:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    BlocBuilder<CommentsBloc, CommentsState>(
                      builder: (context, state) {
                        if (state is CommentsoadFailureState) {
                          return Center(
                            child: Text("ERROR LOADING"),
                          );
                        }
                        if (state is CommentsInitialState) {
                          return Center(
                            child: JumpingDotsProgressIndicator(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          );
                        }
                        if (state is CommentsLoadInProgressState) {
                          return Center(
                            child: JumpingText(
                              'Loading...',
                            ),
                          );
                        }
                        if (state is CommentsLoadSuccessState) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.commentList.length,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Text(
                                              "№ ${state.commentList[index].id}",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            state.commentList[index].name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            state.commentList[index].email,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            state.commentList[index].body,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return Container();
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Add Comment"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
          listener: (context, state) {
            // print("sssss");
          },
        ),
      ),
    );
  }
}
