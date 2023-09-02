

import 'package:moviepitch/feature/chat/data/models/movie_pitch_data.dart';

class MoviePitchModel {
  final num? created;
  final List<MoviePitchData>? choices;

  MoviePitchModel({this.created, this.choices});

  factory MoviePitchModel.fromJson(Map<String,dynamic>json){
    final moviePitchItems = json["choices"]as List;
    List<MoviePitchData>choices = moviePitchItems.map((singleItem) => MoviePitchData.fromJson(singleItem)).toList();

    return MoviePitchModel(
      choices: choices,
       created: json["created"],
    );
  }


}