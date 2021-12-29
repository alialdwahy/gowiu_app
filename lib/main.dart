import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gowiu/account/loginScreen.dart';
import 'package:gowiu/account/registerScreen.dart';
import 'package:gowiu/provider/auth_provider.dart';
import 'package:gowiu/screen/loggedInScreen.dart';
import 'package:gowiu/screen/map_screen.dart';
import 'package:gowiu/screen/splash_screen.dart';
import 'package:gowiu/screen/topPickStore.dart';
import 'package:gowiu/screen/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'provider/location_provider.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(
        create: (_)=>AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_)=>LocationProvider(),
      ),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepOrange,
          fontFamily: 'Lato'
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>SplashScreen(),
        LoggedInScreen.id:(context)=>LoggedInScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        MapScreen.id:(context)=>MapScreen(),
        LoginScrren.id:(context)=>LoginScrren(),
        RegisterScreen.id:(context)=>RegisterScreen(),
        TopPickStore.id:(context)=>TopPickStore(),

      },
    );
  }
}



