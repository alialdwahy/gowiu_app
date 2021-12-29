
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gowiu/provider/auth_provider.dart';
import 'package:gowiu/provider/location_provider.dart';
import 'package:gowiu/screen/loggedInScreen.dart';
import 'package:gowiu/screen/map_screen.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  var _cpasswordTextController = TextEditingController();
  var _addressTextController = TextEditingController();
  var _nameTextController = TextEditingController();
  String? email;
  String? password;
  String? mobile;
  String? Name;
  String? dialog;
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    scaffildmessage(message){
      return    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
    return _isLoading ? CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    ):
    Form(
     key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter Your Name';
                }
                setState(() {
                  _nameTextController.text=value;
                });
                setState(() {
                  Name=value;
                });
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: 'Name',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,color: Theme.of(context).primaryColor,
                  ),
                ),
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              maxLength: 9,
              keyboardType: TextInputType.number,
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter Mobile Number';
                }
                setState(() {
                  mobile=value;
                });
                return null;
              },
              decoration: InputDecoration(
                prefixText: '+249',
                prefixIcon: Icon(Icons.phone_android),
                labelText: 'Mobile Number',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,color: Theme.of(context).primaryColor,
                  ),
                ),
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter Email';
                }
                final bool _isValid = EmailValidator.validate(_emailTextController.text);
                if(!_isValid){
                  return 'Invalid Email Fromat';
                }
                setState(() {
                  email=value;
                });
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,color: Theme.of(context).primaryColor,
                  ),
                ),
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              obscureText: true,
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter PassWord';
                }
                if(value.length<6){
                  return 'minimum 6 charectors';
                }
                setState(() {
                  password=value;
                });
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: 'PassWord',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,color: Theme.of(context).primaryColor,
                  ),
                ),
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              obscureText: true,
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter Confirm PassWord';
                }
                if(_passwordTextController.text != _cpasswordTextController.text){
                  return 'Password Does\'t Match';
                }
                if(value.length<6){
                  return 'minimum 6 charectors';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: 'Confirm PassWord',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,color: Theme.of(context).primaryColor,
                  ),
                ),
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              maxLines: 6,
              controller: _addressTextController,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Press navigation Button';
                }
                if(locationData.latitude==null){
                  return 'Please Press navigation Button';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.contact_mail_outlined),
                labelText: 'Business Location',
                suffixIcon: IconButton(
                  icon:Icon( Icons.location_searching),
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

                  }, ),

                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,color: Theme.of(context).primaryColor,
                  ),
                ),
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    if(_authData.isPicAvail==true){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          _isLoading=true;
                        });
                        _authData.registerVendor(email, password).then((credential){
                          if(credential!=null){
                                _authData.saveVendorDataToDb(
                                  Name: Name,
                                  mobile:mobile,

                                );
                                  setState(() {
                                    _formKey.currentState;
                                    _isLoading=false;
                                  });
                                Navigator.pushReplacementNamed(context, LoggedInScreen.id);
                              }else{
                                scaffildmessage('Failed to Upload Shop Profile Pic');
                              }
                            });


                          }else{
                            scaffildmessage(_authData.error);

                          }

                    }else{
                     scaffildmessage('shop profile pic need to be added');
                    }
                  },
                    child: Text('Register',style: TextStyle(color: Colors.white,),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
