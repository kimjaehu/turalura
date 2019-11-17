class Measurement {
  DateTime measureDate;
  int day;
  double height;
  double weight;
  String unit;

  Measurement(this.measureDate, this.day, this.height, this.weight, this.unit);

  Map<String, dynamic> toJson() => {
    'measureDate': measureDate,
    'day': day,
    'height': height,
    'weight': weight,
    'unit':unit,
  };
}
