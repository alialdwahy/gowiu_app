import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}
final _controller = PageController(
  initialPage: 0,
);
int _currentpage = 0;
List<Widget> _pages =[
  Column(
    children: [
      Expanded(child: Image.asset('images/vector1.png')),
      Text('Find Food You Love',style: kPagViewTextStyle,textAlign:TextAlign.center,),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/vector2.png')),
      Text('Fast Delivery',style: kPagViewTextStyle,textAlign:TextAlign.center,),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/vector3.png')),
      Text('Live Tracking',style: kPagViewTextStyle,textAlign:TextAlign.center,),
    ],
  ),
];
class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Expanded(
            child:PageView(
          controller:  _controller,
        children: _pages,
              onPageChanged: (index){
            setState(() {
              _currentpage = index;
            });

              },
        ),
          ),
          SizedBox(height: 20,),
          DotsIndicator(
            dotsCount: _pages.length,
            position:_currentpage.toDouble(),
            decorator:DotsDecorator(
              size:const Size.square(9.0),
              activeSize:const Size(18.0,9.0),
              activeShape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)
              ),
              activeColor: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}



