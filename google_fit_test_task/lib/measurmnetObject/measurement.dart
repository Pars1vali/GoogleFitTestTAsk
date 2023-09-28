import 'fieldMeasurements.dart';

class Measurement {
  String? type;
  String? dateStart;
  String? dateEnd;
  List<FieldMeasurements>? fieldMeasurements;

  Measurement(
      {this.type, this.dateStart, this.dateEnd, this.fieldMeasurements});

  Measurement.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];

    if (json['FieldMeasurements'] != null) {
      fieldMeasurements = <FieldMeasurements>[];
      json['FieldMeasurements'].forEach((v) {
        fieldMeasurements!.add(FieldMeasurements.fromJson(v));
      });
    }
    
  }

  


}
