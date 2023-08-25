import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MyColum extends StatelessWidget {
  var image;
  var title;
    MyColum({super.key,required this.image,required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:70,
          width:70,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(50),
            image:DecorationImage(image:AssetImage(image)),
            color:Colors.greenAccent.shade100,
          ),
        ),
        const SizedBox(height:5,),
          Text(title,style: const TextStyle(fontSize:15,color:Colors.green),)
      ],
    );
  }
}
