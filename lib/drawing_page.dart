import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_page.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage>{



  _DrawingPageState({Key? key});







  var _startTuple = <double>[];
  var _endTuple = <double>[];
  var _isTutorial = true;
  var _isTutorialDone = false;
  late BuildContext buildContext;
  var _isDone = false;
  List<List<List<double>>> _drawedLines = [];
  List<Offset> _tutorialPointOffsets =  [];
  List<List<double>> _tutorialPointsMatrix = [];
  List<List<List<double>>> _confirmedLines = [];




  void _startStroke(double x, double y) {
    _startTuple = [];
    _startTuple.add(x);
    _startTuple.add(y);


  }

  void _moveStroke(double x, double y) {
    setState(() {
      _endTuple = [];
      _endTuple.add(x);
      _endTuple.add(y);
    });
    print("yeni");
    print(_startTuple);
    print(_endTuple);

  }

  void _setDrawedLines(){
    setState(() {
      _drawedLines.add([_startTuple,_endTuple]);
    });
  }

  void _confirmLine(){

    for(int i = 0; i <= _tutorialPointsMatrix.length; i++){
      if(i+1 <= _tutorialPointsMatrix.length){
        if(
        ((_startTuple[0] <= _tutorialPointsMatrix[i][0] + 10) && (_startTuple[0] >= _tutorialPointsMatrix[i][0] - 10))
            &&
            ((_endTuple[0] <= _tutorialPointsMatrix[i+1][0] + 10) && (_endTuple[0] >= _tutorialPointsMatrix[i+1][0] - 10))
        ){
         setState(() {
           _confirmedLines.add([_tutorialPointsMatrix[i],_tutorialPointsMatrix[i+1]]);
           _drawedLines = [];
         });

         if(_confirmedLines.length == _tutorialPointsMatrix.length-1){
           setState(() {
             _isTutorialDone = true;
             if(!_isTutorial){
               _isDone = true;
             }
           });

           if(_isTutorial && _isTutorialDone){
             showDialog<void>(
               context: context,
               barrierDismissible: false, // user must tap button!
               builder: (BuildContext context) {
                 return  RotatedBox(
                   quarterTurns: 0,
                   child: AlertDialog(
                     backgroundColor: Colors.white,
                     title: const Text('Tebrikler!'),
                     content: SingleChildScrollView(
                       child: ListBody(
                         children: const <Widget>[
                           Text('Şimdi sıra sizde'),
                         ],
                       ),
                     ),
                     actions: <Widget>[
                       TextButton(
                         child: const Text(
                           'Devam',
                           style: TextStyle(
                               color: Colors.green
                           ),
                         ),
                         onPressed: () {
                           setState(() {
                             _isTutorial = false;
                             _isDone = false;
                             _drawedLines = [];
                             _confirmedLines = [];
                           });
                           Navigator.of(context).pop();
                         },
                       ),
                     ],
                   ),
                 );
               },
             );

           }
           else if(!_isTutorial && _isDone){
             showDialog<void>(
               context: context,
               barrierDismissible: false, // user must tap button!
               builder: (BuildContext context) {
                 return  RotatedBox(
                   quarterTurns: 0,
                   child: AlertDialog(
                     backgroundColor: Colors.white,
                     title: const Text('Tebrikler!'),
                     content: SingleChildScrollView(
                       child: ListBody(
                         children: const <Widget>[
                           Text('Bütün dalgalanmaları yakaladınız'),
                         ],
                       ),
                     ),
                     actions: <Widget>[
                       TextButton(
                         child: const Text(
                           'Ana sayfa',
                           style: TextStyle(
                               color: Colors.green
                           ),
                         ),
                         onPressed: () {
                           setState(() {
                             _isTutorial = false;
                             _isDone = false;
                             _drawedLines = [];
                             _confirmedLines = [];
                           });
                           SystemChrome.setPreferredOrientations([
                             DeviceOrientation.landscapeRight,
                             DeviceOrientation.landscapeLeft,
                             DeviceOrientation.portraitUp,
                             DeviceOrientation.portraitDown,
                           ]);
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => MainPage()),
                           );

                         },
                       ),
                     ],
                   ),
                 );
               },
             );
           }

         }


        }
        else{

        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);


    setState(() {
      _tutorialPointOffsets = [
        Offset((MediaQuery.of(context).size.width/1.122)/4.98,(MediaQuery.of(context).size.height/1.23)/9.6 ),
        Offset((MediaQuery.of(context).size.width/1.122)/2.7,(MediaQuery.of(context).size.height/1.23)/1.20,),
        Offset((MediaQuery.of(context).size.width/1.122)/1.72,(MediaQuery.of(context).size.height/1.23)/8.9),
        Offset((MediaQuery.of(context).size.width/1.122)/1.36,(MediaQuery.of(context).size.height/1.23)/1.28)
      ];
      _tutorialPointsMatrix = [
        [(MediaQuery.of(context).size.width/1.122)/4.98,(MediaQuery.of(context).size.height/1.23)/9.6],
        [(MediaQuery.of(context).size.width/1.122)/2.7,(MediaQuery.of(context).size.height/1.23)/1.20],
        [(MediaQuery.of(context).size.width/1.122)/1.72,(MediaQuery.of(context).size.height/1.23)/8.9],
        [(MediaQuery.of(context).size.width/1.122)/1.36,(MediaQuery.of(context).size.height/1.23)/1.28]
      ];
    });
    return Scaffold(
      backgroundColor: Color(0xFF171b26),
      body: GestureDetector(
          onPanDown: (details) => _startStroke(
             details.localPosition.dx - ((MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width/1.122))/2),
            details.localPosition.dy- ((MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height/1.23))/2),
          ),
          onPanUpdate: (details) => _moveStroke(
            details.localPosition.dx - ((MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width/1.122))/2),
            details.localPosition.dy- ((MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height/1.23))/2),
          ),
          onPanEnd: (details){
            _setDrawedLines();
            _confirmLine();
          },
          child:Stack(
            children: [
              Center(
                  child: RotatedBox(
                    quarterTurns: 0,
                    child:  Container(
                      width: MediaQuery.of(context).size.width/1.122,
                      height: MediaQuery.of(context).size.height/1.23,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill
                              ,
                              image: AssetImage("images/barchart.png")
                          )
                      ),
                    ),
                  )
              ),
              Center(
                child: RotatedBox(
                  quarterTurns: 0,
                  child: Container(
                    width:  MediaQuery.of(context).size.width/1.122,
                    height:MediaQuery.of(context).size.height/1.23,
                    child: CustomPaint(
                      painter: DrawingPainter(_startTuple,_endTuple,_drawedLines,_isTutorial,_tutorialPointOffsets,_tutorialPointsMatrix,_confirmedLines),
                    ),
                  ),
                )
              ),

            ],
          )
      ),
    );
  }
}
class DrawingPainter extends CustomPainter {
  final List<List<List<double>>> drawedLines;
  final List<double> startTuple;
  final List<double> endTuple;
  final List<Offset> tutorialPointOffsets;
  final List<List<double>> tutorialPointsMatrix;
  final List<List<List<double>>> confirmedLines;
  bool isTutorial;

