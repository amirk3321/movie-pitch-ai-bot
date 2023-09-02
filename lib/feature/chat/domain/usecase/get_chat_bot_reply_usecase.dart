

import 'package:moviepitch/feature/chat/data/models/movie_pitch_model.dart';
import 'package:moviepitch/feature/chat/domain/repository/movie_pitch_repository.dart';

class GetChatBotReplyUseCase{

  final MoviePitchRepository repository;

  GetChatBotReplyUseCase({required this.repository});


  Future<MoviePitchModel> call (String query){
    return repository.getChatBotReply(query);
  }
}