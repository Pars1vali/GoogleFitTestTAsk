import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:google_fit_test_task/measurmnetObject/measurement.dart';
var measurements = [];

requestData() async {
  const platform = MethodChannel('samples.flutter.dev/readFitData');

  try {
    final decoded = json.decode(await platform.invokeMethod('readFitData'));

    print(decoded);

    for (final item in decoded) {
      measurements.add(Measurement.fromJson(item));
    }
  } on PlatformException catch (e) {
    print("Error: '${e.message}'.");
  }
}
