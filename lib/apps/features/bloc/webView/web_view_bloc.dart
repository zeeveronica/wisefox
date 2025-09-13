// // 3. BLoC
// import 'dart:convert';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wisefox/apps/features/repos/meeting_repos.dart';
//
// import 'web_view_event.dart';
// import 'web_view_state.dart';
//
// class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
//   WebViewBloc() : super(WebViewInitial()) {
//     on<OpenWebView>((event, emit) {
//       emit(WebViewLoading());
//       try {
//         emit(WebViewOpened(url: event.url, title: event.title));
//       } catch (e) {
//         emit(WebViewError(message: e.toString()));
//       }
//     });
//
//     on<CloseWebView>((event, emit) {
//       emit(WebViewClosed());
//     });
//
//     on<CreateMeeting>((event, emit) async {
//       emit(WebViewLoading());
//
//       try {
//         final response = await MeetingRepository().meetingCreate(
//           lessonId: event.lessonId,
//         );
//
//         if (response.statusCode == 200) {
//           final jsonData = jsonDecode(response.body);
//
//           if (jsonData["status"] == "success") {
//             final link = jsonData["link"];
//
//             print('web view opened');
//
//             // emit event to open webview with returned link
//             emit(WebViewOpened(url: link, title: "Meeting"));
//           } else {
//             emit(WebViewError(message: "Failed: ${jsonData["status"]}"));
//           }
//         } else {
//           emit(WebViewError(message: "HTTP ${response.statusCode}"));
//         }
//       } catch (e) {
//         emit(WebViewError(message: e.toString()));
//       }
//     });
//
//   }
// }


import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisefox/apps/features/repos/meeting_repos.dart';

import 'web_view_event.dart';
import 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(WebViewInitial()) {
    on<OpenWebView>((event, emit) {
      emit(WebViewLoading());
      try {
        emit(WebViewOpened(url: event.url, title: event.title));
      } catch (e) {
        emit(WebViewError(message: e.toString()));
      }
    });

    on<CloseWebView>((event, emit) {
      emit(WebViewClosed());
    });

    on<CreateMeeting>((event, emit) async {
      emit(WebViewLoading());

      try {
        final response = await MeetingRepository().meetingCreate(
          lessonId: event.lessonId,
        );

        // Check for successful HTTP status codes (200-299 range)
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final jsonData = jsonDecode(response.body);

          if (jsonData["status"] == "success") {
            final link = jsonData["link"];

            print('Web view opened with link: $link');

            // emit event to open webview with returned link
            emit(WebViewOpened(url: link, title: "Meeting"));
          } else {
            emit(WebViewError(message: "Failed: ${jsonData["status"]}"));
          }
        } else {
          emit(WebViewError(message: "HTTP ${response.statusCode}"));
        }
      } catch (e) {
        emit(WebViewError(message: e.toString()));
      }
    });
  }
}