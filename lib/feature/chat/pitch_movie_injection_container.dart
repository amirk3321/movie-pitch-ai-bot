import 'package:moviepitch/feature/chat/data/remote_data_source/movie_pitch_remote_data_source.dart';
import 'package:moviepitch/feature/chat/data/remote_data_source/movie_pitch_remote_data_source_impl.dart';
import 'package:moviepitch/feature/chat/data/repository/movie_pitch_repository_impl.dart';
import 'package:moviepitch/feature/chat/domain/repository/movie_pitch_repository.dart';
import 'package:moviepitch/feature/chat/domain/usecase/fetch_movie_title_usecase.dart';
import 'package:moviepitch/feature/chat/domain/usecase/fetch_star_names_usecase.dart';
import 'package:moviepitch/feature/chat/domain/usecase/fetch_synopsis_usecase.dart';
import 'package:moviepitch/feature/chat/domain/usecase/get_chat_bot_reply_usecase.dart';
import 'package:moviepitch/feature/chat/presentation/cubit/movie_pitch_cubit.dart';
import 'package:moviepitch/main_injection_container.dart';

Future<void> pitchMovieInjectionContainer() async {
  //Cubit
  sl.registerFactory<MoviePitchCubit>(() => MoviePitchCubit(
      fetchMovieTitleUseCase: sl.call(),
      fetchStarNamesUseCase: sl.call(),
      fetchSynopsisUseCase: sl.call(),
      getChatBotReplyUseCase: sl.call()));
//Use Cases
  sl.registerLazySingleton<FetchMovieTitleUseCase>(
      () => FetchMovieTitleUseCase(repository: sl.call()));
  sl.registerLazySingleton<FetchStarNamesUseCase>(
      () => FetchStarNamesUseCase(repository: sl.call()));
  sl.registerLazySingleton<FetchSynopsisUseCase>(
      () => FetchSynopsisUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetChatBotReplyUseCase>(
      () => GetChatBotReplyUseCase(repository: sl.call()));

//repository

  sl.registerLazySingleton<MoviePitchRepository>(
      () => MoviePitchRepositoryImpl(remoteDataSource: sl.call()));

//data source
  sl.registerLazySingleton<MoviePitchRemoteDataSource>(
      () => MoviePitchRemoteDataSourceImpl(httpClient: sl.call()));
}
