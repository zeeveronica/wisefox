// 2. States
abstract class WebViewState {}

class WebViewInitial extends WebViewState {}

class WebViewOpened extends WebViewState {
  final String url;
  final String title;

  WebViewOpened({required this.url, required this.title});
}

class WebViewClosed extends WebViewState {}

class WebViewLoading extends WebViewState {}

class WebViewError extends WebViewState {
  final String message;

  WebViewError({required this.message});
}