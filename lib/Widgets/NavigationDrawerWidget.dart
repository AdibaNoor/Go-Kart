import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'MenuItems.dart';
import 'Navigation_Layout.dart';
class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  //bool isNavOpened = true;
  final _animationDuration = const Duration(milliseconds: 500);
  late final StreamController<bool> _isNavOpenedStreamController;
  late Stream<bool> _isNavOpenedStream;
  late StreamSink<bool> _isNavOpenedSink;
  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _isNavOpenedStreamController = PublishSubject<bool>();
    _isNavOpenedStream = _isNavOpenedStreamController.stream;
    _isNavOpenedSink=_isNavOpenedStreamController.sink;
  }
  @override
  void dispose(){
    _animationController.dispose();
    _isNavOpenedStreamController.close();
    _isNavOpenedSink.close();
    super.dispose();
  }
  void onIconPressed(){
    final _animationStatus = _animationController.status;
    final isAnimationCompleted = _animationStatus == AnimationStatus.completed;
    if(isAnimationCompleted){
      _isNavOpenedSink.add(false);
      _animationController.reverse();
    }
    else{
      _isNavOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth= MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: _isNavOpenedStream,
      builder: (context, _isNavOpenedAsync){
        return AnimatedPositioned(
          top: 0,
          bottom: 0,
          left: _isNavOpenedAsync.requireData ? 0:-screenwidth,
          right: _isNavOpenedAsync.requireData ? 0: screenwidth-31,
          duration: _animationDuration,
          child: Row(
            children: [
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.black38,
                child: Column(
                  children:  [
                    SizedBox(height: 100,),
                    ListTile(
                      title: Text('User',style: TextStyle(fontSize: 30,fontWeight:FontWeight.w400,color: Colors.white ),),
                      subtitle: Text('User@gmail.com',style: TextStyle(
                          fontSize: 20,fontWeight:FontWeight.w400,color: Colors.white38 ),),
                      leading: CircleAvatar(
                        child: Icon(Icons.person,color: Colors.white,),
                        radius: 40,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 30,
                      thickness: 0.6,
                      endIndent: 16,
                      indent: 16,
                    ),
                    MenuItems(
                      // ontap: null,
                      ontap: (){
                        onIconPressed();
                        BlocProvider.of<Navigation_bloc>(context).add(NavigationEvents.HomePageClick);
                      },
                      icon:Icons.home,
                      title: "Home",

                    ),
                    MenuItems(
                      ontap: (){
                        onIconPressed();
                        BlocProvider.of<Navigation_bloc>(context).add(NavigationEvents.HomePageClick);
                      },
                      icon:Icons.navigation_outlined,
                      title: "Map",
                    ),
                    MenuItems(
                      ontap: (){
                        onIconPressed();
                        BlocProvider.of<Navigation_bloc>(context).add(NavigationEvents.SpeedPageClick);
                      },
                      icon:Icons.speed_outlined,
                      title: "Speed",
                    ),
                    MenuItems(
                      icon:Icons.battery_2_bar,
                      title: "Fuel",
                      ontap: (){
                        onIconPressed();
                      BlocProvider.of<Navigation_bloc>(context).add(NavigationEvents.FuelPageClick);
                    },
                    ),
                  ],
                ),
              )),
              Align(
                alignment: Alignment(0,-0.86),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: _customMenuClipper(),
                    child: Container(
                      width: 30,
                      height: 110,
                      color: Colors.black38,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white38,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },

    );
  }
}
class _customMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint=Paint();
    paint.color =Colors.black;
    // throw UnimplementedError();
    Path path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(0,0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    // throw UnimplementedError();
    return true;
  }
  
}