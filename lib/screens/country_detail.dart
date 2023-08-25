import 'package:covid19_app/components/constants.dart';
import 'package:covid19_app/components/myContainer.dart';
import 'package:covid19_app/components/piechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import '../components/container.dart';
class CountryDetail extends StatelessWidget {
  String image ;
  String  name ;
  int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test;
    CountryDetail({super.key,
      required this.image ,
      required this.name ,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,});
  @override
  Widget build(BuildContext context) {
    Constant constant=Constant();
   DateTime today = DateTime.now();
   String date ="${today.day}-${today.month}-${today.year}";
   return Scaffold(
      backgroundColor:constant.bgColor,
      appBar: AppBar(
        systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor:Colors.transparent,
            statusBarIconBrightness:Brightness.dark,
            systemNavigationBarColor: constant.bgColor,
            systemNavigationBarIconBrightness:Brightness.dark
        ),
        iconTheme:IconThemeData(
          color:constant.greenColor,
        ),
        leadingWidth:25,
        backgroundColor:Colors.transparent,
        elevation:0,
        title:Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children:   [
              Icon(Icons.location_on,color:constant.redColor,size:30,),
            const SizedBox(width:5,),
            Text(name,style:TextStyle(color:constant.greenColor,letterSpacing:3),),
          ],),
      ),
      body:SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyContainer(image:'images/home.png', title:'Stay At Home\nGet Vaccinated'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:12,vertical:10),
            child: Row(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:   [
                  Icon(Icons.coronavirus,color:constant.redColor,),
                const SizedBox(width:5,),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text('Covid-19 Cases In $name',style:TextStyle(fontSize:17,color:constant.greenColor),),
                    Text(date,style:TextStyle(color:constant.black45,letterSpacing:2,fontSize:16),),
                  ],
                ),
              ],
            ),
          ),
          Pie_Chart(
              type:ChartType.disc,
              active:active,
              recovered:totalRecovered,
              deaths:totalDeaths,
              size:2.8,),
          const SizedBox(height:15,),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              CONTAINER(title:'Today Test', data:test),
              CONTAINER(title:'Total Cases ', data:totalCases),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              CONTAINER(title:'Recovered', data:todayRecovered),
              CONTAINER(title:'Critical ', data:critical),
            ],
          ),
         Row(
           mainAxisAlignment:MainAxisAlignment.spaceEvenly,
           children:[
             const Image(
                 height:130,
                 image:AssetImage('images/test.png')),
             Column(
               crossAxisAlignment:CrossAxisAlignment.start,
               children:   [
                 Text('Do Your Own test',style:TextStyle(fontSize:20,color:constant.greenColor),),
                 Text('Follow the instruction \nto do your own test.',style:TextStyle(fontSize:16,color:Colors.green.shade300),)
               ],
             )
           ],
         ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal:10),
            child: Divider(color:constant.greenColor,thickness:2,),
          )
        ],),
      ),
    );
  }
}