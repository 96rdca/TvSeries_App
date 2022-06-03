class Rating {
  double? average;

  Rating({this.average});

  Rating.fromJson(Map<String, dynamic> json) {
    average = double.tryParse(json['average'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['average'] = average;
    return data;
  }
}
