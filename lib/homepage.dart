import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String history = "";
  String ansStr = "";

  void buttonPress(String numberStr) {
    
    setState(() {

      if( numberStr == "=" ) {
        try {
          Parser p = Parser();
          Expression exp = p.parse(history);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          ansStr = eval.toString();
        } catch(e) {
          print(e);
        }
        
      } else {
         if(numberStr == 'C') {
          ansStr = "";
          return;
        } else if( numberStr == "+" || numberStr == "-" || numberStr == "/" || numberStr == "*" ) {
          ansStr = "";
        } else {
          ansStr += numberStr;
        }

        history += numberStr; 
      }
     
    });
  }

  void clearAll() {
    setState(() {
      ansStr = "";
      history = "";      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // History
          Container(
            child: Text(
              history,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
              ),
            ),
            alignment: Alignment(1,1),
          ),
          // Answer
          Container(
            child: Text(
              ansStr,
              style: TextStyle(
                fontSize: 48,
                color: Colors.white
              ),  
            ),
            alignment: Alignment(1,1),
          ),

          SizedBox(
            height: 40,
          ),

          // Calculator buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _calButton(numText: "1", buttonPress: buttonPress),
              _calButton(numText: "2", buttonPress: buttonPress),
              _calButton(numText: "3", buttonPress: buttonPress),
              _calButton(numText: "*", buttonPress: buttonPress),
            ],
          ),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _calButton(numText: "4", buttonPress: buttonPress),
              _calButton(numText: "5", buttonPress: buttonPress),
              _calButton(numText: "6", buttonPress: buttonPress),
              _calButton(numText: "-", buttonPress: buttonPress),
            ],
          ),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _calButton(numText: "7", buttonPress: buttonPress),
              _calButton(numText: "8", buttonPress: buttonPress),
              _calButton(numText: "9", buttonPress: buttonPress),
              _calButton(numText: "+", buttonPress: buttonPress),
            ],
          ),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _calButton(numText: "C", buttonPress: buttonPress, longPress: clearAll),
              _calButton(numText: "0", buttonPress: buttonPress),
              _calButton(numText: "=", buttonPress: buttonPress),
              _calButton(numText: "/", buttonPress: buttonPress),
            ],
          ),
          
        ],
      ),
    );
  }
}


// Function to create the button widget
// Reusable functions
Widget _calButton({ String numText, Function buttonPress, Function longPress }){
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: MaterialButton(
      onPressed: () {
        buttonPress(numText);
      },
      onLongPress: (){
        if(longPress != null) {
          longPress();
        } else {
          buttonPress(numText);
        }
        
      },
      height: 100,
      child: Text(
        numText,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textColor: Colors.black,
      color: Colors.grey[100],
    ),
  );
}