import 'package:seriestv_jobcity/common/extensions/string_extensions.dart';

import 'image_model.dart';
import 'rating_model.dart';
import 'schedule_model.dart';

class TvShow {
  int? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  int? runtime;
  String? premiered;
  String? ended;
  Schedule? schedule;
  Rating? rating;
  Image? image;
  String? summary;

  TvShow(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.language,
      this.genres,
      this.status,
      this.runtime,
      this.premiered,
      this.ended,
      this.schedule,
      this.rating,
      this.image,
      this.summary});

  TvShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    language = json['language'];
    genres = json['genres']?.cast<String>();
    status = json['status'];
    runtime = json['runtime'];
    premiered = json['premiered'];
    ended = json['ended'];
    schedule =
        json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary']?.toString().removeAllHtmlTags();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['language'] = language;
    data['genres'] = genres;
    data['status'] = status;
    data['runtime'] = runtime;
    data['premiered'] = premiered;
    data['ended'] = ended;
    if (schedule != null) {
      data['schedule'] = schedule!.toJson();
    }
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }

    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;

    return data;
  }
}
