import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GoKart"),
      ),
      body: const TextInputWidget(),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({Key? key}) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController controller = TextEditingController();
  double a = 10;
  final StreamController _streamController = StreamController();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getSpeed();
    });
  }

  Future<void> getSpeed() async {
    var url = Uri.parse(
        "https://io.adafruit.com/api/v2/skyadav/feeds?X-AIO-Key=aio_VDjM45jqBZ0v1i00nj9TcURDFuDZ");
    final response = await http.get(url);
    final dataBody = json.decode(response.body).first['last_value'];
    _streamController.sink.add(dataBody);
  }

  double click() {
    setState(() {
      String speed = controller.text;
      if (speed == "") {
        a = 0;
      } else {
        a = double.parse(speed);
      }

      controller.clear();
    });
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Text("Wait");
                  } else {
                    return Column(
                      children: [
                        SfRadialGauge(
                          axes: [
                            RadialAxis(
                              pointers: [
                                NeedlePointer(
                                  value: double.parse(snapshot.data.toString()),
                                  enableAnimation: true,
                                  enableDragging: true,
                                )
                              ],
                            )
                          ],
                        ),
                        Text(snapshot.data.toString())
                      ],
                    );
                  }
              }
            }),
        TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.message),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                splashColor: Colors.red,
                onPressed: () {
                  click();
                },
              ),
              labelText: "Speed",
              hintText: "Enter speed"),
        ),
      ],
    );
  }
}