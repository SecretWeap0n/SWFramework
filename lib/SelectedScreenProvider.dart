import 'package:flutter/cupertino.dart';

import 'default_sw_screen.dart';


class SelectedScreenProvider with ChangeNotifier{
  Widget currentScreen = DefaultSWScreen();
  late Widget home;
  Widget? previousScreen=null;

  void Init(Widget home){
    this.home = home;
    currentScreen = home;
    previousScreen = Container();
  }
  void goToHome() {
    previousScreen = null;
    currentScreen = home;
    notifyListeners();
  }

  void goBack(){
    if(previousScreen==null) return;
    currentScreen = previousScreen!;
    notifyListeners();
  }

  void changeScreen(Widget newScreen){
    //TODO animation to change screen
    if(currentScreen==newScreen) return;
    previousScreen = currentScreen;
    currentScreen = newScreen;
    notifyListeners();
  }
}