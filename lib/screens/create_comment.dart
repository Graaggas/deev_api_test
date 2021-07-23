import 'dart:math';
import 'package:deev_api_test/blocs/comments_bloc/comments_bloc.dart';
import 'package:deev_api_test/models/comment.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CreateCommentPage extends StatefulWidget {
  const CreateCommentPage({Key? key, required this.postId}) : super(key: key);

  final int postId;

  @override
  _CreateCommentPageState createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  static GlobalKey<FormState> _formKeyEmail = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKeyName = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKeyComment = new GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final commentController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    commentController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add comment"),
      ),
      body: Column(
        children: [
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKeyName,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter name";
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Name',
                        fillColor: Colors.blue[100],
                        filled: true,
                        enabled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKeyEmail,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'EMail',
                        fillColor: Colors.blue[100],
                        filled: true,
                        enabled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKeyComment,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: commentController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter comment";
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Comment',
                        fillColor: Colors.blue[100],
                        filled: true,
                        enabled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKeyEmail.currentState!.validate() &&
                  _formKeyName.currentState!.validate() &&
                  _formKeyComment.currentState!.validate()) {
                _formKeyComment.currentState!.save();
                _formKeyEmail.currentState!.save();
                _formKeyName.currentState!.save();

                var name = nameController.text.toString();
                var email = emailController.text.toString();
                var comment = commentController.text.toString();
                Random random = new Random();

                print(
                    "email validate, name=$name, email=$email, comment=$comment");

                Comment commentObject = Comment(
                    body: comment,
                    email: email,
                    id: random.nextInt(300),
                    name: name,
                    postId: widget.postId);

                print(commentObject);

                BlocProvider.of<CommentsBloc>(context)
                    .add(CommentPostEvent(comment: commentObject));
              }
            },
            child: Text("Add Comment"),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
          ),
          BlocConsumer<CommentsBloc, CommentsState>(builder: (context, state) {
            return Container();
          }, listener: (context, state) {
            if (state is CommentsPostSuccessState) {
              BlocProvider.of<CommentsBloc>(context)
                  .add(CommentsRequestedEvent(postId: widget.postId));
              FocusScope.of(context).requestFocus(new FocusNode());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Comment saved"),
                duration: Duration(seconds: 3),
              ));
            }
          }),
        ],
      ),
    );
  }
}
