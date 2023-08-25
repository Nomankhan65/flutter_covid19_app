import 'package:covid19_app/screens/Track_country.dart';
import 'package:covid19_app/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState() ;
}
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  var _curentIndex=0;
  final tabs=[
    const HomePage(),
     const TrackCountry(),
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _curentIndex;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:tabs[_curentIndex],
      backgroundColor:const Color(0xffeaf8f5),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.symmetric(horizontal:10,vertical:1),
        child: BottomNavigationBar(
            elevation:0,
            currentIndex:_curentIndex,
            backgroundColor:Colors.white,
            unselectedItemColor:Colors.green.shade200,
            onTap:(index)
            {
              setState(() {
                _curentIndex=index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon:Icon(Icons.home),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.bar_chart),
                label:'Tracker',
              ),
            ]),
      ),
    );
  }
}



