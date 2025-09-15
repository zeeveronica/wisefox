// 5. WebView Page
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisefox/student/features/screens/lessons_page.dart';
import 'package:wisefox/student/features/screens/bottom_nav.dart';


class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // late final WebViewController controller1;
  InAppWebViewController? controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // controller1 = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading progress
    //       },
    //       onPageStarted: (String url) {
    //         setState(() {
    //           isLoading = true;
    //         });
    //       },
    //       onPageFinished: (String url) {
    //         setState(() {
    //           isLoading = false;
    //         });
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: Text('Error loading page: ${error.description}'),
    //             backgroundColor: Colors.red,
    //           ),
    //         );
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   backgroundColor: Colors.blue[600],
      //   foregroundColor: Colors.white,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.refresh),
      //       onPressed: () {
      //         controller.reload();
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.close),
      //       onPressed: () {
      //         context.read<WebViewBloc>().add(CloseWebView());
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          // WebViewWidget(controller: controller),
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
              android: AndroidInAppWebViewOptions(
                useWideViewPort: true,
                builtInZoomControls: false,
                allowFileAccess: true,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            onWebViewCreated: (webController) {
              controller = webController;
            },
            onLoadStart: (controller, url) {
              setState(() => isLoading = true);
            },
            onLoadStop: (controller, url) async {
              setState(() => isLoading = false);
            },
            onLoadError: (controller, url, code, message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error loading page: $message"),
                  backgroundColor: Colors.red,
                ),
              );
              setState(() => isLoading = false);
            },
            androidOnPermissionRequest:
                (InAppWebViewController controller, String origin, List<String> resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT,
              );
            },
          ),

          if (isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20.h),
                    Text('Loading webpage...'),
                  ],
                ),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => Bottomnav(initialIndex: 0)),
      //     );
      //   },
      //   child: Icon(
      //     Icons.arrow_back,
      //     color: Colors.white, // <-- set icon color to white
      //   ),
      //   backgroundColor: theColors.primaryColor,
      // ),
    );
  }
}