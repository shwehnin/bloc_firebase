import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase/app/auth/auth.dart';
import 'package:bloc_firebase/app/bloc/bloc_page.dart';
import 'package:bloc_firebase/app/bloc/bloc_state.dart';
import 'package:bloc_firebase/app/bloc/bloc_event.dart';
import 'package:bloc_firebase/app/pages/post/add_post.dart';
import 'package:bloc_firebase/app/pages/post/post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocPage>(context).add(PostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          title: const Text("Home Page"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.purple),
                currentAccountPicture:
                    Image.asset('assets/images/background.jpeg'),
                accountName: const Text("Hnin Hnin"),
                accountEmail: const Text('hninhnin@gmail.com'),
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("New Post"),
                onTap: () {
                  BlocProvider.of<BlocPage>(context).add(NewPostEvent());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Post"),
                onTap: () {
                  BlocProvider.of<BlocPage>(context).add(PostEvent());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () async {
                  await Auth().logout();
                  BlocProvider.of<BlocPage>(context).add(LoginEvent());
                },
              )
            ],
          ),
        ),
        body: BlocBuilder<BlocPage, BlocState>(
            builder: (BuildContext context, state) {
          if (state is PostState) {
            return const PostPage();
          } else if (state is NewPostState) {
            return const AddPost();
          } else {
            return const PostPage();
          }
        }));
  }
}
