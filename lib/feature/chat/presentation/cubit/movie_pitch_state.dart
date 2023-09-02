part of 'movie_pitch_cubit.dart';

abstract class MoviePitchState extends Equatable {
  const MoviePitchState();
}

class MoviePitchInitial extends MoviePitchState {
  @override
  List<Object> get props => [];
}
class MoviePitchLoading extends MoviePitchState {
  @override
  List<Object> get props => [];
}
class MoviePitchILoaded extends MoviePitchState {
  final String? botReply;
  final String? synopsis;
  final String? movieTitle;
  final String? starNames;

  const MoviePitchILoaded({this.botReply,this.synopsis,this.movieTitle,this.starNames});

  @override
  List<Object?> get props => [botReply,synopsis,movieTitle,starNames];
}
class MoviePitchFailure extends MoviePitchState {
  @override
  List<Object> get props => [];
}