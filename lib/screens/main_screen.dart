import 'package:deev_api_test/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserBlocState>(
        builder: (context, state) {
          if (state is UserBlocInitialState) {
            print("initial state ...");
            BlocProvider.of<UserBloc>(context).add(UserBlocRequestedEvent());
            return Center(
              child: JumpingDotsProgressIndicator(
                color: Colors.black,
                fontSize: 24,
              ),
            );
          }
          if (state is UserBlocLoadInProgressState) {
            return Center(
              child: JumpingText(
                'Loading...',
              ),
            );
          }
          if (state is UserBlocLoadSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                            '/user_details_screen',
                            arguments: state.userList[index]),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(state.userList[index].name),
                          subtitle: Text(state.userList[index].username),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Container(
            child: Center(
              child: Text("Something goes wrong..."),
            ),
          );
        },
      ),
    );
  }
}
