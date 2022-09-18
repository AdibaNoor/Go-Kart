import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.black38,
        body: SafeArea(
          child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Dashboard',
                  style:TextStyle(fontSize: 28, color: Colors.white),),
                Icon(Icons.menu,color: Colors.white,),],),),
            SizedBox(height:10,),
            //Fuel container
            Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: Container(
                     width: 80,
                     height: 50,
                     decoration: BoxDecoration(color: Colors.white12,
                       borderRadius: BorderRadius.circular(16),),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                       child: Text('Fuel',style: TextStyle(fontSize: 16,color: Colors.white),),
                     ),),),],),
            //speedometer
            SizedBox(height:10),
            Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(color: Colors.white12,
                borderRadius: BorderRadius.circular(16),),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                child: Text('Speedometer',style: TextStyle(fontSize: 16,color: Colors.white),),
              ),),
            //Temp,Gear,Mileage
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white12,
                    borderRadius: BorderRadius.circular(16),),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                    child: Text('Temp',style: TextStyle(fontSize: 16,color: Colors.white),),),),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white12,
                      borderRadius: BorderRadius.circular(16),),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                      child: Text('Gear',style: TextStyle(fontSize: 16,color: Colors.white),),),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white12,
                      borderRadius: BorderRadius.circular(16),),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                      child: Text('Mileage',style: TextStyle(fontSize: 16,color: Colors.white),),),
                  ),
                  ],),
            ),

            ],),
        )

    );
  }
}
// TextInputWidget(),
// class TextInputWidget extends StatefulWidget {
//   const TextInputWidget({Key? key}) : super(key: key);
//
//   @override
//   State<TextInputWidget> createState() => _TextInputWidgetState();
// }
//
// class _TextInputWidgetState extends State<TextInputWidget> {
//   TextEditingController controller = TextEditingController();
//   double a = 10;
//   final StreamController _streamController = StreamController();
//
//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       getSpeed();
//     });
//   }
//
//   Future<void> getSpeed() async {
//     var url = Uri.parse(
//         "https://io.adafruit.com/api/v2/skyadav/feeds?X-AIO-Key=aio_VDjM45jqBZ0v1i00nj9TcURDFuDZ");
//     final response = await http.get(url);
//     final dataBody = json.decode(response.body).first['last_value'];
//     _streamController.sink.add(dataBody);
//   }
//
//   double click() {
//     setState(() {
//       String speed = controller.text;
//       if (speed == "") {
//         a = 0;
//       } else {
//         a = double.parse(speed);
//       }
//
//       controller.clear();
//     });
//     return a;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         StreamBuilder(
//             stream: _streamController.stream,
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 default:
//                   if (snapshot.hasError) {
//                     return const Text("Wait");
//                   } else {
//                     return Column(
//                       children: [
//                         SfRadialGauge(
//                           axes: [
//                             RadialAxis(
//                               pointers: [
//                                 NeedlePointer(
//                                   value: double.parse(snapshot.data.toString()),
//                                   enableAnimation: true,
//                                   enableDragging: true,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                         Text(snapshot.data.toString())
//                       ],
//                     );
//                   }
//               }
//             }),
//         TextField(
//           keyboardType: TextInputType.number,
//           controller: controller,
//           decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.message),
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.send),
//                 splashColor: Colors.red,
//                 onPressed: () {
//                   click();
//                 },
//               ),
//               labelText: "Speed",
//               hintText: "Enter speed"),
//         ),
//       ],
//     );
//   }
// }