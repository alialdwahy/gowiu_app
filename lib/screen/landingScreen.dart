import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gowiu/provider/location_provider.dart';
import 'package:gowiu/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LandingScreen extends StatefulWidget {
  static const String id = 'home-screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  LocationProvider _locationProvider =LocationProvider();
  User? user = FirebaseAuth.instance.currentUser;
  String? _location;
  String? _address;

  @override
  void initState() {
 UserServices _userServices = UserServices();
 _userServices.getUserById(user!.uid).then((result)async{
   if(result!=null){
     if(result.data()['latitude']!=null){
       getPrefs(result);
     }
   }
 });
    super.initState();
  }
  getPrefs(dbResult)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? location = preferences.getString('location');
    if(location==null){
      preferences.setString('address', dbResult.data()['location']);
      preferences.setString('location', dbResult.data()['address']);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
