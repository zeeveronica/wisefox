import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:wisefox/student/features/utils/thecolors.dart';

class Pdfview extends StatelessWidget {
  final String fileUrl;

  // Constructor to accept fileUrl
  const Pdfview({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Text(
          'PDF Viewer',
          style: TextStyle(color: theColors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: theColors.primaryColor,
      ),
      body: SizedBox.expand(
        child: PDF(
          enableSwipe: true,
          fitPolicy: FitPolicy.WIDTH,
          swipeHorizontal: true,
          fitEachPage: false,
        ).cachedFromUrl(
          fileUrl,
        ),
      ),
    );
  }
}
