import 'package:Health_Calculator/home.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class BfiCalculator extends StatefulWidget {
  const BfiCalculator({Key? key}) : super(key: key);

  @override
  State<BfiCalculator> createState() => _BfiCalculatorState();
}

class _BfiCalculatorState extends State<BfiCalculator> {
  int currentindex = 0;
  String result ="";
  String wordAfter = "";
  int height = 0;
  int weight = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController alterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "BFI Rechner",
            style: TextStyle(color: Colors.black),),
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Home();
                    }),
                  );
                },
                icon: Icon(Icons.home,
                  color: Colors.black,

                )
            )
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    radioButton("Mann", Colors.blue, 0),
                    radioButton("Frau", Colors.pink, 1),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                Text("Deine Grösse in Cm :",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Dein Grösse in Cm",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none)
                    )
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Dein Gewicht in Kg :",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Dein Gewicht in Kg",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none)
                    )
                ),
                SizedBox(height: 20.0,),
                Text("Dein Alter :",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: alterController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Dein Alter:",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none)
                    )
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: (){},
                    color: Colors.blue,
                    child: Text("Schüttle zum berechnen der Daten", style: TextStyle(color: Colors.white,
                    ),
                    ),
                  ),
                ),


                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Dein Fettanteil beträgt :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "$result",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "$wordAfter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        double height = double.parse(heightController.value.text);
        double weight = double.parse(weightController.value.text);
        double alter = double.parse(alterController.value.text);
        calculateBfi(height, weight, alter);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  void calculateBfi(double height, double weight, double alter){
    double finalresult = weight / (height * height/10000);
    String wordAfterBfi = "";
    double finalBfi = 0;
    if(currentindex == 0){
      finalBfi = ((1.2 * finalresult) + (0.23 * alter)) - 16.2;
      if(alter >17 && alter <= 40){
        if(finalBfi < 8){
          wordAfterBfi = "zu wenig Fettanteil";
        }else if(finalBfi >= 8 && finalBfi <= 19){
          wordAfterBfi = "gesunder Fettanteil";
        }else if(finalBfi >= 19 && finalBfi <= 25){
          wordAfterBfi = "Fettanteil ist zu viel";
        }else if(finalBfi > 25){
          wordAfterBfi = "Fettanteil ist sehr viel";
        }
      } else if(alter >40 && alter <= 60){
        if(finalBfi < 11){
          wordAfterBfi = "zu wenig Fettanteil";
        }else if(finalBfi >= 11 && finalBfi <= 22){
          wordAfterBfi = "gesunder Fettanteil";
        }else if(finalBfi >= 22 && finalBfi <= 27){
          wordAfterBfi = "Fettanteil ist zu viel";
        }else if(finalBfi > 27){
          wordAfterBfi = "Fettanteil ist sehr viel";
        }
      }else if(alter >60 && alter <80){
        if(finalBfi < 13){
          wordAfterBfi = "zu wenig Fettanteil";
        }else if(finalBfi >= 13 && finalBfi <= 25){
          wordAfterBfi = "gesunder Fettanteil";
        }else if(finalBfi >= 25 && finalBfi <= 30){
          wordAfterBfi = "Fettanteil ist zu viel";
        }else if(finalBfi > 30){
          wordAfterBfi = "Fettanteil ist sehr viel";
        }
      }
    }else if(currentindex == 1){
      finalBfi = (1.2 * finalresult) + (0.23 * alter) - 5.4;
      if(alter >17 && alter <= 40){
        if(finalBfi < 21){
          wordAfterBfi = "zu wenig Fettanteil";
        }else if(finalBfi >= 21 && finalBfi <= 33){
          wordAfterBfi = "gesunder Fettanteil";
        }else if(finalBfi >= 33 && finalBfi <= 39){
          wordAfterBfi = "Fettanteil ist zu viel";
        }else if(finalBfi > 39){
          wordAfterBfi = "Fettanteil ist sehr viel";
        }
      } else if(alter >40 && alter <= 60){
        if(finalBfi < 23){
          wordAfterBfi = "zu wenig Fettanteil";
        }else if(finalBfi >= 23 && finalBfi <= 35){
          wordAfterBfi = "gesunder Fettanteil";
        }else if(finalBfi >= 35 && finalBfi <= 40){
          wordAfterBfi = "Fettanteil ist zu viel";
        }else if(finalBfi > 40){
          wordAfterBfi = "Fettanteil ist sehr viel";
        }
      }else if(alter >60 && alter <80){
        if(finalBfi < 24){
          wordAfterBfi = "zu wenig Fettanteil";
        }else if(finalBfi >= 24 && finalBfi <= 36){
          wordAfterBfi = "gesunder Fettanteil";
        }else if(finalBfi >= 36 && finalBfi <= 42){
          wordAfterBfi = "Fettanteil ist zu viel";
        }else if(finalBfi > 42){
          wordAfterBfi = "Fettanteil ist sehr viel";
        }
      }
    }
    String bfi = finalBfi.toStringAsFixed(2) +"%" ;

    setState((){
      result = bfi;
      wordAfter = wordAfterBfi;
    });
  }
  void changeIndex(int index){
    setState((){
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index){
    return Expanded(
      child: Container(

        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        child: FlatButton(
          color: currentindex == index? color: Colors.grey[200],
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),


          onPressed: () {
            changeIndex(index);
          },
          child: Text(value, style: TextStyle(
            color: currentindex == index? Colors.white : color,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
}