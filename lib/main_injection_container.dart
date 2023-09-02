


import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:moviepitch/feature/chat/pitch_movie_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {


  final http.Client httpClient = http.Client();


  sl.registerLazySingleton<http.Client>(() => httpClient);

  await pitchMovieInjectionContainer();

}