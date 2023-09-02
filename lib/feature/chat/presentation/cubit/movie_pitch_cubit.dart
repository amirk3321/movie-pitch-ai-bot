import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviepitch/core/custom_exceptions.dart';
import 'package:moviepitch/feature/chat/data/models/movie_pitch_model.dart';
import 'package:moviepitch/feature/chat/domain/usecase/fetch_movie_title_usecase.dart';
import 'package:moviepitch/feature/chat/domain/usecase/fetch_star_names_usecase.dart';
import 'package:moviepitch/feature/chat/domain/usecase/fetch_synopsis_usecase.dart';
import 'package:moviepitch/feature/chat/domain/usecase/get_chat_bot_reply_usecase.dart';

part 'movie_pitch_state.dart';

class MoviePitchCubit extends Cubit<MoviePitchState> {

  final FetchMovieTitleUseCase fetchMovieTitleUseCase;
  final FetchStarNamesUseCase fetchStarNamesUseCase;
  final FetchSynopsisUseCase fetchSynopsisUseCase;
  final GetChatBotReplyUseCase getChatBotReplyUseCase;
  MoviePitchCubit(
      {required this.fetchMovieTitleUseCase,
      required this.fetchStarNamesUseCase,
      required this.fetchSynopsisUseCase,
      required this.getChatBotReplyUseCase}) : super(MoviePitchInitial());


  Future<void> getMoviePitch({required String query})async{
    emit(MoviePitchLoading());
    try{
    final botReplay=  await getChatBotReplyUseCase.call(query);
    final synopsis=  await fetchSynopsisUseCase.call(query);
    final movieTitle=  await fetchMovieTitleUseCase.call(synopsis.choices!.first.text!);
    final starNames=  await fetchStarNamesUseCase.call(synopsis.choices!.first.text!);

    emit(MoviePitchILoaded(
      botReply: botReplay.choices!.first.text.toString().trim(),
      synopsis: synopsis.choices!.first.text.toString().trim(),
      movieTitle: movieTitle.choices!.first.text.toString().trim(),
      starNames: starNames.choices!.first.text.toString().trim(),
    ));

    }on SocketException{
      emit(MoviePitchFailure());
    }on ChatGPTServerException catch(e){
      emit(MoviePitchFailure());
    } catch (e){
      print("failure state ${e.toString()}");
      emit(MoviePitchFailure());
    }
  }
  Future<void> refresh()async{
    emit(MoviePitchFailure());
  }
}
