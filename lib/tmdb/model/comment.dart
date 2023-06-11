import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({
    required this.topicId,
    required this.text,
    required this.userId,
    required this.userName,
    required this.photoUrl,
    required this.dateTime,
  });

  final String topicId;
  final String text;
  final String userId;
  final String userName;
  final String photoUrl;
  final DateTime dateTime;

  Comment.fromJson(Map<String, dynamic> map)
      : topicId = map["topicId"],
        text = map["text"],
        userId = map["userId"],
        userName = map["userName"],
        photoUrl = map["photoUrl"],
        dateTime = (map["dateTime"] as Timestamp).toDate();

  Map<String, dynamic> toJson() => {
        "topicId": topicId,
        "text": text,
        "userId": userId,
        "userName": userName,
        "photoUrl": photoUrl,
        "dateTime": dateTime,
      };
}
