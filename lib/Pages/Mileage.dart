import 'package:flutter/material.dart';
import 'package:go_kart/bloc.navigation_bloc/navigation_bloc.dart';
class MileagePage extends StatefulWidget with NavigationStates{
  const MileagePage({Key? key}) : super(key: key);

  @override
  State<MileagePage> createState() => _MileagePageState();
}

class _MileagePageState extends State<MileagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 30),
              child: Text('MileagePage',style: TextStyle(fontSize: 28,color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
