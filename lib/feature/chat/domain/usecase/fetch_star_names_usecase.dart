

import 'package:moviepitch/feature/chat/data/models/movie_pitch_model.dart';
import 'package:moviepitch/feature/chat/domain/repository/movie_pitch_repository.dart';

class FetchStarNamesUseCase{

  final MoviePitchRepository repository;

  FetchStarNamesUseCase({required this.repository});


  Future<MoviePitchModel> call (String query){
    return repository.fetchStarNames(query);
  }
}