import 'package:covid19_app/components/constants.dart';
import 'package:covid19_app/components/piechart.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/components/container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid19_app/components/myColum.dart';
import 'package:covid19_app/components/myContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/EffectedPatients.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin {
  @override
  Constant constant=Constant();
  final controller=PageController(viewportFraction:0.899,keepPage:true);
  @override
  Widget build(BuildContext context) {
    Future<EffectedPatients> getStatesData() async {
      final responce =
      await http.get(Uri.parse('your Api Key'));

      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        return EffectedPatients.fromJson(data);
      } else {
        throw Exception('Error');
      }
    }

    final pages = [
      MyContainer(image:'images/symp.png',title:'Four Symptoms \nof Covid-19',),
      MyContainer(image:'images/fever.png',title:'1 Fever or chills ',),
      MyContainer(image:'images/cough.png',title:'2 Cough',),
      MyContainer(image:'images/sneezing.png',title:'3 Congestion\nor runny nose',),
      MyContainer(image:'images/headache.png',title:'4 Headache',),
    ];
    @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }

    return Scaffold(
      backgroundColor:constant.bgColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:Colors.transparent,
          statusBarIconBrightness:Brightness.dark,
          systemNavigationBarColor:constant.bgColor,
          systemNavigationBarIconBrightness:Brightness.dark

        ),
        backgroundColor:Colors.transparent,
        elevation:0,
        title:Padding(
          padding: const EdgeInsets.symmetric(horizontal:10),
          child: Row(
            children:   [
              Icon(Icons.coronavirus,color:constant.redColor,size:40,),
              const SizedBox(width:15),
              Text('Covid-19 Mobile App',style:TextStyle(color:constant.greenColor,letterSpacing:2),),
            ],),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 156,
                  child: PageView.builder(
                    controller: controller,
                    // itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index % pages.length];
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count:pages.length,
                  effect: const ExpandingDotsEffect(
                      dotColor:  Colors.black26,
                      dotHeight:9,
                      dotWidth:9,
                      activeDotColor:  Colors.greenAccent
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10,vertical:15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(17,0,0,15),
                  child: Row(
                    children:   [
                      Text('Preventions',style: TextStyle(fontSize:20,letterSpacing:2,color:constant.redColor),),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children:   [
                    MyColum(image:'images/wash.png',title:'wash hands',),
                    MyColum(image:'images/mask.png',title:'use mask',),
                    MyColum(image:'images/distance.png',title:'keep distance',)
                  ],
                ),

              ],
            ),
          ),
          FutureBuilder(
              future:getStatesData(),
              builder:(context, AsyncSnapshot<EffectedPatients> snapshot){
                if(!snapshot.hasData)
                {
                  return Expanded(
                    child: SpinKitThreeBounce(
                      color:constant.greenColor,
                      size:30,
                    ),
                  );
                }
                else
                {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10,vertical:20),
                        child:Pie_Chart(
                            type:ChartType.ring,
                            active:snapshot.data!.cases,
                            recovered:snapshot.data!.recovered,
                            deaths:snapshot.data!.deaths,
                            size:3.5),
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: [
                          CONTAINER(title:'Active Cases', data:snapshot.data!.active),
                          CONTAINER(title:'Total Death ', data:snapshot.data!.deaths),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: [
                          CONTAINER(title:'Recovered   ', data:snapshot.data!.recovered),
                          CONTAINER(title:'Critical Patient ', data:snapshot.data!.critical),
                        ],
                      )
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}