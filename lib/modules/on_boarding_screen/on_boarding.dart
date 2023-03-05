
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:frist_app/modules/login/login.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/network/local/chache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel(
    {
      required this.image ,
      required this.title,
      required this.body
    }
  );
}
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/images/onboard1.jpg', 
    title: 'On Board 1 Title',
     body: 'On Board 1 Body'),
    BoardingModel(image: 'assets/images/onboard1.jpg',
     title: 'On Board 2 Title', 
     body: 'On Board 2 Body'),
    BoardingModel(image: 'assets/images/onboard1.jpg',
     title: 'On Board 3 Title',
      body: 'On Board 3 Body')
  ];
void Skip()
  {
    CacheHelper.saveData(key: 'Skipped' , value: true).then((value) {
      if(value)
      {
        NavigateAndFinish(context , ShopLoginScreen());
      }
    },).catchError((onError)
    {
      print('Error : ${onError}');
    });
  
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar:  AppBar(
          actions: [
            TextButton(onPressed: ()
            {
              Skip();
            }, child: Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index)
                {
                  if(index == boarding.length-1)
                      setState(() {
                        isLast = true;
                      }); 
                         else 
                      setState(() {
                        isLast = false;
                      });
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder:(context, index) {
                return buildOnBoardItem(boarding[index]);
              },
              itemCount: boarding.length,),
            ),
            SizedBox(
            height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  controller: boardController, 
                count: boarding.length),
                Spacer(), 
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                  Skip();
                  else 
                  {
                     boardController.nextPage(duration: Duration(
                      milliseconds: 750
                    ), curve: Curves.fastLinearToSlowEaseIn);  
                  } 
                },child:  Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],),
        ),
      );
      
  }

  Widget buildOnBoardItem(BoardingModel item) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
            child: Image(
              image: AssetImage(item.image),
            ),
          ),
          Text(item.title , 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox( 
            height: 15,
          ),
          Text(item.body , 
          style: TextStyle(fontSize: 14,)),
          SizedBox( 
            height: 15,
          ),
        ]);
}
