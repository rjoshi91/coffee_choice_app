import 'package:coffeechoiceapp/model/user.dart';
import 'package:coffeechoiceapp/screens/home/coffeePreference.dart';
import 'package:coffeechoiceapp/screens/home/orderList.dart';
import 'package:coffeechoiceapp/screens/home/orderMenu.dart';
import 'package:coffeechoiceapp/screens/home/splashscreenloggedin.dart';
import 'package:coffeechoiceapp/screens/login/login.dart';
import 'package:coffeechoiceapp/screens/login/register.dart';
import 'package:coffeechoiceapp/screens/login/splashscreen.dart';
import 'package:coffeechoiceapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/coffeeOrder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: ChangeNotifierProvider(
        create: (context) => CoffeeOrderList(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue, ),
            home: Wrapper(),
            routes: <String, WidgetBuilder>{
              '/LoginScreen': (BuildContext context) => new LoginScreen(),
              '/HomeScreen': (BuildContext context) => new OrderList(),
              '/RegistrationScreen': (BuildContext context) => new RegistrationScreen(),
              '/OrderMenuScreen': (BuildContext context) => new OrderMenu(),
              '/CoffeePreferenceScreen': (BuildContext context) => new CoffeePreference(),
            }),
      ),
    );
  }
}


//ChangeNotifierProvider(create: (context) => CoffeeOrderList()),

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return SplashScreen();
    }else{
      return SplashScreenLoggedIn();
    }
  }
}