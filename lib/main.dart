import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/HomePage.dart';
import 'notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NotificationService())],
      child: const MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
