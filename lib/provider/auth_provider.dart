import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gowiu/services/user_service.dart';

import 'location_provider.dart';

class AuthProvider extends ChangeNotifier{
 bool isPicAvail=false;
 String error="";
 String? email;
 UserServices _userServices = UserServices();
 bool loading = false;
 LocationProvider locationData = LocationProvider();
 String? screen;
 double? latitude;
 double? longitude;
 String? address;

  Future<UserCredential?>registerVendor(email,password)async{
    this.email=email;
    notifyListeners();

    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,


      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error='The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        this.error='The account already exists for that email.';
        print('The account already exists for that email.');
      }
    } catch (e) {
      this.error=e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;

  }
 Future<UserCredential?>loginVendor(String  email,password)async{
   this.email=email;
   notifyListeners();
   UserCredential? userCredentia;
   try {
     userCredentia = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password,
     );
   } on FirebaseAuthException catch (e) {
       this.error=e.code;
       notifyListeners();
   } catch (e) {
     this.error="e.code";
     notifyListeners();
     print(e);
   }
   return userCredentia;
 }
 Future<UserCredential?>resetPassword( email,)async{
   this.email=email;
   notifyListeners();
   UserCredential? userCredentia;
   try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
       email: email,
     );
   } on FirebaseAuthException catch (e) {
     this.error=e.code;
     notifyListeners();
   } catch (e) {
     this.error="e.code";
     notifyListeners();
     print(e);
   }
   return userCredentia;
 }
  Future<void>saveVendorDataToDb({String? Name,String? mobile,double? latitude ,double? longitude,String? address })async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference _vendors = FirebaseFirestore.instance.collection('users').doc(user!.uid);
    _vendors.set({
      'uid':user.uid,
      'Name':Name,
      'mobile':mobile,
      'email':this.email,
      'latitude':this.latitude,
      'longitude':this.longitude,
      'address':this.address


    });
    return null;

  }

 Future<void>? updateUser(
     {String? id, String? email})async {
   try{
     _userServices.updateUserData({
       'id': id,
       'email':email,
       'latitude':this.latitude,
       'longitude':this.longitude,
       'address':this.address
     });
     this.loading=false;
     notifyListeners();
   }catch(e){
     print('Error $e');
   }
 }
}