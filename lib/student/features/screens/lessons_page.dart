import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisefox/student/features/screens/cancelled.dart';
import 'package:wisefox/student/features/screens/classes.dart';
import 'package:wisefox/student/features/screens/completed.dart';
import 'package:wisefox/student/features/screens/tabbar_lessons.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theColors.primaryColor,
          title: const Text(
            "Lessons",
            style: TextStyle(color: theColors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  theimage.pagebackground,
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.7),
                  colorBlendMode: BlendMode.lighten,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: w * 0.03),
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(w * 0.09)),
                      color: Color(0xffE7ECF8)
                          .withOpacity(0.5), // TabBar background color
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: theColors.primaryColor,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.circular(w * 0.09)),
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: theColors.textgrey,
                      tabs: const [
                        LessonsTabbar(title: "Classes"),
                        LessonsTabbar(title: "Completed"),
                        LessonsTabbar(title: "Cancelled"),
                      ],
                    ),
                  ),
                  SizedBox(height: w * 0.03),
                  const Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ClassesPage(),
                        CompletedPage(),
                        CancelledPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
