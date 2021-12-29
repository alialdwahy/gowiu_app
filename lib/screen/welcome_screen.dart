import 'package:flutter/material.dart';
import 'package:gowiu/account/loginScreen.dart';
import 'package:gowiu/provider/auth_provider.dart';
import 'package:gowiu/provider/location_provider.dart';
import 'package:gowiu/screen/map_screen.dart';
import 'package:gowiu/screen/onboard_screen.dart';
import 'package:provider/provider.dart';



class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: [
               Positioned(
                 right: 0.0,
                  top: 10.0,
                   child: GestureDetector(
                    child: Text("SKIP",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),
                    ),
                   ),

                  ),

                Column(
              children: [
                Expanded(child: OnBoardScreen(),),
                Text("Ready to order from your nearest shop?",),
                SizedBox(height: 20,),
                FlatButton(
                  color: Colors.deepOrange,
                  child: locationData.loading?CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ) :Text('Set Delivery Location',style: TextStyle(color: Colors.black),
                  ),
                  onPressed: ()async{
                    setState(() {
                      locationData.loading=true;
                    });
                    await locationData.getCurrentPosition();
                    if(locationData.permissionAllowed==true){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MapScreen()));
                      setState(() {
                        locationData.loading=false;
                      });
                    }else{
                      print('permission not allowed');
                      setState(() {
                        locationData.loading=false;
                      });
                    }
                  },
                ),
                MaterialButton(
                  child: RichText(text: TextSpan(
                    text: 'Already a Customer ?',style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Login',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),
                      ),
                    ],
                  ),
                  ),
                          onPressed: (){
                         setState(() {
                           Navigator.pushReplacementNamed(context, LoginScrren.id);
                        });
                    },
                  ),
                 ],
              )
             ],
            ),
          ) ,
     );
  }
}
