import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gowiu/screen/topPickStore.dart';
import 'package:gowiu/screen/welcome_screen.dart';
import 'package:gowiu/widgets/image_slider.dart';
import 'package:gowiu/widgets/my_appbar.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';

class LoggedInScreen extends StatefulWidget {
  LoggedInScreen({Key? key}) : super(key: key);
  static const String id = 'loggedlnScreen';

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(112),
          child: MyAppBar(),
        ),
            body:Center(
              child:Column(
                children: [
                  DestinationCarousel(),
                  Container(
                    height: 300,

                      child:
                      TopPickStore()),
                ],
              ),
        ),
    );
  }
}
