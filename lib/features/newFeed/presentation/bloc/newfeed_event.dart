part of 'newfeed_bloc.dart';

abstract class NewfeedEvent {}

class NewfeedEventTreding extends NewfeedEvent {}

class NewfeedEventVideo extends NewfeedEvent {
  final int movieId;
  NewfeedEventVideo({required this.movieId}); // Bỏ message vì không cần thiết
}
