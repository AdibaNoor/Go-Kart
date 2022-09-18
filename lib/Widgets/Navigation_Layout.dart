import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/Pages/HomePage.dart';
import 'package:go_kart/Widgets/NavigationDrawerWidget.dart';
import 'package:go_kart/bloc.navigation_bloc/navigation_bloc.dart';
class NavigationLayout extends StatelessWidget {
  const NavigationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<Navigation_bloc>(
        create: (_)=> Navigation_bloc(),
        child: Stack(
          children: [
            BlocBuilder<Navigation_bloc,NavigationStates>(
              builder: (context,navigationStates){
                return navigationStates as Widget;
              },
            ),
            NavigationDrawerWidget(),
          ],
        ),
      )
    );
  }
}
