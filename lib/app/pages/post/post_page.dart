import 'package:flutter/material.dart';
import 'package:bloc_firebase/app/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc_firebase/app/pages/post/edit_post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: Auth().getPosts(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (ctx, idx) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      title: Text("${snapshots.data!.docs[idx]['title']}"),
                      subtitle:
                          Text("${snapshots.data!.docs[idx]['description']}"),
                      trailing: Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditPost(snapshots.data!.docs[idx].id),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.edit_square,
                              color: Colors.purple,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Auth().deletePost(snapshots.data!.docs[idx].id);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
