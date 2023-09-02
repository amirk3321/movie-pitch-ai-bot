import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviepitch/feature/chat/presentation/cubit/movie_pitch_cubit.dart';
import 'package:moviepitch/feature/chat/presentation/pages/movie_pitch_page.dart';
import 'main_injection_container.dart'as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env", mergeWith: {
    'TEST_VAR': '5',
  });

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviePitchCubit>(
          create: (context) => di.sl<MoviePitchCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Pitch Copy Gen.',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) {
            return const MoviePitchPage();
          }
        },
      ),
    );
  }
}
