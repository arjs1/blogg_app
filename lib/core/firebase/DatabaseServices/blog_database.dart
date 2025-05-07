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

  // this method is used to get the categorized blogs in the database
  Stream<QuerySnapshot> streamCategorizedBlogs({required String category}) {
    return FirebaseFirestore.instance
        .collection('blogs')
        .orderBy('uploadedAt', descending: true)
        .where("category", isEqualTo: category)
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

  // this method is used to get the savedblogs from the user
  Stream<List<Map<String, dynamic>>> streamLoggedInSavedBlogs(
      {required String uid}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedblogs')
        .snapshots()
        .asyncMap(
      (snapshot) async {
        List<String> blogIds = snapshot.docs.map((doc) => doc.id).toList();

        // fetch blogs from the 'blogs' collection
        List<Map<String, dynamic>> fullBlogs = [];

        for (String id in blogIds) {
          final blogDoc = await FirebaseFirestore.instance
              .collection('blogs')
              .doc(id)
              .get();
          if (blogDoc.exists) {
            fullBlogs.add(blogDoc.data()!);
          }
        }

        return fullBlogs;
      },
    );
  }
}
