// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:wisefox/student/features/bloc/demolessons/demo_lessons_bloc.dart';
// import 'package:wisefox/student/features/utils/thecolors.dart';
// import 'package:wisefox/student/features/utils/theimage.dart';
// import 'package:wisefox/main.dart';

// class DemoSeeall extends StatefulWidget {
//   const DemoSeeall({super.key});

//   @override
//   State<DemoSeeall> createState() => _DemoSeeallState();
// }

// class _DemoSeeallState extends State<DemoSeeall> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theColors.primaryColor,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: theColors.white,
//           ),
//         ),
//         title: Text(
//           "Demo Lessons",
//           style: TextStyle(color: theColors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(w * 0.03),
//         child: Column(
//           children: [
//             BlocBuilder<DemoLessonsBloc, DemoLessonsState>(
//               builder: (context, state) {
//                 if (state is DemoLessonsLoaded &&
//                     state.demoLessons.isNotEmpty) {
//                   // Use ListView.builder to list all the demo lessons
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount:
//                         state.demoLessons.length, // Dynamically set the count
//                     padding: EdgeInsets.only(top: w * 0.08),
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final demoLesson = state.demoLessons[
//                           index]; // Get the demo lesson at the current index

//                       return Align(
//                         heightFactor: 0.68,
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: Stack(
//                             children: [
//                               Container(
//                                 height: w * 0.43,
//                                 width: w * 1,
//                               ),
//                               Positioned(
//                                 top: w * 0.07,
//                                 child: Container(
//                                   height: w * 0.32,
//                                   width: w * 0.94,
//                                   decoration: BoxDecoration(
//                                       color: theColors.classclr,
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(w * 0.03),
//                                         bottomLeft: Radius.circular(w * 0.03),
//                                         bottomRight: Radius.circular(w * 0.03),
//                                       ),
//                                       border: Border.all(
//                                           width: w * 0.003,
//                                           color: theColors.classbrdrclr)),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                       left: w * 0.03,
//                                       top: w * 0.03,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             SizedBox(width: w * 0.04),
//                                             CircleAvatar(
//                                               backgroundImage: AssetImage(
//                                                   theimage.profilepc),
//                                             ),
//                                             Text(
//                                               "  Tutor: ${demoLesson.tutorName}",
//                                               style: TextStyle(fontSize: 11.sp),
//                                             )
//                                           ],
//                                         ),
//                                         SizedBox(height: w * 0.02),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                       color: theColors.white,
//                                                       border: Border.all(
//                                                           color:
//                                                               Color(0xff9C5633),
//                                                           width: w * 0.001),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               w * 0.05)),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.all(
//                                                         w * 0.005),
//                                                     child: Row(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   bottom: w *
//                                                                       0.003),
//                                                           child: Icon(
//                                                             Icons
//                                                                 .access_time_outlined,
//                                                             size: w * 0.03,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                             width: w * 0.01),
//                                                         Text(
//                                                           "${demoLesson.time}",
//                                                           style: TextStyle(
//                                                               fontSize: 8.sp),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "  Duration: ${demoLesson.duration} hr",
//                                                   style:
//                                                       TextStyle(fontSize: 9.sp),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(width: w * 0.02),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                       color: theColors.white,
//                                                       border: Border.all(
//                                                           color: Color(
//                                                               0xffDDDDDD)),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               w * 0.05)),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.all(
//                                                         w * 0.003),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceAround,
//                                                       children: [
//                                                         Center(
//                                                           child: Container(
//                                                             height: w * 0.04,
//                                                             width: w * 0.04,
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(w *
//                                                                           0.09),
//                                                               color: Color(
//                                                                   0x2000A276),
//                                                             ),
//                                                             child: Center(
//                                                               child: Container(
//                                                                 height:
//                                                                     w * 0.025,
//                                                                 width:
//                                                                     w * 0.025,
//                                                                 child:
//                                                                     Image.asset(
//                                                                   "assets/student/images/Group 7965.png",
//                                                                   fit: BoxFit
//                                                                       .cover,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                             width: w * 0.01),
//                                                         Text(
//                                                           "Join Now",
//                                                           style: TextStyle(
//                                                               fontSize: 8.sp),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 child: Container(
//                                   height: w * 0.0735,
//                                   width: w * 0.4,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(w * 0.15),
//                                         topRight: Radius.circular(w * 0.15)),
//                                     color: theColors.classclr,
//                                     border: Border(
//                                       top: BorderSide(
//                                           width: w * 0.003,
//                                           color: theColors.classbrdrclr),
//                                       left: BorderSide(
//                                           width: w * 0.003,
//                                           color: theColors.classbrdrclr),
//                                       right: BorderSide(
//                                           width: w * 0.003,
//                                           color: theColors.classbrdrclr),
//                                     ),
//                                   ),
//                                   child: FittedBox(
//                                     child: Padding(
//                                       padding: EdgeInsets.only(top: w * 0.014),
//                                       child: Text(
//                                         demoLesson.subjectName,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 09.sp,
//                                             fontWeight: FontWeight.w900),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is DemoLessonsLoading) {
//                   return CircularProgressIndicator(
//                       color: theColors.primaryColor); // Show loading indicator
//                 } else if (state is DemoLessonsError) {
//                   return Text('Error: ${state.message}');
//                 } else {
//                   return Text('No lessons available');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wisefox/student/features/bloc/demolessons/demo_lessons_bloc.dart';
import 'package:wisefox/student/features/utils/thecolors.dart';
import 'package:wisefox/student/features/utils/theimage.dart';
import 'package:wisefox/main.dart';

class DemoSeeall extends StatefulWidget {
  const DemoSeeall({super.key});

  @override
  State<DemoSeeall> createState() => _DemoSeeallState();
}

class _DemoSeeallState extends State<DemoSeeall> {
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
          "Demo Lessons",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          children: [
            BlocBuilder<DemoLessonsBloc, DemoLessonsState>(
              builder: (context, state) {
                if (state is DemoLessonsLoaded &&
                    state.demoLessons.isNotEmpty) {
                  // Make the ListView scrollable by wrapping it with Expanded
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          state.demoLessons.length, // Dynamically set the count
                      padding: EdgeInsets.only(top: w * 0.08),
                      itemBuilder: (context, index) {
                        final demoLesson = state.demoLessons[
                            index]; // Get the demo lesson at the current index

                        return Align(
                          heightFactor: 0.68,
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Container(
                                  height: w * 0.43,
                                  width: w * 1,
                                ),
                                Positioned(
                                  top: w * 0.07,
                                  child: Container(
                                    height: w * 0.32,
                                    width: w * 0.94,
                                    decoration: BoxDecoration(
                                        color: theColors.classclr,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(w * 0.03),
                                          bottomLeft: Radius.circular(w * 0.03),
                                          bottomRight:
                                              Radius.circular(w * 0.03),
                                        ),
                                        border: Border.all(
                                            width: w * 0.003,
                                            color: theColors.classbrdrclr)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: w * 0.03,
                                        top: w * 0.03,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: w * 0.04),
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    theimage.profilepc),
                                              ),
                                              Text(
                                                "  Tutor: ${demoLesson.tutorName}",
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: w * 0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: theColors.white,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff9C5633),
                                                            width: w * 0.001),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    w * 0.05)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          w * 0.005),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: w *
                                                                        0.01,
                                                                    bottom: w *
                                                                        0.003),
                                                            child: Icon(
                                                              Icons
                                                                  .access_time_outlined,
                                                              size: w * 0.03,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: w *
                                                                        0.01,
                                                                    right: w *
                                                                        0.01),
                                                            child: Text(
                                                              "${demoLesson.time}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      8.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "  Duration: ${demoLesson.duration} hr",
                                                    style: TextStyle(
                                                        fontSize: 9.sp),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: w * 0.02),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: theColors.white,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffDDDDDD)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    w * 0.05)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          w * 0.003),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Center(
                                                            child: Container(
                                                              height: w * 0.04,
                                                              width: w * 0.04,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(w *
                                                                            0.09),
                                                                color: Color(
                                                                    0x2000A276),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      w * 0.025,
                                                                  width:
                                                                      w * 0.025,
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/student/images/Group 7965.png",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: w * 0.01),
                                                          Text(
                                                            "Join Now",
                                                            style: TextStyle(
                                                                fontSize: 8.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    height: w * 0.0735,
                                    width: w * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(w * 0.15),
                                          topRight: Radius.circular(w * 0.15)),
                                      color: theColors.classclr,
                                      border: Border(
                                        top: BorderSide(
                                            width: w * 0.003,
                                            color: theColors.classbrdrclr),
                                        left: BorderSide(
                                            width: w * 0.003,
                                            color: theColors.classbrdrclr),
                                        right: BorderSide(
                                            width: w * 0.003,
                                            color: theColors.classbrdrclr),
                                      ),
                                    ),
                                    child: FittedBox(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: w * 0.014),
                                        child: Text(
                                          demoLesson.subjectName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 09.sp,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is DemoLessonsLoading) {
                  return CircularProgressIndicator(
                      color: theColors.primaryColor); // Show loading indicator
                } else if (state is DemoLessonsError) {
                  print('Error: ${state.message}');
                  return const Center(child: Text('No Data Available')
                  // return Expanded(
                  //   child: Center(
                  //     child: Text('Error: ${state.message}'),
                  //   ),
                  );

                } else {
                  return Expanded(
                    child: Center(
                      child: Text('No lessons available'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
