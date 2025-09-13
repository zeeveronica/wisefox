import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisefox/student/features/utils/thecolors.dart';
import 'package:wisefox/student/features/utils/theimage.dart';
import 'package:wisefox/main.dart';

class Help extends StatelessWidget {
  const Help({super.key});

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
            color: Colors.white,
          ),
        ),
        title: Text(
          "Help Center",
          style: TextStyle(color: Colors.white, fontSize: 17),
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
              Colors.white.withOpacity(0.7), BlendMode.lighten),
        )),
        child: ListView(
          children: [
            ExpansionTile(
              shape: Border(),
              title: Text(
                'Getting Started',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text(
                    'How to create an account',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    'Step-by-step guide on account creation.',
                    style:
                        TextStyle(color: theColors.textgrey, fontSize: 10.sp),
                  ),
                ),
                ListTile(
                  title: Text(
                    'How to navigate the app',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    'Basic navigation tips and tricks.',
                    style:
                        TextStyle(color: theColors.textgrey, fontSize: 10.sp),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              shape: Border(),
              title: Text(
                'Troubleshooting',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Common issues and fixes',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    'Resolve common problems with the app.',
                    style:
                        TextStyle(color: theColors.textgrey, fontSize: 10.sp),
                  ),
                ),
                ListTile(
                  title: Text('Contact support',
                      style: TextStyle(color: Colors.black, fontSize: 13.sp)),
                  subtitle: Text(
                    'How to get in touch with support.',
                    style:
                        TextStyle(color: theColors.textgrey, fontSize: 10.sp),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              shape: Border(),
              title: Text(
                'Advanced Features',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Using advanced settings',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    'Learn about advanced features.',
                    style:
                        TextStyle(color: theColors.textgrey, fontSize: 10.sp),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Customizing your experience',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                  subtitle: Text(
                    'Tips on personalizing the app.',
                    style:
                        TextStyle(color: theColors.textgrey, fontSize: 10.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
