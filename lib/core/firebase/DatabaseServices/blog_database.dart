import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BlogDatabase {
  // this method creates the blog
  Future<void> createBlog({
    required String title,
    required String description,
    required String category,
    required String userId,
    required String username,
  }) async {
    final blogId = const Uuid().v4();
    final timestamp = Timestamp.now();

    await FirebaseFirestore.instance.collection('blogs').doc(blogId).set({
      'blogId': blogId,
      'title': title,
      'description': description,
      'category': category,
      'userId': userId,
      'username': username,
      'likesCount': 0,
      'uploadedAt': timestamp,
    });
  }

  // this method is used to get all the blogs in the database
  Stream<QuerySnapshot> streamAllBlogs() {
    return FirebaseFirestore.instance
        .collection('blogs')
        .orderBy('uploadedAt', descending: true)
        .snapshots();
  }

  // this method is used to get the logged-in user blogs from the database
  Stream<QuerySnapshot> streamLoggedInUserBlogs({required String userId}) {
    return FirebaseFirestore.instance
        .collection('blogs')
        .where('userId', isEqualTo: userId)
        .orderBy('uploadedAt', descending: true)
        .snapshots();
  }
}
