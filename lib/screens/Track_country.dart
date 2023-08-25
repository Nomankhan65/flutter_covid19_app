import 'dart:convert';
import 'package:covid19_app/components/constants.dart';
import 'package:covid19_app/screens/country_detail.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class TrackCountry extends StatefulWidget {
  const TrackCountry({super.key});

  @override
  State<TrackCountry> createState() => _TrackCountryState();
}

class _TrackCountryState extends State<TrackCountry> {
  TextEditingController  controller=TextEditingController();
  Future<List<dynamic>> getCountry()async{
    var data;
    final responce=await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if(responce.statusCode==200)
    {
      data=jsonDecode(responce.body.toString());
      return data;
    }
    else
    {
      throw Exception('Error');
    }
  }
  @override
  Widget build(BuildContext context) {
    Constant constant=Constant();
    return Scaffold(
      backgroundColor:constant.bgColor,
      appBar: AppBar(
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarIconBrightness:Brightness.dark,
            systemNavigationBarColor:constant.bgColor,
            systemNavigationBarIconBrightness:Brightness.dark
        ),
        backgroundColor:Colors.transparent,
        elevation:0,
        title:Padding(
          padding: const EdgeInsets.symmetric(horizontal:10),
          child: Row(
            children:[
              Icon(Icons.coronavirus,color:constant.redColor,size:40,),
              const SizedBox(width:15),
              Text('Covid-19 Mobile App',style:TextStyle(color:constant.greenColor,letterSpacing:2),)
            ],),
        ),
      ),
      body:SafeArea(
        child:Column(
          children:[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal:15,vertical:5),
                child:TextFormField(
                  controller:controller,
                  onChanged:(values)
                  {
                    setState(() {
                    });
                  },
                  decoration:InputDecoration(
                      labelText:'Search country',
                      contentPadding:const EdgeInsets.symmetric(horizontal:20),
                      border:OutlineInputBorder(
                         borderSide:const BorderSide(
                           color:Colors.grey
                         ),
                        borderRadius:BorderRadius.circular(10),
                      ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(10),
                      borderSide:BorderSide(
                        color:constant.greenColor,
                      )
                    )

                  ),
                )
            ),
            Expanded(
              child: FutureBuilder(
                  future:getCountry(),
                  builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                    if(!snapshot.hasData)
                    {
                      return ListView.builder(
                          itemCount:10,
                          itemBuilder:(context,index){
                            return Shimmer.fromColors(
                              baseColor:Colors.white30,
                              highlightColor:Colors.grey.shade300 ,
                              child:Column(
                                children: [
                                  ListTile(
                                    leading:Container(height:50,width:50,color:Colors.white,),
                                    title:Container(height:10,width:89,color:Colors.white,),
                                    subtitle:Container(height:10,width:89,color:Colors.white,),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                    else
                    {
                      return ListView.builder(
                          itemCount:snapshot.data!.length,
                          itemBuilder:(context,index)
                          {
                            String name=snapshot.data![index]['country'].toString();
                            if(controller.text.isEmpty)
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>CountryDetail(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'] ,
                                        totalCases:  snapshot.data![index]['cases'] ,
                                        totalRecovered: snapshot.data![index]['recovered'] ,
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'] ,
                                      )));
                                    },
                                    child: ListTile(
                                        title:Text(snapshot.data![index]['country'].toString(),style:TextStyle(color:constant.greenColor),),
                                        subtitle:Text(constant.numberFormat.format(snapshot.data![index]['cases']),style:TextStyle(color:constant.black45)),
                                        leading:Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]['countryInfo']['flag']))
                                    ),
                                  ),
                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(controller.text.toLowerCase()))
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>CountryDetail(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'] ,
                                        totalCases:  snapshot.data![index]['cases'] ,
                                        totalRecovered: snapshot.data![index]['recovered'] ,
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'] ,
                                      )));
                                    },
                                    child:ListTile(
                                        title:Text(snapshot.data![index]['country'].toString(),style:TextStyle(color:constant.greenColor),),
                                        subtitle:Text(constant.numberFormat.format(snapshot.data![index]['cases']),style:const TextStyle(color:Colors.black45)),
                                        leading:Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]['countryInfo']['flag'])),
                                    ),
                                  ),
                                ],
                              );
                            }
                            else
                            {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
