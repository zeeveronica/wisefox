// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:path_provider/path_provider.dart'; // For accessing the local file system
// import 'package:http/http.dart' as http; // For downloading files
// import 'package:photo_view/photo_view.dart';
// import 'package:wisefox/student/features/screens/pdf_viewpage.dart';
// import 'package:wisefox/student/features/utils/thecolors.dart';
// import 'package:wisefox/main.dart';
// import 'package:url_launcher/url_launcher.dart';
// // For opening URLs

// class OpenRecievedFile extends StatefulWidget {
//   final String fileUrl; // Add this parameter to accept the file URL
//   final String receiverName; // Add this parameter to accept the receiver's name
//   final String notes; // Add this parameter to accept notes

//   const OpenRecievedFile({
//     super.key,
//     required this.fileUrl,
//     required this.receiverName,
//     required this.notes,
//   });

//   @override
//   State<OpenRecievedFile> createState() => _OpenRecievedFileState();
// }

// class _OpenRecievedFileState extends State<OpenRecievedFile> {
//   String getFileType(String fileUrl) {
//     if (fileUrl.endsWith('.jpeg') ||
//         fileUrl.endsWith('.png') ||
//         fileUrl.endsWith('.jpg')) {
//       return 'image';
//     } else if (fileUrl.endsWith('.pdf')) {
//       return 'pdf';
//     } else if (fileUrl.endsWith('.mp4')) {
//       return 'video';
//     } else {
//       return 'unknown';
//     }
//   }

//   Future<File> downloadFile(String url) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/${url.split('/').last}';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final file = File(filePath);
//       return file.writeAsBytes(response.bodyBytes);
//     } else {
//       throw Exception('Failed to download file');
//     }
//   }

//   Widget _buildFileDisplay(String fileType) {
//     switch (fileType) {
//       case 'image':
//         return Container(
//           height: w * 1,
//           width: w * 1,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(w * 0.03),
//             border: Border.all(color: theColors.classbrdrclr),
//           ),
//           child: PhotoView(
//             imageProvider: NetworkImage(widget.fileUrl),
//             backgroundDecoration: BoxDecoration(color: Colors.transparent),
//           ),
//         );
//       case 'pdf':
//         return InkWell(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Pdfview(
//                           fileUrl: widget.fileUrl,
//                         )));
//           },
//           child: Container(
//             height: h * 0.39,
//             width: w,
//             child: IgnorePointer(
//               child: PDF(
//                 fitPolicy: FitPolicy.HEIGHT,
//                 fitEachPage: true,
//               ).cachedFromUrl(
//                 widget.fileUrl,
//                 // Optional: Custom cache manager
//               ),
//             ),
//           ),
//         );

//       case 'video':
//         return Container(
//           height: w * 1,
//           width: w * 1,
//           child: Center(
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (await canLaunch(widget.fileUrl)) {
//                   await launch(widget.fileUrl);
//                 } else {
//                   throw 'Could not launch ${widget.fileUrl}';
//                 }
//               },
//               child: Text("Play Video"),
//             ),
//           ),
//         );
//       default:
//         return Text('Unsupported file format');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String fileType = getFileType(widget.fileUrl);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theColors.primaryColor,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           "File Sharing",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: w * 0.12,
//                 width: w * 1,
//                 decoration: BoxDecoration(
//                     color: theColors.classbrdrclr.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(w * 0.03)),
//                 child: Padding(
//                   padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Send to",
//                         style: TextStyle(
//                             color: theColors.lighttextgrey,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 11.sp),
//                       ),
//                       Text(
//                         widget.receiverName,
//                         style: TextStyle(
//                             color: theColors.lighttextgrey,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 11.sp),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: w * 0.03),
//               _buildFileDisplay(fileType), // Display the appropriate widget
//               SizedBox(height: w * 0.08),
//               Container(
//                 margin: EdgeInsets.only(left: w * 0.26),
//                 height: w * 0.08,
//                 width: w * 0.4,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(w * 0.05),
//                     border: Border.all(
//                         color: theColors.primaryColor, width: w * 0.002)),
//                 child: Center(
//                     child: Text(
//                   "Download",
//                   style: TextStyle(color: theColors.primaryColor),
//                 )),
//               ),
//               SizedBox(height: w * 0.05),
//               Text(
//                 "Notes",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
//               ),
//               SizedBox(height: w * 0.03),
//               Text(
//                 widget.notes,
//                 style:
//                     TextStyle(color: theColors.lighttextgrey, fontSize: 12.sp),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wisefox/student/features/screens/pdf_viewpage.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenRecievedFile extends StatefulWidget {
  final String fileUrl;
  final String receiverName;
  final String notes;
  const OpenRecievedFile({
    super.key,
    required this.fileUrl,
    required this.receiverName,
    required this.notes,
  });

  @override
  State<OpenRecievedFile> createState() => _OpenRecievedFileState();
}

