// // 4. Main Page with Buttons
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:wisefox/apps/features/bloc/webView/web_view_bloc.dart';
// import 'package:wisefox/apps/features/bloc/webView/web_view_event.dart';
// import 'package:wisefox/apps/features/screens/iframe/web_page.dart';
//
// import '../../bloc/webView/web_view_state.dart';
//
// class MainPage extends StatelessWidget {
//   const MainPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => WebViewBloc(apiService: apiService),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Iframe Example'),
//           backgroundColor: Colors.blue[600],
//           foregroundColor: Colors.white,
//         ),
//         body: BlocListener<WebViewBloc, WebViewState>(
//           listener: (context, state) {
//             if (state is WebViewOpened) {
//               // Navigate to WebView page
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => BlocProvider.value(
//                     value: context.read<WebViewBloc>(),
//                     child: WebViewPage(
//                       url: state.url,
//                       title: state.title,
//                     ),
//                   ),
//                 ),
//               );
//             } else if (state is WebViewError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Error: ${state.message}'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           child: Padding(
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Choose a website to open:',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//
//                 // Button to open Google
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     context.read<WebViewBloc>().add(
//                       OpenWebView(
//                         url: 'https://www.google.com',
//                         title: 'Google',
//                       ),
//                     );
//                   },
//                   icon: Icon(Icons.search),
//                   label: Text('Open Google'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[600],
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 15.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 15.h),
//
//                 // Button to open YouTube
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     context.read<WebViewBloc>().add(
//                       OpenWebView(
//                         url: 'https://www.youtube.com',
//                         title: 'YouTube',
//                       ),
//                     );
//                   },
//                   icon: Icon(Icons.play_circle),
//                   label: Text('Open YouTube'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red[600],
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 15.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 15.h),
//
//                 // Button to open custom URL
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     _showUrlDialog(context);
//                   },
//                   icon: Icon(Icons.web),
//                   label: Text('Open Custom URL'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green[600],
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 15.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 30.h),
//
//                 // Show loading state
//                 BlocBuilder<WebViewBloc, WebViewState>(
//                   builder: (context, state) {
//                     if (state is WebViewLoading) {
//                       return Center(
//                         child: Column(
//                           children: [
//                             CircularProgressIndicator(),
//                             SizedBox(height: 10.h),
//                             Text('Opening webpage...'),
//                           ],
//                         ),
//                       );
//                     }
//                     return SizedBox.shrink();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showUrlDialog(BuildContext context) {
//     final TextEditingController urlController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: Text('Enter URL'),
//         content: TextField(
//           controller: urlController,
//           decoration: InputDecoration(
//             hintText: 'https://example.com',
//             border: OutlineInputBorder(),
//           ),
//           keyboardType: TextInputType.url,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (urlController.text.isNotEmpty) {
//                 Navigator.of(dialogContext).pop();
//                 context.read<WebViewBloc>().add(
//                   OpenWebView(
//                     url: urlController.text,
//                     title: 'Custom URL',
//                   ),
//                 );
//               }
//             },
//             child: Text('Open'),
//           ),
//         ],
//       ),
//     );
//   }
// }
