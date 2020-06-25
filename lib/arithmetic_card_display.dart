import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArithmeticCardDisplay extends StatefulWidget {
  final String question;
  final String answer;
  final int index;
  final int deckSize;
  final bool showAnswer;

  ArithmeticCardDisplay(this.index, this.deckSize, this.question, this.answer, this.showAnswer);
  @override
  _ArithmeticCardDisplayState createState() => _ArithmeticCardDisplayState();
}

class _ArithmeticCardDisplayState extends State<ArithmeticCardDisplay> {

  @override
  Widget build(BuildContext context) {

    double phoneHeight = MediaQuery.of(context).size.height;
    double phoneWidth = MediaQuery.of(context).size.width;
    double boxHeight = phoneHeight * .75;
    double cardWidth = phoneWidth * .8;
    double digitFontSize = cardWidth * .33;
    TextStyle cardTextStyle = new TextStyle(inherit: true, fontSize: digitFontSize, color: Colors.black);
    double dividerThickness = digitFontSize/20;

    _dividerIfQuestion(){
      if(!widget.showAnswer){
        return Divider(
          color: Colors.black,
          thickness: dividerThickness,

        );
      }else return Container();

    }

    _questionOrAnswer(){
      if(widget.showAnswer){
        return widget.answer;
      }
      else{
        return widget.question;
      }
    }


    return Container(
      height: boxHeight,
      color: Colors.blueGrey,

      child: Stack(

        children: <Widget>[
          Container(

            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black,
                      width: 5.0,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: (.5 * boxHeight),
            right: (.40 * cardWidth),

            child: Text(
              _questionOrAnswer(),
              textAlign: TextAlign.right,
              style: cardTextStyle,

            ),
          ),
          Positioned(
            bottom: (.45 * boxHeight),
            right: (.35 * cardWidth),
            width: 180,
            child: _dividerIfQuestion(),
          ),
        ],
      ),
    );

  }










}
