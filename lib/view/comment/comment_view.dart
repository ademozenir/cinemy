import 'package:cinemy/bloc/auth_cubit.dart';
import 'package:cinemy/bloc/comment_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CommentView extends StatefulWidget {
  const CommentView(this._topicId, this._topic, {super.key});

  final String _topicId;
  final String _topic;

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final _commentCubit = getIt.get<CommentCubit>();
  final _authCubit = getIt.get<AuthCubit>();

  final _dateFormat = DateFormat.yMMMMd();
  final _timeFormat = DateFormat.jm();

  final _textEditingController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _commentCubit.getComments(widget._topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget._topic),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommentCubit, List<Comment>>(
              bloc: _commentCubit,
              builder: (_, comments) {
                var listView = ListView(
                    controller: _scrollController,
                    children: comments
                        .map((comment) => Card(
                              child: ListTile(
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      _dateFormat.format(comment.dateTime),
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      _timeFormat.format(comment.dateTime),
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                leading: SizedBox(
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(comment.photoUrl),
                                  ),
                                ),
                                title: Text(
                                  comment.userName,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  comment.text,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ))
                        .toList());

                Future(() {
                  if (comments.isNotEmpty && comments.last.userId == _authCubit.state.id) {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  }
                });

                return listView;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _textEditingController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  isCollapsed: false,
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: IconButton(icon: const Icon(Icons.emoji_emotions_outlined), onPressed: () {}),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        _commentCubit.addComment(widget._topicId, _textEditingController.text);
                        _textEditingController.clear();
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentCubit.cancelSubscription();
    super.dispose();
  }
}
