import 'package:Health_Calculator/home.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class KalorienCalculator extends StatefulWidget {
  const KalorienCalculator({Key? key}) : super(key: key);

  @override
  State<KalorienCalculator> createState() => _KalorienCalculatorState();
}

class _KalorienCalculatorState extends State<KalorienCalculator> {
  int currentindex = 0;
  String result ="";
  int height = 0;
  int weight = 0;
  int alter = 0;
  double _currentSliderValue = 0.95;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController alterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        appBar: AppBar(
          title: Text(
            "Kalorien Rechner",
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
                SizedBox(
                  height: 20.0,
                ),
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
                  height: 8.0,
                ),
                Text("Wie sportlich/aktiv sind Sie? (0.95=nur schlafend / 2.4=sportlich)",
                  style: TextStyle(
                    fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Slider(
                value: _currentSliderValue,
                max: 2.4,
                min: 0.95,

                divisions: 10,
                label: _currentSliderValue.toStringAsFixed(2),
                onChanged: (double value) {
                setState(() {
                _currentSliderValue = value;
                });
                },
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
                    "Dein Kalorienbedarf beträgt :",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Text(
                    "$result",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.normal,
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
        calculateKal(height, weight, alter, _currentSliderValue);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }
  void calculateKal(double height, double weight, double alter, double _currenSliderValue){
    double finalresult = 0;

    if(currentindex == 0){
      finalresult = 66.47 + (13.7 * weight) + (5 * height) - (6.8 * alter);

    }else {
      finalresult = 655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * alter);
    }
    finalresult = finalresult * _currentSliderValue;
    String bmi = finalresult.toStringAsFixed(0) + " kcal";
    setState((){
      result = bmi;
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