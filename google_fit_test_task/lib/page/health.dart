// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fit_test_task/login/googleAccount.dart';
import 'package:google_fit_test_task/measurmnetObject/vehicle.dart';
import '../api/fit_reqest.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';


class HealthPage extends StatelessWidget {
  const HealthPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
        textDirection: TextDirection.ltr,
        children: [
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
            ),
            itemCount: measurements.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      CircularSeekBar(
                          width: double.infinity,
                          height: 250,
                          progress: getProgress(index),
                          barWidth: 10,
                          startAngle: 0,
                          minProgress: 0,
                          maxProgress: getUnitMeasurement(index, "averageValue"),
                          sweepAngle: 360,
                          strokeCap: StrokeCap.butt,
                          progressColor: Color.fromARGB(255, 37, 199, 46),
                          innerThumbRadius: 5,
                          innerThumbStrokeWidth: 3,
                          innerThumbColor: Colors.white,
                          outerThumbRadius: 5,
                          outerThumbStrokeWidth: 10,
                          outerThumbColor: Color.fromARGB(255, 25, 103, 38),
                          animation: true,
                          interactive: false),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,90,0,0),
                        child: Align(
                        alignment: Alignment.center,
                        child: Text(getUnitMeasurement(index, "unit"),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 19,
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                      )
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            measurements
                                .elementAt(index)
                                .fieldMeasurements
                                .elementAt(0)
                                .value,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 19,
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                            formatType((measurements.elementAt(index).type)
                                .split('com.google.')[1]),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                      )
                    ],
                  ));
            }),
        Positioned(
            top: 40,
            right: 0,
            child: RawMaterialButton(
              onPressed: () async {
                measurements.clear();
                await signOutWithGoogle();
                Navigator.of(context).pop();
              },
              elevation: 2.0,
              fillColor: Colors.white,
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              child: const Icon(
                Icons.exit_to_app,
                size: 25.0,
              ),
            )),
      ],
    ));
  }
}

getProgress(int index) {
    return double.parse(measurements.elementAt(index).fieldMeasurements[0].value);
  }

formatType(String type) {
    final newString = type.replaceAll('_', ' ').replaceAll(RegExp('\\.[A-Za-z]+'),'');
    return newString.toUpperCase();
  }

getUnitMeasurement(int index, String goal){
    final measurement = measurements.elementAt(index).type;

    for (var unit in UnitMeasurement.values) {
        if(measurement == unit.dataType && goal=="unit"){
          return unit.unitMeasurement;
        }else if(measurement == unit.dataType && goal=="averageValue"){
          return unit.averageValue;
        }
      }
  }