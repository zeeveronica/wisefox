// // 1. Events
// abstract class WebViewEvent {}
//
// class OpenWebView extends WebViewEvent {
//   final String url;
//   final String title;
//
//   OpenWebView({required this.url, required this.title});
// }
//
// class CloseWebView extends WebViewEvent {}
//


import 'package:equatable/equatable.dart';

abstract class WebViewEvent extends Equatable {
  const WebViewEvent();

  @override
  List<Object?> get props => [];
}

class OpenWebView extends WebViewEvent {
  final String url;
  final String title;

  const OpenWebView({required this.url, required this.title});

  @override
  List<Object?> get props => [url, title];
}

class CloseWebView extends WebViewEvent {}

class CreateMeeting extends WebViewEvent {
  final int lessonId;

  const CreateMeeting({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
