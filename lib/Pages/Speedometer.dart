import 'package:flutter/material.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
class SpeedometerPage extends StatefulWidget with NavigationStates {
  const SpeedometerPage({Key? key}) : super(key: key);

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 30),
              child: Text('SpeedometerPage',style: TextStyle(fontSize: 28,color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
