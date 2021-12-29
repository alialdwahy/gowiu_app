import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gowiu/provider/location_provider.dart';
import 'package:gowiu/screen/map_screen.dart';
import 'package:gowiu/screen/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyAppBar extends StatefulWidget {


  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String _location ='';
  String _address ='';
  @override
  void initState() {
    getPrefs();
    super.initState();
  }
  getPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('location');
    String? address = prefs.getString('address');
    setState(() {
      _location=location!;
      _address=address!;
    });
  }
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 0.0,



      title: FlatButton(
        onPressed: (){
          locationData.getCurrentPosition();
          if(locationData.permissionAllowed==true){
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MapScreen()));
          }else{
            print('permission not allowed');
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    _location==null?'address not set':_location,
                    style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                 Icon(
                    Icons.edit_outlined,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
            Flexible(child: Text(_address,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,
                fontSize:12 ),)),
          ],
        ),
      ),
      actions: [

           IconButton(
    icon:Icon(
    Icons.account_circle_outlined,color: Colors.white,),
    onPressed: (){},),

           IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WelcomeScreen()));
          },
              icon: Icon(
                Icons.power_settings_new_outlined,color: Colors.white,)),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search,color: Colors.grey,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
