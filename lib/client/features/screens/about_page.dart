import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
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
          "About",
          style: TextStyle(color: theColors.white),
        ),
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
              Colors.white.withOpacity(0.7),
              BlendMode.lighten,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: w * 0.03),
                Center(
                  child: Container(
                    height: w * 0.10,
                    width: w * 0.35,
                    child: Image.asset(
                      'assets/common/images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: w * 0.07),

                Text(
                  'Wisefox',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.02),
                Text(
                  "Wisefox is designed to help students organize their study schedules, track their progress, and access learning resources. Whether your children are preparing for exams or managing assignments, Wisefox is here to support them!",
                  style: TextStyle(fontSize: 11.sp),
                ),
                SizedBox(height: w * 0.02),

                // Features
                Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  '- Study Scheduler: Help your child plan their study sessions and stay organized with their goals.\n'
                  '- Progress Tracker: Monitor your child’s performance and track their improvements over time.\n'
                  '- Resource Library: Provide your child with a curated collection of study materials and expert tips.',
                  style: TextStyle(fontSize: 11.sp),
                ),
                SizedBox(height: w * 0.02),

                // Team Info
                Text(
                  'Meet the Team',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  '- Jane Doe - Education Specialist, Mathematics\n'
                  '- John Smith - Curriculum Designer, Chemistry\n'
                  '- Emily Davis - Educational Coordinator, Physics',
                  style: TextStyle(fontSize: 11.sp),
                ),
                SizedBox(height: w * 0.02),

                // Version Info
                Text(
                  'Version',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  'Current Version: 1.2.3',
                  style: TextStyle(fontSize: 11.sp),
                ),
                SizedBox(height: w * 0.02),

                Text(
                  'Update History',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  '- Version 1.2.3: Added new study reminders feature.\n'
                  '- Version 1.1.0: Improved user interface and fixed bugs.',
                  style: TextStyle(fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
