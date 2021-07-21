import 'package:deev_api_test/blocs/post_bloc/post_bloc.dart';
import 'package:deev_api_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          if (state is PostsInitialState) {
            // BlocProvider.of<PostBloc>(context).add(PostRequestedEvent(
            //   userId: userId,
            // ));
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
                itemCount: state.postList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          '/opened_post_screen',
                          arguments: state.postList[index].id),
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
                                    fontSize: 14, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
