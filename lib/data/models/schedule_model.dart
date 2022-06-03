import 'package:seriestv_jobcity/common/extensions/string_extensions.dart';

class Schedule {
  String? time;
  List<String>? days;

  Schedule({this.time, this.days});

  Schedule.fromJson(Map<String, dynamic> json) {
    time = json['time']?.toString().parseTime();
    days = json['days']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['time'] = time;
    data['days'] = days;
    return data;
  }
}