class _OpenRecievedFileState extends State<OpenRecievedFile> {
  String getFileType(String fileUrl) {
    if (fileUrl.endsWith('.jpeg') ||
        fileUrl.endsWith('.png') ||
        fileUrl.endsWith('.jpg')) {
      return 'image';
    } else if (fileUrl.endsWith('.pdf')) {
      return 'pdf';
    } else if (fileUrl.endsWith('.mp4')) {
      return 'video';
    } else {
      return 'unknown';
    }
  }

  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted
    } else {
      // Permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Storage permission is required to download the file'),
        ),
      );
    }
  }

  Future<void> _scanFile(String filePath) async {
    const platform = MethodChannel('com.example.app/media');
    try {
      await platform.invokeMethod('scanFile', {'filePath': filePath});
    } on PlatformException catch (e) {
      print("Failed to scan file: '${e.message}'.");
    }
  }

  Future<void> downloadFile(String url, BuildContext context) async {
    // Request permission first
    await requestPermissions();

    try {
      // Get the download directory
      Directory directory = Directory('/storage/emulated/0/Download');

      // Ensure the directory exists
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final fileName = url.split('/').last;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final newFileName =
          '${fileName.split('.').first}_$timestamp.${fileName.split('.').last}';

      final filePath = '${directory.path}/$newFileName';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await _scanFile(filePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded to $filePath')),
        );
      } else {}
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  Widget _buildFileDisplay(String fileType) {
    switch (fileType) {
      case 'image':
        return Container(
          height: w * 1,
          width: w * 1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w * 0.03),
              border: Border.all(color: theColors.classbrdrclr),
              image: DecorationImage(
                image: NetworkImage(widget.fileUrl),
                fit: BoxFit.fill,
              )),
          // child: IgnorePointer(
          //   child: PhotoView(
          //     imageProvider: NetworkImage(widget.fileUrl),
          //     backgroundDecoration: BoxDecoration(color: Colors.transparent),

          //   ),
          // ),
        );
      case 'pdf':
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Pdfview(
                          fileUrl: widget.fileUrl,
                        )));
          },
          child: Container(
            height: h * 0.39,
            width: w,
            child: IgnorePointer(
              child: PDF(
                fitPolicy: FitPolicy.HEIGHT,
                fitEachPage: true,
              ).cachedFromUrl(
                widget.fileUrl,
                // Optional: Custom cache manager
              ),
            ),
          ),
        );

      case 'video':
        return Container(
          height: w * 1,
          width: w * 1,
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                if (await canLaunch(widget.fileUrl)) {
                  await launch(widget.fileUrl);
                } else {
                  throw 'Could not launch ${widget.fileUrl}';
                }
              },
              child: Text("Play Video"),
            ),
          ),
        );
      default:
        return Text('Unsupported file format');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String fileType = getFileType(widget.fileUrl);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "File Sharing",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: w * 0.12,
                width: w * 1,
                decoration: BoxDecoration(
                    color: theColors.classbrdrclr.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(w * 0.03)),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                  child:
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Send to",
                  //       style: TextStyle(
                  //           color: theColors.lighttextgrey,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 11.sp),
                  //     ),
                  //     Text(
                  //       widget.receiverName,
                  //       style: TextStyle(
                  //           color: theColors.lighttextgrey,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 11.sp),
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send to",
                        style: TextStyle(
                          color: theColors.lighttextgrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.receiverName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: theColors.lighttextgrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: w * 0.03),
              _buildFileDisplay(fileType),
              SizedBox(height: w * 0.08),
              Center(
                child: GestureDetector(
                  onTap: () => downloadFile(widget.fileUrl, context),
                  child: Container(
                    height: w * 0.08,
                    width: w * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.05),
                        border: Border.all(
                            color: theColors.primaryColor, width: w * 0.002)),
                    child: Center(
                        child: Text(
                      "Download",
                      style: TextStyle(color: theColors.primaryColor),
                    )),
                  ),
                ),
              ),
              SizedBox(height: w * 0.05),
              Text(
                "Notes",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
              ),
              SizedBox(height: w * 0.03),
              Text(
                widget.notes,
                style:
                    TextStyle(color: theColors.lighttextgrey, fontSize: 12.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
