import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postUrl;
  final String postId;
  final DateTime datePublished;
  final likes;
  final String profImage;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postUrl,
    required this.postId,
    required this.datePublished,
    required this.likes,
    required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "uid": uid,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "likes": likes,
        "profImage": profImage,
        "postId": postId
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        postUrl: snapshot["postUrl"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        likes: snapshot["likes"],
        profImage: snapshot['profImage']);
  }
}
