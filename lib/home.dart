import 'package:Health_Calculator/bfi.dart';
import 'package:Health_Calculator/bmi.dart';
import 'package:Health_Calculator/kalorien.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Wähle deinen Rechner aus",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BmiCalculator();
                      }),
                    );
                  },


                  child: Text("BMI Rechner" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),),

                ),

                SizedBox(
                  height: 60.0,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return KalorienCalculator();
                      }),
                    );
                  },

                  child: Text("Kalorienbedarf Rechner" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),),


                ),
                SizedBox(
                  height: 60.0,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BfiCalculator();
                      }),
                    );
                  },

                  child: Text("Fettanteil Rechner" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),),


                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
