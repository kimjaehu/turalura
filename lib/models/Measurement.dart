class Measurement {
  DateTime measureDate;
  int day;
  double height;
  double weight;
  String unit;
  double heightPercentile;
  double weightPercentile;

  Measurement(this.measureDate, this.day, this.height, this.weight, this.unit, this.heightPercentile,this.weightPercentile);

  Map<String, dynamic> toJson() => {
    'measureDate': measureDate,
    'day': day,
    'height': height,
    'weight': weight,
    'unit':unit,
    'heightPercentile': heightPercentile,
    'weightPercentile': weightPercentile
  };
}
