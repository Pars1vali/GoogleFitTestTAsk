
class FieldMeasurements {
  String? type;
  String? value;

  FieldMeasurements({this.type, this.value});

  FieldMeasurements.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }
}