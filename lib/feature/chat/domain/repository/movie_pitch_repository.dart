


import 'package:moviepitch/feature/chat/data/models/movie_pitch_model.dart';

abstract class MoviePitchRepository{
  Future<MoviePitchModel> getChatBotReply(String query);
  Future<MoviePitchModel> fetchSynopsis(String query);
  Future<MoviePitchModel> fetchMovieTitle(String query);
  Future<MoviePitchModel> fetchStarNames(String query);
}