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
  Duration duration = Duration(milliseconds:50);
  int _selectedColor=0;
  static var randomNumber =Random();
  int food =randomNumber.nextInt(700);
  void generateNewFood(){
    int food1= randomNumber.nextInt(700);
    while(snakePosition.contains(food1)){
      food1= randomNumber.nextInt(700);


    }
    food =food1;

  }

  void startGame(){
    snakePosition =[45,65,85,105,125];
    const duration = const Duration(milliseconds: 50);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()){
        timer.cancel();
        _showGameOverScreen();
      }


    });

  }
  var direction ='down';
  void updateSnake(){
    setState(() {
      switch(direction) {
        case 'down':
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last + 20 - 760);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }

          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 760);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;
        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        default:
      }

      if (snakePosition.last ==food){
        generateNewFood();
        setState(() {

          duration=Duration(milliseconds: 350- 10*(snakePosition.length-5));
        });


      }else{
        snakePosition.removeAt(0);
      }
    });

  }
  bool gameOver(){
    for(int i=0; i<snakePosition.length;i++){
      int count=0;
      for(int j=0;j<snakePosition.length; j++){
        if(snakePosition[i] == snakePosition[j]){
          count += 1;

        }
        if (count==2){
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("GAME OVER"),
        content: Text('Your Score:' +snakePosition.length.toString()),
        actions: [
          ElevatedButton(onPressed:(){
            startGame();
            Navigator.of(context).pop();
          } , child: Text("Play Again!"))
        ],
      );

    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
                child: GestureDetector(

                  onVerticalDragUpdate: (details){
                    if(direction != 'up' && details.delta.dy >0 ){
                      direction ='down';
                    }else if (direction!='down'&& details.delta.dy<0){
                      direction ='up';

                    }
                  },
                  onHorizontalDragUpdate: (details){
                    if(direction !='left' && details.delta.dx>0){
                      direction='right';

                    } else if (direction!='right' && details.delta.dx <0){
                      direction ='left';
                    }
                  },


                  child: Container(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        itemCount: numberOfSquares,


                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20),
                        itemBuilder:(BuildContext context, int index){
                        if (snakePosition.contains(index)){
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(color: getColor(_selectedColor),),
                              ),
                            ),

                          );
                        }
                        if (index==food){
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: Colors.green,),



                            ),
                          );
                        }
                        else{
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: Colors.grey[900],),

                            ),
                          );
                        }
                        }
                    ),
                  ),

                )

            ),

            Padding(padding: EdgeInsets.only(bottom: 20,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: startGame,
                    child: Text("S T A R T", style: TextStyle(color: Colors.white,fontSize: 20),),

                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color:   ",
                          style: TextStyle(color: Colors.white,fontSize: 20)),
                      SizedBox(height: 8,),
                      Wrap(
                        children: List<Widget>.generate(4, (int index) => GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedColor=index;
                            });


                          },

                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index==0?Colors.white:index==1?Colors.greenAccent:index==2?Colors.redAccent:Colors.orangeAccent,
                              child: _selectedColor==index?Icon(Icons.done,
                                color: Colors.black,
                                size: 16,):Container(),

                            ),
                          ),
                        )),
                      )
                    ],
                  )

                ],
              ),


            )],
        ),
      ),
    );
  }
  Color getColor(int _selectedColor){
    if (_selectedColor==2){
      return Colors.redAccent;
    }
    else if (_selectedColor==1){
      return Colors.greenAccent;


    }
    if (_selectedColor==3){
      return Colors.orangeAccent;

    }
    else{
      return Colors.white;
    }
  }
}
