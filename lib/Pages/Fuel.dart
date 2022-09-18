import 'package:flutter/material.dart';
class FuelPage extends StatefulWidget {
  const FuelPage({Key? key}) : super(key: key);

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 30),
              child: Text('FuelPage',style: TextStyle(fontSize: 28,color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
