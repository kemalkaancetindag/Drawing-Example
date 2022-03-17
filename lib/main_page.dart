import 'package:drawing_tutorial/drawing_page.dart';
import 'package:drawing_tutorial/explanation_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExplanationPage()),
            );
          },
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width/1.57,
              height:  MediaQuery.of(context).size.height/14.75,
              decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height/73.745)
              ),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Oyuna Başla",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height/29.498
                        ),
                      ),
                      Icon(Icons.start,color: Colors.white,)
                    ],
                  )
              ),
            ),
          ),
        )
      ),
    );
  }
}
