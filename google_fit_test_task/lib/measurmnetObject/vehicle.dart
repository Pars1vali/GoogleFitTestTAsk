// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

 enum UnitMeasurement{
  step(dataType: "com.google.step_count.delta", unitMeasurement: "шагов", averageValue: 10000),
  calories(dataType: "com.google.calories.expended", unitMeasurement: "ккал", averageValue: 2350),
  speed(dataType: "com.google.speed.summary", unitMeasurement: "метров/cек", averageValue: 0.61),
  bmr(dataType: "com.google.calories.bmr.summary", unitMeasurement: "ккал/день", averageValue: 2350),
  percentage(dataType: "com.google.body.fat.percentage.summary", unitMeasurement: "%", averageValue: 20),
  distance(dataType: "com.google.distance.delta", unitMeasurement: "метров", averageValue: 6000),
  heartMinutes(dataType: "com.google.heart_minutes.summary", unitMeasurement: "ударов/сек", averageValue: 75),
  heartRateSummary(dataType: "com.google.heart_rate.summary", unitMeasurement: "ударов/сек", averageValue: 75),
  height(dataType: "com.google.height.summary", unitMeasurement: "метров", averageValue: 1.8),
  hydration(dataType: "com.google.hydration", unitMeasurement: "литров", averageValue: 3),
  activeMinutes(dataType: "com.google.active_minutes", unitMeasurement: "минут активности", averageValue: 120),
  power(dataType: "com.google.power.summary", unitMeasurement: "кВт*ч", averageValue: 2),
  weight(dataType: "com.google.weight.summary", unitMeasurement: "кг", averageValue: 70);

  const  UnitMeasurement({
    required this.dataType,
    required this.unitMeasurement,
    required this.averageValue,
  });

  final String dataType;
  final String unitMeasurement;
  final double averageValue;
}
