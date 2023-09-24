import 'package:flutter/material.dart';
import 'package:bloc_firebase/app/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPost extends StatefulWidget {
  String id;
  EditPost(this.id, {super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final key = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('Edit Post'),
      ),
      body: FutureBuilder(
          future: Auth().getPost(widget.id),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshots) {
            Map<String, dynamic> post =
                snapshots.data!.data() as Map<String, dynamic>;
            titleController = TextEditingController(text: post['title']);
            descriptionController =
                TextEditingController(text: post['description']);
            return Container(
              decoration: const BoxDecoration(
                color: Colors.purple,
                // image: DecorationImage(
                //   fit: BoxFit.contain,
                //   image: AssetImage(
                //     'assets/images/background.jpeg',
                //   ),
                // ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 150, bottom: 50),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            "Edit Post",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20,
                        ),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Form(
                            key: key,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter title',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purpleAccent)),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Title field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter description',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purpleAccent)),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Description field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide.none),
                              minimumSize: const Size.fromHeight(45),
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await Auth().updatePost(titleController.text,
                                    descriptionController.text, widget.id);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Update'),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            );
          }),
    );
  }
}
