import 'package:wisefox/client/features/screens/cancelled.dart';
import 'package:wisefox/client/features/screens/classes.dart';
import 'package:wisefox/client/features/screens/completed.dart';
import 'package:wisefox/client/features/screens/tabbar_lessons.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/studentcancelled.dart';
import 'package:wisefox/client/students/studentsclasses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsLessonsPage extends StatelessWidget {
  const StudentsLessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theColors.primaryColor,
          title: Text(
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
                      tabs: [
                        LessonsTabbar(title: "Classes"),
                        LessonsTabbar(title: "Completed"),
                        LessonsTabbar(title: "Cancelled"),
                      ],
                    ),
                  ),
                  SizedBox(height: w * 0.03),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        StudentClassesPage(),
                        CompletedPage(),
                        StudentCancelledPage(),
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
//  Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 theColors.white,
//                                                             border: Border.all(
//                                                                 color: Color(
//                                                                     0xff9C5633),
//                                                                 width:
//                                                                     w * 0.001),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(w *
//                                                                         0.05)),
//                                                         child: Padding(
//                                                           padding:
//                                                               EdgeInsets.all(
//                                                                   w * 0.005),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Padding(
//                                                                 padding: EdgeInsets.only(
//                                                                     bottom: w *
//                                                                         0.003,
//                                                                     left: w *
//                                                                         0.01),
//                                                                 child: Icon(
//                                                                   Icons
//                                                                       .access_time_outlined,
//                                                                   size:
//                                                                       w * 0.03,
//                                                                 ),
//                                                               ),
//                                                               Padding(
//                                                                 padding: EdgeInsets.only(
//                                                                     left: w *
//                                                                         0.01,
//                                                                     right: w *
//                                                                         0.01),
//                                                                 child: Text(
//                                                                   "${lesson.time}",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           8.sp),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         "  Duration: ${lesson.lessonDuration} hr",
//                                                         style: TextStyle(
//                                                             fontSize: 9.sp),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   SizedBox(
//                                                     width: w * 0.02,
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color:
//                                                               theColors.white,
//                                                           border: Border.all(
//                                                             color: Color(
//                                                                 0xffDDDDDD),
//                                                           ),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       w * 0.05),
//                                                         ),
//                                                         child: Padding(
//                                                           padding: EdgeInsets
//                                                               .symmetric(
//                                                             vertical: w * 0.005,
//                                                             horizontal:
//                                                                 w * 0.01,
//                                                           ),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceAround,
//                                                             children: [
//                                                               Center(
//                                                                 child:
//                                                                     Container(
//                                                                   height:
//                                                                       w * 0.04,
//                                                                   width:
//                                                                       w * 0.04,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(w *
//                                                                             0.09),
//                                                                     color: Color(
//                                                                         0x20F94246),
//                                                                   ),
//                                                                   child: Center(
//                                                                     child: Icon(
//                                                                       size: w *
//                                                                           0.03,
//                                                                       Icons
//                                                                           .close_rounded,
//                                                                       color: Colors
//                                                                           .red,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                   width:
//                                                                       w * 0.02),
//                                                               Text(
//                                                                 "cancel",
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                         8.sp),
//                                                               ),
//                                                               SizedBox(
//                                                                   width:
//                                                                       w * 0.01),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               )