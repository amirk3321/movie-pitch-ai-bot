


class MoviePitchData{
  final String? text;
  final num? index;
  final String? finish_reason;

  MoviePitchData({this.text, this.index, this.finish_reason});


  factory MoviePitchData.fromJson(Map<String,dynamic>json){

    return MoviePitchData(
    text: json["text"],
  index: json["index"],
  finish_reason: json["finish_reason"],
    );
  }

}