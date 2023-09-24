import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  Future<Map<String, dynamic>> register(
      String userEmail, String userPassword) async {
    Map<String, dynamic> res = {"status": false};
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      res['status'] = true;
    } catch (e) {
      print(e);
    }
    return res;
  }

  login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  createPost(String title, String desc) {
    FirebaseFirestore.instance.collection('posts').add({
      "title": title,
      "description": desc,
    });
  }

  Stream<QuerySnapshot> getPosts() async* {
    Stream<QuerySnapshot> posts =
        FirebaseFirestore.instance.collection('posts').snapshots();
    yield* posts;
  }

  Future<DocumentSnapshot> getPost(String id) async {
    DocumentSnapshot post =
        await FirebaseFirestore.instance.collection('posts').doc(id).get();
    return post;
  }

  updatePost(String title, String description, String id) async {
    await FirebaseFirestore.instance.collection('posts').doc(id).update({
      "title": title,
      "description": description,
      "id": id,
    });
  }

  deletePost(String id) {
    FirebaseFirestore.instance.collection('posts').doc(id).delete();
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
