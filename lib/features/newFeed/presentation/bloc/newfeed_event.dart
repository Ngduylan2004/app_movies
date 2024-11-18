part of 'newfeed_bloc.dart';

class NewfeedEvent {}

class NewfeedEventTreding extends NewfeedEvent {}

class NewfeedEventVideo extends NewfeedEvent {
  final int movieId;

  NewfeedEventVideo({required this.movieId});
}
