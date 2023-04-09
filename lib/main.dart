import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_kart/dataclasses/vehicle_data.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'Pages/HomePage.dart';
import 'firebase_options.dart';
import 'notification.dart';

const notif = "notif";
const notif1 = "notif1";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initialiseWorkManager();

  Workmanager().registerPeriodicTask(
    "2",
    notif,
    frequency: Duration(minutes: 15),
  );
  Workmanager().registerPeriodicTask("5", notif1,
      frequency: Duration(minutes: 15), initialDelay: Duration(minutes: 1));
  runApp(const MyApp());
}

void initialiseWorkManager() {
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case notif:
        NotificationService().initialize();
        break;
      case notif1:
        NotificationService().initialize();
        break;
    }

    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<VehicleData>(create: (_) => VehicleData())
        ],
        child: const MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
