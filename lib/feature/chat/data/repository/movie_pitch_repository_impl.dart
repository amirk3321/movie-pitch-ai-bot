

import 'package:moviepitch/feature/chat/data/models/movie_pitch_model.dart';
import 'package:moviepitch/feature/chat/data/remote_data_source/movie_pitch_remote_data_source.dart';
import 'package:moviepitch/feature/chat/domain/repository/movie_pitch_repository.dart';

class MoviePitchRepositoryImpl implements MoviePitchRepository{


  final MoviePitchRemoteDataSource remoteDataSource;

  MoviePitchRepositoryImpl({required this.remoteDataSource});
  @override
  Future<MoviePitchModel> getChatBotReply(String query) async=>remoteDataSource.getChatBotReply(query);

  @override
  Future<MoviePitchModel> fetchMovieTitle(String query) async=>remoteDataSource.fetchMovieTitle(query);

  @override
  Future<MoviePitchModel> fetchStarNames(String query) async=>remoteDataSource.fetchStarNames(query);

  @override
  Future<MoviePitchModel> fetchSynopsis(String query) async=>remoteDataSource.fetchSynopsis(query);

}