import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gowiu/screen/welcome_screen.dart';
import 'package:gowiu/services/storeServices.dart';
import 'package:gowiu/services/user_service.dart';

class TopPickStore extends StatefulWidget {
  static const String id = 'welcome-screen';

  @override
  _TopPickStoreState createState() => _TopPickStoreState();
}

class _TopPickStoreState extends State<TopPickStore> {
  StoreServices _storeServices = StoreServices();
  UserServices _userServices = UserServices();
  User? user = FirebaseAuth.instance.currentUser;
  var _userLatitude= 0.0;
  var _userLongitude= 0.0;

  void initState(){
    _userServices.getUserById(user!.uid).then((result) {
      if(user!=null){
        if(mounted) {
          setState(() {
            _userLatitude = (result.data()['latitude']);
            _userLongitude = (result.data()['longitude']);
          });
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => WelcomeScreen()));
      }
    });
    super.initState();
  }
  getDistance(location){
    var distance = Geolocator.distanceBetween(_userLatitude, _userLongitude, location.Latitude, location.Longitude);
    var distnaceInkm = distance/1000;
    return distnaceInkm.toStringAsFixed(2);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _storeServices.getTopPickStore(),
        builder: (
        BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData)
            return CircularProgressIndicator();
          List shopDistance = [];
          for(int i =0;i<= snapshot.data!.docs.length-1;i++){
            var distance = Geolocator.distanceBetween(_userLatitude, _userLongitude,
                snapshot.data!.docs[i]['location'].latitude
                ,snapshot.data!.docs[i]['location'].longitude);
            var distnaceInkm = distance/1000;
            shopDistance.add(distnaceInkm);
          }
          shopDistance.sort();
          if(shopDistance[0]>10){
            return Container();
          }
          return Column(
            children: [
              Container(
                child: Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      if (double.parse(getDistance(document['location'])) <= 10) {
                        return Container(
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Card(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: Image.network(
                                            document['imageUrl'],
                                            fit: BoxFit.cover,)),),
                                  ),
                                  Container(
                                    height: 35,
                                    child: Text(
                                      document['shopName'], style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold,
                                    ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text('${getDistance(document['location'])}Km',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 10),),
                                ],
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Container();
                         }
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
