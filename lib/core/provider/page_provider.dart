import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> toggleLike(String blogId) async {
    final likeRef = _firestore
        .collection('blogs')
        .doc(blogId)
        .collection('likes')
        .doc(userId);

    final blogRef = _firestore.collection('blogs').doc(blogId);

    final doc = await likeRef.get();

    if (!doc.exists) {
      // Like
      await likeRef.set({
        'userId': userId,
      });

      await blogRef.update({
        'likesCount': FieldValue.increment(1),
      });
    } else {
      // Unlike

      await likeRef.delete();

      await blogRef.update({
        'likesCount': FieldValue.increment(-1),
      });
    }

    notifyListeners();
  }

  Stream<bool> isBlogLiked(String blogId) {
    return _firestore
        .collection('blogs')
        .doc(blogId)
        .collection('likes')
        .doc(userId)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }

  Stream<int> blogLikeCount(String blogId) {
    return _firestore
        .collection('blogs')
        .doc(blogId)
        .snapshots()
        .map((doc) => doc.data()?['likesCount'] ?? 0);
  }

  // for bookmark

  Future<void> toggleBookmark(String blogId) async {
    final bookmarkRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('savedblogs')
        .doc(blogId);

    final doc = await bookmarkRef.get();

    if (!doc.exists) {
      // Bookmark
      await bookmarkRef.set({
        'blogId': blogId,
      });
    } else {
      // Unbookmark
      await bookmarkRef.delete();
    }

    notifyListeners();
  }

  /// BOOKMARK - Check if a blog is bookmarked
  Stream<bool> isBlogBookmarked(String blogId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('savedblogs')
        .doc(blogId)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }
}
