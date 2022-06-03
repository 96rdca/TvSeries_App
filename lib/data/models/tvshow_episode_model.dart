import 'package:seriestv_jobcity/common/extensions/string_extensions.dart';
import 'package:seriestv_jobcity/data/models/image_model.dart';
import 'package:seriestv_jobcity/data/models/rating_model.dart';

class TvShowEpisode {
  int? id;
  String? name;
  int? season;
  int? number;
  String? type;
  String? airdate;
  String? airtime;
  int? runtime;
  Rating? rating;
  Image? image;
  String? summary;

  TvShowEpisode(
      {this.id,
      this.name,
      this.season,
      this.number,
      this.type,
      this.airdate,
      this.airtime,
      this.runtime,
      this.rating,
      this.image,
      this.summary});

  TvShowEpisode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    type = json['type'];
    airdate = json['airdate'];
    airtime = json['airtime'];
    runtime = json['runtime'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary']?.toString().removeAllHtmlTags();
  }
}
