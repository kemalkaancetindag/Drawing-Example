import 'package:drawing_tutorial/drawing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExplanationPage extends StatefulWidget{
  @override
  _ExplanationPageState createState() => _ExplanationPageState();

}

class _ExplanationPageState extends State<ExplanationPage> {
  _ExplanationPageState({Key? key});




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,

        child: Stack(
          children: [
            Positioned(
              top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: RotatedBox(
                  quarterTurns: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("images/ex_gif.gif")
                        )
                    ),
                  ),
                )
            ),
            Positioned(
              right: 5,
                top: 5,
                child:RotatedBox(
                  quarterTurns: 0,
                  child:  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrawingPage()),
                      );
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Şimdi Sıra Sende'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Öncelikle referans noktaları eğitimde görüldüğü gibi birleştirin'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Başla',
                                  style: TextStyle(
                                      color: Colors.green
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child:Container(
                        width: MediaQuery.of(context).size.width/2.61,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height/147.49),
                            border: Border.all(color: Colors.white)
                        ),
                        child: Center(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Devam",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.height/29.5
                                ),
                              ),
                              Icon(Icons.skip_next, color: Colors.white,)
                            ],
                          ),
                        )

                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
