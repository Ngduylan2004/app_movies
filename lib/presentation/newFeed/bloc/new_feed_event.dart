part of 'new_feed_bloc.dart';

class NewFeedEvent {}

class NewFeedEventTreding extends NewFeedEvent {}

class NewFeedEventVideo extends NewFeedEvent {
  final int movieId;

  NewFeedEventVideo({required this.movieId});
}
