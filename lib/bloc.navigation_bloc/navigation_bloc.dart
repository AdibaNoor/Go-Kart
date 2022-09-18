import 'package:bloc/bloc.dart';
import 'package:go_kart/Pages/Fuel.dart';
import 'package:go_kart/Pages/Speedometer.dart';
import 'package:rxdart/rxdart.dart';
import '../Pages/HomePage.dart';
enum NavigationEvents{
  HomePageClick,SpeedPageClick,FuelPageClick,
}
abstract class NavigationStates{

}
class Navigation_bloc extends Bloc<NavigationEvents,NavigationStates>{
  
  @override
  // NavigationStates get initialStates =>  MyHomePage();
  Navigation_bloc(): super (initialState);

  static NavigationStates get initialState => MyHomePage();
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch(event){
      case NavigationEvents.HomePageClick:yield MyHomePage();
      break;
      case NavigationEvents.FuelPageClick:yield FuelPage();
      break;
      case NavigationEvents.SpeedPageClick:yield SpeedometerPage();
      break;
    }
  }

}