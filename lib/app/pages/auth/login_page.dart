import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase/app/auth/auth.dart';
import 'package:bloc_firebase/app/bloc/bloc_page.dart';
import 'package:bloc_firebase/app/bloc/bloc_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.purple,
          // image: DecorationImage(
          //   image: AssetImage('assets/images/background.jpeg'),
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
                      "Sign In",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Sign in to your account",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your email',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purpleAccent)),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Email field is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your password',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purpleAccent)),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Password field is required';
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
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<BlocPage>(context).add(RegisterEvent());
                      },
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(color: Colors.purple),
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
                          await Auth().login(
                              emailController.text, passwordController.text);
                          BlocProvider.of<BlocPage>(context).add(HomeEvent());
                        }
                      },
                      child: const Text('Sign In'),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
