import 'package:covid19_app/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CONTAINER extends StatelessWidget {

  var title;
  var data;
    CONTAINER({super.key,required this.title,required this.data});

  @override
  Widget build(BuildContext context) {
    Constant constant=Constant();
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:10,vertical:9),
      child: Container(
        height:90,
        width:185,
        decoration:BoxDecoration(
            color:Colors.white,
            border:Border(
                bottom:BorderSide(
                    color:constant.greenColor,
                    width:2
                )
            )
        ),
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:5,vertical:8),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:   [
                  Icon(Icons.coronavirus,color:constant.redColor,),
                  Text(title,style:TextStyle(fontSize:17,color:constant.greenColor),)
                ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:12,vertical:10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:   [
                  Text(constant.numberFormat.format(data),style:const TextStyle(fontSize:18,color:Colors.black54),),
                ],),
            ),
          ],
        ),
      ),
    );
  }
}
