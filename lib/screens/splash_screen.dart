import 'dart:async';
import 'package:flutter/material.dart';
import 'Home_Screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds:2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>const HomeScreen()));
    });
    return Scaffold(
      appBar:AppBar(
        elevation:0,
        backgroundColor:const Color(0xffeaf8f5),
      ),
      body: const SizedBox(
          height:double.infinity,
          child: Image(fit:BoxFit.cover,image: AssetImage('images/splash.jpg')))

    );
  }
}
