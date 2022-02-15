import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  static List<int> snakePosition =[45,65,85,105,125];

  int numberOfSquares= 760;
  static var randomNumber =Random();
  int food =randomNumber.nextInt(700);
  void genNewFood(){
    food = randomNumber.nextInt(700);
  }

  void startGame(){
    snakePosition =[45,65,85,105,125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();


    });

  }
  var direction ='down';
  void updateSnake(){
    setState(() {
      switch(direction){
        case 'down':
          if (snakePosition.last>740){
            snakePosition.add(snakePosition.last +20 -760);
          }


      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: numberOfSquares,


                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20),
                      itemBuilder:(BuildContext context, int index){
                      if (snakePosition.contains(index)){
                        return Center(

                        )
                      }
                      }
                  ),
                ),

              )

          )
        ],
      ),
    );
  }
}
