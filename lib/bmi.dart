import 'package:Health_Calculator/home.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentindex = 0;
  String result ="";
  String wordAfter = "";
  int height = 0;
  int weight = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
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
                    "Dein BMI ist :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
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
                  height: 40.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "$wordAfter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
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
        calculateBmi(height, weight);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  void calculateBmi(double height, double weight){
    double finalresult = weight / (height * height/10000);
    String wordAfterBmi = "";
    if(finalresult < 18.5){
      wordAfterBmi = "Untergewicht";
    } else if(finalresult < 25 && finalresult >= 18.5){
      wordAfterBmi = "Normalgewicht";
    }else if(finalresult < 30 && finalresult >= 25){
      wordAfterBmi = "Übergewicht/ Präadipositas";
    }else if(finalresult < 35 && finalresult >= 30){
      wordAfterBmi = "Adipositas Grad I";
    }else if(finalresult < 40 && finalresult >= 35){
      wordAfterBmi = "Adipositas Grad II";
    }else if(finalresult > 40){
      wordAfterBmi = "Adipositas Grad III";
    }
    String bmi = finalresult.toStringAsFixed(2) ;

    setState((){
      result = bmi;
      wordAfter = wordAfterBmi;
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