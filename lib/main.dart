import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // const Calculator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  // const SimpleCalculator({Key? key}) : super(key: key);
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPress(String buttonText){
    setState(() {
      // -----------      CLEAR STATE     --------------
      if (buttonText == 'C'){
        equation = '0';
        equation = '0';
        equationFontSize = 38;
        resultFontSize = 48;
      }
      // -----------    BACKSPACE STATE    --------------
      else if (buttonText == '⌫'){
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0,equation.length - 1); // to remove one character
        if (equation == ''){
          equation = '0';
        }
      }
      else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          // Change expression value
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result = 'Error';
        }
      }
      // --------   NORMAL STATE  ------------
      else {
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == '0'){
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color : Colors.white, width: .82,
                style: BorderStyle.solid)
        ),
        padding: EdgeInsets.all(14.0),
        onPressed: () => buttonPress(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(result,style: TextStyle(fontSize:resultFontSize),),
          ),
          
          Expanded(child: Divider(),),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.orangeAccent),
                        buildButton("⌫", 1, Colors.orangeAccent),
                        buildButton("÷", 1, Colors.orangeAccent),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54),
                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.orangeAccent),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.orangeAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.orangeAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.orangeAccent),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

