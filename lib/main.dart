import 'package:chat_app/app/core/data/UserDetail.dart';
import 'package:chat_app/boxes.dart';
import 'package:chat_app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserDetailAdapter());
  boxUserDetail = await Hive.openBox<UserDetail>('UserDetailBox');
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  ChatApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chat Application',
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
    );
  }
}
