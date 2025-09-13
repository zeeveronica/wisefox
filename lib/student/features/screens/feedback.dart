import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wisefox/student/features/screens/account.dart';
import 'package:wisefox/student/features/screens/bottom_nav.dart';
import 'package:wisefox/student/features/utils/thecolors.dart';
import 'package:wisefox/student/features/utils/theimage.dart';
import 'package:wisefox/main.dart';

class Feedbackpage extends StatefulWidget {
  const Feedbackpage({super.key});

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedbackpage> {
  final _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.white,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Feedback', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(theimage.pagebackground),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.lighten),
        )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'We value your feedback!',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Please share your thoughts and suggestions with us.',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _feedbackController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: theColors.textgrey.withOpacity(0.2),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: theColors.classbrdrclr.withOpacity(0.4),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter your feedback here...',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _showFeedbackSubmittedDialog(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFeedbackSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LottieBuilder.asset(
                          "assets/student/lottie/Animation - 1722934619791.json",
                          repeat: false,
                          height: w * 0.3,
                          width: w * 0.3,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Feedback Submitted",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Thank you for your feedback. We appreciate your input!",
                          style: TextStyle(
                              fontSize: 11.sp, color: theColors.textgrey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theColors.primaryColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Bottomnav(
                                  initialIndex: 4,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
