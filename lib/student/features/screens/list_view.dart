import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
import 'package:wisefox/student/features/screens/class_details.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';

class ListViewHome extends StatefulWidget {
  const ListViewHome({super.key});

  @override
  State<ListViewHome> createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.white,
      body: Column(
        children: [],
      ),
    );
  }
}

// Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       SizedBox(
//                                                         width: w * 0.002,
//                                                       ),
//                                                       Center(
//                                                         child: Container(
//                                                           height: w * 0.04,
//                                                           width: w * 0.04,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(w *
//                                                                         0.09),
//                                                             color: Color(
//                                                                 0x2000A276),
//                                                           ),
//                                                           child: Center(
//                                                             child: Container(
//                                                               height: w * 0.025,
//                                                               width: w * 0.025,
//                                                               child:
//                                                                   Image.asset(
//                                                                 "assets/student/images/Group 7965.png",
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: w * 0.01,
//                                                       ),
//                                                       Text(
//                                                         "Join Now",
//                                                         style: TextStyle(
//                                                             fontSize: 8.sp),
//                                                       ),
//                                                       SizedBox(
//                                                         width: w * 0.01,
//                                                       ),
//                                                     ],
//                                                   ),
