import 'package:cloud_firestore/cloud_firestore.dart';

class PostFeedModel {
  final String id;
  final String userName;
  final String imgUrl;
  final String content;
  final Timestamp timestamp;
  final int likes;

  PostFeedModel({
    required this.id,
    required this.userName,
    required this.imgUrl,
    required this.content,
    required this.timestamp,
    required this.likes,
  });

  // Factory method to create a PostFeedModel from a Firestore document
  factory PostFeedModel.fromDocument(DocumentSnapshot doc) {
    return PostFeedModel(
      id: doc.id,
      userName: doc['userName'],
      content: doc['content'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
      imgUrl: doc['imgUrl'],
    );
  }

  // Method to convert PostFeedModel to a Map (for uploading to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'content': content,
      'timestamp': timestamp,
      'likes': likes,
      'imgUrl': imgUrl,
    };
  }
}
