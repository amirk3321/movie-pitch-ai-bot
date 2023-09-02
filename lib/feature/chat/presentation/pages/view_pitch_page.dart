import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviepitch/feature/chat/presentation/cubit/movie_pitch_cubit.dart';

class ViewPitchPage extends StatefulWidget {
  final String? movieTitle;
  final String? botReply;
  final String? synopsis;
  final String? starNames;

  const ViewPitchPage(
      {super.key,
      this.botReply,
      this.movieTitle,
      this.starNames,
      this.synopsis});

  @override
  State<ViewPitchPage> createState() => _ViewPitchPageState();
}

class _ViewPitchPageState extends State<ViewPitchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Pitch Bot"),
      ),
      body: SingleChildScrollView(
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
                      child: Text("${widget.botReply}"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.movieTitle!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.starNames!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.grey.withOpacity(.2)),
                child: Text(
                  widget.synopsis!,
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Clipboard.setData(ClipboardData(text: "${widget.movieTitle}\n${widget.starNames}\n${widget.synopsis}"));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Movie idea copied",style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text("Copy")),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
