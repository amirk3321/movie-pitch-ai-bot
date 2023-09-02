import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviepitch/feature/chat/presentation/cubit/movie_pitch_cubit.dart';
import 'package:moviepitch/feature/chat/presentation/pages/view_pitch_page.dart';
import 'package:shimmer/shimmer.dart';

class MoviePitchPage extends StatefulWidget {
  const MoviePitchPage({super.key});

  @override
  State<MoviePitchPage> createState() => _MoviePitchPageState();
}

class _MoviePitchPageState extends State<MoviePitchPage> {
  final _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Pitch Bot"),
      ),
      body: BlocBuilder<MoviePitchCubit, MoviePitchState>(
        builder: (context, moviePitchState) {
          if (moviePitchState is MoviePitchLoading) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset("assets/innovation.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(.2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 10.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child:  Container(
                                      height: 10,
                                      width: 20,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                SizedBox(
                                  width: double.infinity,
                                  height: 8.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child:  Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                SizedBox(
                                  width: double.infinity,
                                  height: 8.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child:  Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                SizedBox(
                                  width: 150.0,
                                  height: 8.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child:  Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        maxLines: 5,
                        controller: _promptController,
                        decoration: const InputDecoration(
                            hintText:
                            "an evil genius wants to take over the world using AI",
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: _submitMovieIdea,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (moviePitchState is MoviePitchILoaded) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset("assets/innovation.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2)),
                            child: Text(moviePitchState.botReply!.isEmpty
                                ? "Give me  one sentence concept I'll give you an eye-catching title, synopsis, the studios love a movie poster... and choose the cast"
                                : moviePitchState.botReply!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        maxLines: 5,
                        controller: _promptController,
                        decoration: const InputDecoration(
                            hintText:
                                "an evil genius wants to take over the world using AI",
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    InkWell(
                      onTap: _submitMovieIdea,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Submit")),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ViewPitchPage(
                          botReply: moviePitchState.botReply,
                            movieTitle: moviePitchState.movieTitle,
                          starNames: moviePitchState.starNames,
                          synopsis: moviePitchState.synopsis,
                        ))).then((value) {
                          _promptController.clear();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("View Pitch")),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }


          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset("assets/innovation.png"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(.2)),
                          child: const Text(
                              "Give me  one sentence concept I'll give you an eye-catching title, synopsis, the studios love a movie poster... and choose the cast"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      maxLines: 5,
                      controller: _promptController,
                      decoration: const InputDecoration(
                          hintText:
                          "an evil genius wants to take over the world using AI",
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: _submitMovieIdea,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(child: Text("Submit")),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitMovieIdea() {
    if (_promptController.text.isEmpty) {
      return;
    }

    context
        .read<MoviePitchCubit>()
        .getMoviePitch(query: _promptController.text);
  }
}
