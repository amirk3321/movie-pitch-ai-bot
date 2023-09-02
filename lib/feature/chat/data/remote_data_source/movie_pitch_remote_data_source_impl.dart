import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviepitch/core/custom_exceptions.dart';
import 'package:moviepitch/feature/chat/data/models/movie_pitch_model.dart';
import 'package:moviepitch/feature/chat/data/remote_data_source/movie_pitch_remote_data_source.dart';
import 'package:http/http.dart' as http;

class MoviePitchRemoteDataSourceImpl implements MoviePitchRemoteDataSource {
  final http.Client httpClient;

  MoviePitchRemoteDataSourceImpl({required this.httpClient});

  Map<String, String> headerBearerOption(String token) => {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };

  @override
  Future<MoviePitchModel> getChatBotReply(String query) async {
    print(query);
    Map<String, dynamic> rowParams = {
      "model": "text-davinci-003",
      "prompt":
          "Generate a short message to enthusiastically say $query sounds interesting and that you need some minutes to think about it. Mention one aspect of the sentence. ",
      "max_tokens": 200 // default tokens 16 - 100 tokens generate 75 words
    };

    final encodedParams = json.encode(rowParams);

    final response = await httpClient.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      body: encodedParams,
      headers: headerBearerOption(dotenv.get('OPENAI_KEY', fallback: "")),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonData = MoviePitchModel.fromJson(json.decode(response.body));
      print(jsonData);
      return jsonData;
    } else {
      print(response.statusCode);
      final jsonData = json.decode(response.body);

      throw ChatGPTServerException(message: jsonData['error']['message']);
    }
  }

  @override
  Future<MoviePitchModel> fetchMovieTitle(String query) async {
    Map<String, dynamic> rowParams = {
      "model": "text-davinci-003",
      "prompt": "Generate a catchy movie title for this synopsis: $query",
      "max_tokens": 25, // default tokens 16 - 100 tokens generate 75 words
      "temperature": 0.7
    };

    final encodedParams = json.encode(rowParams);

    final response = await httpClient.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      body: encodedParams,
      headers: headerBearerOption(dotenv.get('OPENAI_KEY', fallback: "")),
    );

    if (response.statusCode == 200) {
      final jsonData = MoviePitchModel.fromJson(json.decode(response.body));
      print("$jsonData");
      return jsonData;
    } else {
      print(response.statusCode);
      final jsonData = json.decode(response.body);
      print(jsonData['error']['message']);
      return MoviePitchModel();
    }
  }

  @override
  Future<MoviePitchModel> fetchStarNames(String query) async {
    Map<String, dynamic> rowParams = {
      "model": "text-davinci-003",
      "prompt": """
      Extract the names in brackets from the synopsis.
      ###
      synopsis: The Top Gun Naval Fighter Weapons School is where the best of the best train to refine their elite flying skills. When hotshot fighter pilot Maverick (Tom Cruise) is sent to the school, his reckless attitude and cocky demeanor put him at odds with the other pilots, especially the cool and collected Iceman (Val Kilmer). But Maverick isn't only competing to be the top fighter pilot, he's also fighting for the attention of his beautiful flight instructor, Charlotte Blackwood (Kelly McGillis). Maverick gradually earns the respect of his instructors and peers - and also the love of Charlotte, but struggles to balance his personal and professional life. As the pilots prepare for a mission against a foreign enemy, Maverick must confront his own demons and overcome the tragedies rooted deep in his past to become the best fighter pilot and return from the mission triumphant.
      names: Tom Cruise, Val Kilmer, Kelly McGillis
      ###
      synopsis: $query
      names:   
     
     """,
      "max_tokens": 25, // default tokens 16 - 100 tokens generate 75 words
      "temperature": 0.7
    };

    final encodedParams = json.encode(rowParams);

    final response = await httpClient.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      body: encodedParams,
      headers: headerBearerOption(dotenv.get('OPENAI_KEY', fallback: "")),
    );

    if (response.statusCode == 200) {
      final jsonData = MoviePitchModel.fromJson(json.decode(response.body));
      print("$jsonData");
      return jsonData;
    } else {
      print(response.statusCode);
      final jsonData = json.decode(response.body);
      print(jsonData['error']['message']);
      return MoviePitchModel();
    }
  }

  @override
  Future<MoviePitchModel> fetchSynopsis(String query) async {
    Map<String, dynamic> rowParams = {
      "model": "text-davinci-003",
      "prompt": """
     
    Generate an engaging, professional and marketable movie synopsis based on an outline. The synopsis should include actors names in brackets after each character. Choose actors that would be ideal for this role. 
    ###
    outline: A big-headed daredevil fighter pilot goes back to school only to be sent on a deadly mission.
    synopsis: The Top Gun Naval Fighter Weapons School is where the best of the best train to refine their elite flying skills. When hotshot fighter pilot Maverick (Tom Cruise) is sent to the school, his reckless attitude and cocky demeanor put him at odds with the other pilots, especially the cool and collected Iceman (Val Kilmer). But Maverick isn't only competing to be the top fighter pilot, he's also fighting for the attention of his beautiful flight instructor, Charlotte Blackwood (Kelly McGillis). Maverick gradually earns the respect of his instructors and peers - and also the love of Charlotte, but struggles to balance his personal and professional life. As the pilots prepare for a mission against a foreign enemy, Maverick must confront his own demons and overcome the tragedies rooted deep in his past to become the best fighter pilot and return from the mission triumphant.  
    ###
    outline: $query
    synopsis: 
     
     """,
      "max_tokens": 700 // default tokens 16 - 100 tokens generate 75 words
    };
    final encodedParams = json.encode(rowParams);

    final response = await httpClient.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      body: encodedParams,
      headers: headerBearerOption(dotenv.get('OPENAI_KEY', fallback: "")),
    );

    if (response.statusCode == 200) {
      final jsonData = MoviePitchModel.fromJson(json.decode(response.body));
      print("$jsonData");
      return jsonData;
    } else {
      print(response.statusCode);
      final jsonData = json.decode(response.body);
      print(jsonData['error']['message']);
      return MoviePitchModel();
    }
  }
}
