import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc_firebase/app/bloc/bloc_page.dart';
import 'package:bloc_firebase/app/bloc/bloc_state.dart';
import 'package:bloc_firebase/app/bloc/bloc_event.dart';
import 'package:bloc_firebase/app/pages/home/home_page.dart';
import 'package:bloc_firebase/app/pages/auth/login_page.dart';
import 'package:bloc_firebase/app/pages/auth/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<BlocPage>(
      create: (BuildContext context) => BlocPage(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocPage>(context).add(LoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlocPage, BlocState>(
          builder: (BuildContext context, state) {
        if (state is LoginState) {
          return const LoginPage();
        } else if (state is RegisterState) {
          return const RegisterPage();
        } else if (state is HomeState) {
          return const HomePage();
        } else {
          return const HomePage();
        }
      }),
    );
  }
}
