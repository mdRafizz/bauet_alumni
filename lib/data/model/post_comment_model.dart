import 'package:cloud_firestore/cloud_firestore.dart';

class PostCommentModel {
  final String id;
  final String userName;
  final String imgUrl;
  final String content;
  final Timestamp timestamp;

  PostCommentModel({
    required this.id,
    required this.userName,
    required this.imgUrl,
    required this.content,
    required this.timestamp,
  });

  // Factory method to create a PostCommentModel from a Firestore document
  factory PostCommentModel.fromDocument(DocumentSnapshot doc) {
    return PostCommentModel(
      id: doc.id,
      userName: doc['userName'],
      imgUrl: doc['imgUrl'],
      content: doc['content'],
      timestamp: doc['timestamp'],
    );
  }

  // Method to convert PostCommentModel to a Map (for uploading to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userName,
      'content': content,
      'imgUrl': imgUrl,
      'timestamp': timestamp,
    };
  }
}
