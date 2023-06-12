import 'dart:async';
import 'package:cinemy/bloc/auth_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<List<Comment>> {
  CommentCubit() : super([]);

  final _db = FirebaseFirestore.instance;
  final _authCubit = getIt.get<AuthCubit>();

  StreamSubscription? _subscription;

  void getComments(String topicId) {
    emit([]);
    _subscription = _db.collection("comment")
        .where("topicId", isEqualTo: topicId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docChanges)
        .listen((docChanges) {
          var comments = <Comment>[];
          comments.addAll(state);

          docChanges
              .where((docChange) => docChange.type == DocumentChangeType.added)
              .forEach((docChange) => comments.add(Comment.fromJson(docChange.doc.data()!)),
          );
          emit(comments);
        });
  }

  void cancelSubscription() {
    _subscription?.cancel();
  }

  void addComment(String topicId, String text) {
    var comment = Comment(
      topicId: topicId,
      text: text,
      userId: _authCubit.state.id,
      userName: _authCubit.state.name,
      photoUrl: _authCubit.state.photoUrl,
      dateTime: DateTime.now(),
    );
    _db.collection("comment").add(comment.toJson());
  }
}
