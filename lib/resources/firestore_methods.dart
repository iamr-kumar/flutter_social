import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/models/Post.model.dart';
import 'package:flutter_social/resources/storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occurred!";
    try {
      String photoUrl = await StorageMethods().uploadImage('posts', file, true);
      String postId = const Uuid().v4();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
      return res;
    } catch (err) {
      res = err.toString();
      return res;
    }
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = 'Some error occurred!';
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .add({
          'text': text,
          'uid': uid,
          'commentId': commentId,
          'name': name,
          'profilePic': profilePic,
          'datePosted': DateTime.now()
        });
        res = "success";
        return res;
      } else {
        return res;
      }
    } catch (err) {
      print(err.toString());
      return res;
    }
  }

  // deleting post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }
}