  DrawingPainter(this.startTuple, this.endTuple, this.drawedLines, this.isTutorial,this.tutorialPointOffsets,this.tutorialPointsMatrix,this.confirmedLines);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke;

    final confirmedLinePaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.lightGreen
      ..style = PaintingStyle.stroke;

    final circlePaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;

    final tutorialCirclePaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.lightGreen
      ..style = PaintingStyle.fill;



    drawedLines.forEach((line) {
      canvas.drawCircle(Offset(line[0][0],line[0][1]), 3, circlePaint);
      canvas.drawCircle(Offset(line[1][0],line[1][1]), 3, circlePaint);
      canvas.drawLine(
          Offset(line[0][0],line[0][1]),
          Offset(line[1][0],line[1][1]),
          paint
      );
    });

    if(isTutorial){
      tutorialPointOffsets.forEach((element) {
        canvas.drawCircle(element, 5, tutorialCirclePaint);
      });


    }

    confirmedLines.forEach((element) {
      canvas.drawLine(
          Offset(element[0][0],element[0][1]),
          Offset(element[1][0],element[1][1]),
          confirmedLinePaint
      );
    });

    canvas.drawCircle(Offset(startTuple[0],startTuple[1]), 3, circlePaint);


    canvas.drawLine(
        Offset(startTuple[0],startTuple[1]),
        Offset(endTuple[0],endTuple[1]),
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}