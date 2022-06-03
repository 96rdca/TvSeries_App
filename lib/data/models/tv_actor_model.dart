import 'package:seriestv_jobcity/data/models/image_model.dart';

class TvActor {
  int? id;
  String? name;
  String? birthday;
  String? deathday;
  String? gender;
  Image? image;

  TvActor(
      {this.id,
      this.name,
      this.birthday,
      this.deathday,
      this.gender,
      this.image});

  TvActor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}
