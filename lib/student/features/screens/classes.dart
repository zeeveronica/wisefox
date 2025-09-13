// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:wisefox/apps/features/bloc/webView/web_view_bloc.dart';
// import 'package:wisefox/apps/features/bloc/webView/web_view_event.dart';
// import 'package:wisefox/apps/features/bloc/webView/web_view_state.dart';
// import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
// import 'package:wisefox/student/features/bloc/tutor/tutor_bloc.dart';
// import 'package:wisefox/student/features/screens/active_lessons.dart';
// import 'package:wisefox/student/features/screens/class_details.dart';
// import 'package:wisefox/student/features/utils/thecolors.dart';
// import 'package:wisefox/student/features/utils/theimage.dart';
// import 'package:wisefox/main.dart';
//
// class ClassesPage extends StatefulWidget {
//   const ClassesPage({super.key});
//
//   @override
//   State<ClassesPage> createState() => _ClassesPageState();
// }
//
// class _ClassesPageState extends State<ClassesPage> {
//   final List<DateTime> dates =
//       List.generate(07, (index) => DateTime.now().add(Duration(days: index)));
//   DateTime focusedDay = DateTime.now();
//   DateTime? selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<LessonBloc>().add(FetchLessons('upcoming'));
//
//     selectedDate = DateTime.now();
//   }
//
//   bool isSameDay(DateTime lessonDate, DateTime selectedDate) {
//     return lessonDate.year == selectedDate.year &&
//         lessonDate.month == selectedDate.month &&
//         lessonDate.day == selectedDate.day;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
//     String selectedDateText = selectedDate != null
//         ? DateFormat('MMMM d, yyyy').format(selectedDate!)
//         : todayDate;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "On Going Classes",
//                 style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: w * 0.03,
//               ),
//               Stack(
//                 children: [
//                   Container(
//                     height: w * 0.43,
//                     width: w * 1,
//                   ),
//                   Positioned(
//                     top: w * 0.07,
//                     child: Container(
//                       height: w * 0.32,
//                       width: w * 0.94,
//                       decoration: BoxDecoration(
//                           color: theColors.classclr,
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(w * 0.03),
//                             bottomLeft: Radius.circular(w * 0.03),
//                             bottomRight: Radius.circular(w * 0.03),
//                           ),
//                           border: Border.all(
//                               width: w * 0.003, color: theColors.classbrdrclr)),
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: w * 0.03,
//                           top: w * 0.03,
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: w * 0.04,
//                                 ),
//                                 CircleAvatar(
//                                   backgroundImage:
//                                       AssetImage(theimage.profilepc),
//                                 ),
//                                 Text(
//                                   "  Tutor: Reshma Nair",
//                                   style: TextStyle(fontSize: 11.sp),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: w * 0.02,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       // width: w * 0.37,
//                                       // height: w * 0.07,
//                                       decoration: BoxDecoration(
//                                           color: theColors.white,
//                                           border: Border.all(
//                                               color: Color(0xff9C5633),
//                                               width: w * 0.001),
//                                           borderRadius:
//                                               BorderRadius.circular(w * 0.05)),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(w * 0.005),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   bottom: w * 0.003,
//                                                   left: w * 0.01),
//                                               child: Icon(
//                                                 Icons.access_time_outlined,
//                                                 size: w * 0.03,
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: w * 0.01,
//                                                   right: w * 0.01),
//                                               child: Text(
//                                                 "10:00 AM - 11:00 AM",
//                                                 style:
//                                                     TextStyle(fontSize: 8.sp),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       "  Duration: 1 hr",
//                                       style: TextStyle(fontSize: 9.sp),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: w * 0.01,
//                                 ),
//                                 Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         context.read<WebViewBloc>().add(
//                                           CreateMeeting(lessonId: 50), // TODO: pass lessonId dynamically
//                                         );
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: theColors.white,
//                                           border: Border.all(color: const Color(0xffDDDDDD)),
//                                           borderRadius: BorderRadius.circular(w * 0.05),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.all(w * 0.003),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                             children: [
//                                               SizedBox(width: w * 0.002),
//                                               Center(
//                                                 child: Container(
//                                                   height: w * 0.04,
//                                                   width: w * 0.04,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(w * 0.09),
//                                                     color: const Color(0x2000A276),
//                                                   ),
//                                                   child: Center(
//                                                     child: Container(
//                                                       height: w * 0.025,
//                                                       width: w * 0.025,
//                                                       child: Image.asset(
//                                                         "assets/student/images/Group 7965.png",
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(width: w * 0.01),
//                                               Text(
//                                                 "Join Now",
//                                                 style: TextStyle(fontSize: 8.sp),
//                                               ),
//                                               SizedBox(width: w * 0.01),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // Row(
//                                 //   children: [
//                                 //     Container(
//                                 //         // width: w * 0.24,
//                                 //         // height: w * 0.07,
//                                 //         decoration: BoxDecoration(
//                                 //             color: theColors.white,
//                                 //             border: Border.all(
//                                 //                 color: Color(0xffDDDDDD)),
//                                 //             borderRadius: BorderRadius.circular(
//                                 //                 w * 0.05)),
//                                 //         child: Padding(
//                                 //           padding: EdgeInsets.all(w * 0.003),
//                                 //           child: Row(
//                                 //             mainAxisAlignment:
//                                 //                 MainAxisAlignment.spaceAround,
//                                 //             children: [
//                                 //               SizedBox(
//                                 //                 width: w * 0.002,
//                                 //               ),
//                                 //               Center(
//                                 //                 child: Container(
//                                 //                   height: w * 0.04,
//                                 //                   width: w * 0.04,
//                                 //                   decoration: BoxDecoration(
//                                 //                     borderRadius:
//                                 //                         BorderRadius.circular(
//                                 //                             w * 0.09),
//                                 //                     color: Color(0x2000A276),
//                                 //                   ),
//                                 //                   child: Center(
//                                 //                     child: Container(
//                                 //                       height: w * 0.025,
//                                 //                       width: w * 0.025,
//                                 //                       child: Image.asset(
//                                 //                         "assets/student/images/Group 7965.png",
//                                 //                         fit: BoxFit.cover,
//                                 //                       ),
//                                 //                     ),
//                                 //                   ),
//                                 //                 ),
//                                 //               ),
//                                 //               SizedBox(
//                                 //                 width: w * 0.01,
//                                 //               ),
//                                 //               Text(
//                                 //                 "Join Now",
//                                 //                 style:
//                                 //                     TextStyle(fontSize: 8.sp),
//                                 //               ),
//                                 //               SizedBox(
//                                 //                 width: w * 0.01,
//                                 //               ),
//                                 //             ],
//                                 //           ),
//                                 //         )),
//                                 //   ],
//                                 // ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     // top: w * 0.01,
//                     child: ClipPath(
//                       child: Container(
//                         height: w * 0.0736,
//                         width: w * 0.4,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(w * 0.15),
//                             topRight: Radius.circular(w * 0.15),
//                           ),
//                           color: theColors.classclr,
//                           border: Border(
//                               top: BorderSide(
//                                   width: w * 0.003,
//                                   color: theColors.classbrdrclr),
//                               left: BorderSide(
//                                   width: w * 0.003,
//                                   color: theColors.classbrdrclr),
//                               right: BorderSide(
//                                   width: w * 0.003,
//                                   color: theColors.classbrdrclr)),
//                         ),
//                         child: FittedBox(
//                           child: Padding(
//                             padding: EdgeInsets.only(top: w * 0.014),
//                             child: Text(
//                               "Mathematics",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 09.sp, fontWeight: FontWeight.w900),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child:
//                         Divider(thickness: w * 0.003, color: Color(0xffE8E8E8)),
//                   ),
//                   Container(
//                     height: w * 0.02,
//                     width: w * 0.09,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xffE8E8E8)),
//                       borderRadius: BorderRadius.circular(w * 0.03),
//                     ),
//                     child: Divider(
//                       indent: w * 0.03,
//                       endIndent: w * 0.03,
//                       color: Color(0xffE8E8E8),
//                     ),
//                   ),
//                   Expanded(
//                     child:
//                         Divider(thickness: w * 0.003, color: Color(0xffE8E8E8)),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Upcoming Lessons",
//                     style:
//                         TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
//                   ),
//                   Container(
//                     height: w * 0.08,
//                     width: w * 0.08,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(w * 0.02),
//                       color: theColors.tabbarclr.withOpacity(0.5),
//                     ),
//                     child: Center(
//                       child: Container(
//                         height: w * 0.035,
//                         width: w * 0.035,
//                         child: SvgPicture.asset(
//                           "assets/student/icons/more.svg",
//                           color: Color(0xff707070),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: 6,
//                 ),
//                 height: w * 0.25,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: dates.length,
//                   itemBuilder: (context, index) {
//                     DateTime date = dates[index];
//                     bool isSelected = selectedDate != null &&
//                         selectedDate!.year == date.year &&
//                         selectedDate!.month == date.month &&
//                         selectedDate!.day == date.day;
//
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedDate = date;
//
//                           context.read<LessonBloc>().add(SetSelectedDate(date));
//                         });
//                       },
//                       child: Container(
//                         width: w * 0.13,
//                         height: w * 0.3,
//                         padding: EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(w * 0.08),
//                           color: isSelected
//                               ? Color(0xffE1E1FF)
//                               : Colors.transparent,
//                           border: Border.all(
//                             color: Colors.transparent,
//                             width: 0,
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     DateFormat('EEE').format(date),
//                                     style: TextStyle(
//                                       color: isSelected
//                                           ? theColors.primaryColor
//                                           : Colors.black,
//                                       fontSize: 10.sp,
//                                       fontWeight: isSelected
//                                           ? FontWeight.w600
//                                           : FontWeight.w500,
//                                     ),
//                                   ),
//                                   SizedBox(height: 5.0),
//                                   Text(
//                                     DateFormat('dd').format(date),
//                                     style: TextStyle(
//                                       color: isSelected
//                                           ? theColors.primaryColor
//                                           : Colors.black,
//                                       fontSize: 10.sp,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             if (isSelected)
//                               Positioned(
//                                 bottom: w * 0.013,
//                                 left: (w * 0.106 - w * 0.016) / 2,
//                                 child: Container(
//                                   height: w * 0.016,
//                                   width: w * 0.016,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: w * 0.03,
//               ),
//               // Text(
//               //   todayDate,
//               //   style: TextStyle(fontSize: 11.sp),
//               // ),
//               Text(
//                 selectedDate != null &&
//                         DateFormat('MMMM d, yyyy').format(selectedDate!) ==
//                             todayDate
//                     ? "Today"
//                     : selectedDateText,
//                 style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
//               ),
//               BlocBuilder<LessonBloc, LessonState>(
//                 builder: (context, state) {
//                   if (state is LessonLoading) {
//                     return Center(
//                         child: CircularProgressIndicator(
//                       color: theColors.primaryColor,
//                     ));
//                   } else if (state is LessonLoaded) {
//                     final filteredLessons = state.lessons.where((lesson) {
//                       DateTime lessonDate = DateTime.parse(lesson.date);
//                       return isSameDay(lessonDate, selectedDate!);
//                     }).toList();
//
//                     String lessonCountText =
//                         "${filteredLessons.length} Classes Available";
//
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           lessonCountText,
//                           style: TextStyle(
//                             fontSize: 11.sp,
//                             color: theColors.textgrey,
//                           ),
//                         ),
//                         SizedBox(
//                           height: w * 0.03,
//                         ),
//                         if (filteredLessons.isEmpty)
//                           Center(
//                             child: Text(
//                               'There is no class on the selected date.',
//                               style: TextStyle(fontSize: 12.sp),
//                             ),
//                           ),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: filteredLessons.length,
//                           padding: EdgeInsets.only(top: w * 0.08),
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final lesson = filteredLessons[index];
//                             return Align(
//                               heightFactor: 0.68,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ClassDetails(
//                                           startTime: lesson.time,
//                                           lessonid: lesson.id,
//                                         ),
//                                       ));
//                                 },
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       height: w * 0.43,
//                                       width: w * 1,
//                                     ),
//                                     Positioned(
//                                       top: w * 0.07,
//                                       child: Container(
//                                         height: w * 0.32,
//                                         width: w * 0.94,
//                                         decoration: BoxDecoration(
//                                             color: theColors.classclr,
//                                             borderRadius: BorderRadius.only(
//                                               topRight:
//                                                   Radius.circular(w * 0.03),
//                                               bottomLeft:
//                                                   Radius.circular(w * 0.03),
//                                               bottomRight:
//                                                   Radius.circular(w * 0.03),
//                                             ),
//                                             border: Border.all(
//                                                 width: w * 0.003,
//                                                 color: theColors.classbrdrclr)),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                             left: w * 0.03,
//                                             top: w * 0.03,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: w * 0.04,
//                                                   ),
//                                                   // CircleAvatar(
//                                                   //   backgroundImage:
//                                                   //       NetworkImage(
//                                                   //           lesson.day),
//                                                   //   backgroundColor:
//                                                   //       Colors.grey[200],
//                                                   // ),
//                                                   CircleAvatar(
//                                                     radius: 25,
//                                                     backgroundColor: Colors.grey[200],
//                                                     backgroundImage: (lesson.tutorPhoto != null && lesson.tutorPhoto!.isNotEmpty)
//                                                         ? NetworkImage(lesson.tutorPhoto!)
//                                                         : null,
//                                                     child: (lesson.tutorPhoto == null || lesson.tutorPhoto!.isEmpty)
//                                                         ? Text(
//                                                       lesson.tutorName.isNotEmpty
//                                                           ? lesson.tutorName[0].toUpperCase()
//                                                           : "?",
//                                                       style: TextStyle(
//                                                         fontSize: 20,
//                                                         fontWeight: FontWeight.bold,
//                                                         color: Colors.black,
//                                                       ),
//                                                     )
//                                                         : null,
//                                                   ),
//
//                                                   Text(
//                                                     "  Tutor: ${lesson.tutorName}",
//                                                     style: TextStyle(
//                                                         fontSize: 11.sp),
//                                                   )
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: w * 0.02,
//                                               ),
//                                               Row(
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
//                                                         "  Duration: ${lesson.lessonDuration} mins",
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
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       child: Container(
//                                         height: w * 0.0735,
//                                         width: w * 0.4,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                               topLeft:
//                                                   Radius.circular(w * 0.15),
//                                               topRight:
//                                                   Radius.circular(w * 0.15)),
//                                           color: theColors.classclr,
//                                           border: Border(
//                                               top: BorderSide(
//                                                   width: w * 0.003,
//                                                   color:
//                                                       theColors.classbrdrclr),
//                                               left: BorderSide(
//                                                   width: w * 0.003,
//                                                   color:
//                                                       theColors.classbrdrclr),
//                                               right: BorderSide(
//                                                   width: w * 0.003,
//                                                   color:
//                                                       theColors.classbrdrclr)),
//                                         ),
//                                         child: FittedBox(
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsets.only(top: w * 0.014),
//                                             child: Text(
//                                               "${lesson.subject}",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   fontSize: 09.sp,
//                                                   fontWeight: FontWeight.w900),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     );
//                   } else if (state is LessonError) {
//                     return Center(child: Text('Error: ${state.message}'));
//                   }
//                   return Center(child: Text('No data'));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }



import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wisefox/apps/features/bloc/webView/web_view_bloc.dart';
import 'package:wisefox/apps/features/bloc/webView/web_view_event.dart';
import 'package:wisefox/apps/features/bloc/webView/web_view_state.dart';
import 'package:wisefox/apps/features/screens/iframe/web_page.dart';
import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
import 'package:wisefox/student/features/bloc/tutor/tutor_bloc.dart';
import 'package:wisefox/student/features/screens/active_lessons.dart';
import 'package:wisefox/student/features/screens/class_details.dart';
import 'package:wisefox/student/features/utils/thecolors.dart';
import 'package:wisefox/student/features/utils/theimage.dart';
import 'package:wisefox/main.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final List<DateTime> dates =
  List.generate(07, (index) => DateTime.now().add(Duration(days: index)));
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;
  // DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchLessons('today'));
    selectedDate = DateTime.now();
  }

  bool isSameDay(DateTime lessonDate, DateTime selectedDate) {
    return lessonDate.year == selectedDate.year &&
        lessonDate.month == selectedDate.month &&
        lessonDate.day == selectedDate.day;
  }

  void _handleJoinMeeting(int lessonId) {
    context.read<WebViewBloc>().add(CreateMeeting(lessonId: lessonId));
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    String selectedDateText = selectedDate != null
        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
        : todayDate;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MultiBlocListener(
        listeners: [
          BlocListener<WebViewBloc, WebViewState>(
            listener: (context, state) {
              if (state is WebViewOpened) {
                // Handle successful meeting creation
                // You might want to navigate to a WebView screen here
                // _showSnackBar('Meeting created successfully!');
                _showSnackBar('Joining Meeting successfully!');
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WebViewPage(url: state.url, title: state.title)
                ));
              } else if (state is WebViewError) {
                _showSnackBar('Failed to create meeting: ${state.message}', isError: true);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "On Going Classes",
                //   style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                // ),
                // SizedBox(height: w * 0.03),
                // _buildOngoingClassCard(),
                _buildDivider(),
                _buildUpcomingLessonsHeader(),
                _buildDateSelector(),
                SizedBox(height: w * 0.03),
                _buildSelectedDateHeader(selectedDateText, todayDate),
                _buildLessonsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOngoingClassCard() {
    return Stack(
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
                  bottomRight: Radius.circular(w * 0.03),
                ),
                border: Border.all(
                    width: w * 0.003, color: theColors.classbrdrclr)),
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
                        backgroundImage: AssetImage(theimage.profilepc),
                      ),
                      Text(
                        "  Tutor: Reshma Nair",
                        style: TextStyle(fontSize: 11.sp),
                      )
                    ],
                  ),
                  SizedBox(height: w * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: theColors.white,
                                border: Border.all(
                                    color: Color(0xff9C5633),
                                    width: w * 0.001),
                                borderRadius:
                                BorderRadius.circular(w * 0.05)),
                            child: Padding(
                              padding: EdgeInsets.all(w * 0.005),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: w * 0.003,
                                        left: w * 0.01),
                                    child: Icon(
                                      Icons.access_time_outlined,
                                      size: w * 0.03,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: w * 0.01,
                                        right: w * 0.01),
                                    child: Text(
                                      "10:00 AM - 11:00 AM",
                                      style: TextStyle(fontSize: 8.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "  Duration: 1 hr",
                            style: TextStyle(fontSize: 9.sp),
                          ),
                        ],
                      ),
                      SizedBox(width: w * 0.01),
                      _buildJoinButton(50), // Static lesson ID for ongoing class
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: ClipPath(
            child: Container(
              height: w * 0.0736,
              width: w * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * 0.15),
                  topRight: Radius.circular(w * 0.15),
                ),
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
                        color: theColors.classbrdrclr)),
              ),
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: w * 0.014),
                  child: Text(
                    "Mathematics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 09.sp, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJoinButton(int lessonId) {
    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        bool isLoading = state is WebViewLoading;

        return GestureDetector(
          onTap: isLoading ? null : () => _handleJoinMeeting(lessonId),
          child: Container(
            decoration: BoxDecoration(
              color: theColors.white,
              border: Border.all(color: const Color(0xffDDDDDD)),
              borderRadius: BorderRadius.circular(w * 0.05),
            ),
            child: Padding(
              padding: EdgeInsets.all(w * 0.003),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: w * 0.002),
                  Center(
                    child: Container(
                      height: w * 0.04,
                      width: w * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.09),
                        color: const Color(0x2000A276),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                          height: w * 0.02,
                          width: w * 0.02,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                theColors.primaryColor),
                          ),
                        )
                            : Container(
                          height: w * 0.025,
                          width: w * 0.025,
                          child: Image.asset(
                            "assets/student/images/Group 7965.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.01),
                  Text(
                    isLoading ? "Joining..." : "Join Now",
                    style: TextStyle(fontSize: 8.sp),
                  ),
                  SizedBox(width: w * 0.01),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Divider(thickness: w * 0.003, color: Color(0xffE8E8E8)),
        ),
        Container(
          height: w * 0.02,
          width: w * 0.09,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffE8E8E8)),
            borderRadius: BorderRadius.circular(w * 0.03),
          ),
          child: Divider(
            indent: w * 0.03,
            endIndent: w * 0.03,
            color: Color(0xffE8E8E8),
          ),
        ),
        Expanded(
          child: Divider(thickness: w * 0.003, color: Color(0xffE8E8E8)),
        ),
      ],
    );
  }

  Widget _buildUpcomingLessonsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Upcoming Lessons",
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),


        /// Filter for Date pickup
        GestureDetector(
          onTap: (){
            _pickDate(context);
            },
          child: Container(
            height: w * 0.08,
            width: w * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w * 0.02),
              color: theColors.tabbarclr.withOpacity(0.5),
            ),
            child: Center(
              child: Container(
                height: w * 0.035,
                width: w * 0.035,
                child: SvgPicture.asset(
                  "assets/student/icons/more.svg",
                  color: Color(0xff707070),
                ),
              ),
            ),
          ),
        ),
        /// end
      ],
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
      height: w * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          DateTime date = dates[index];
          bool isSelected = selectedDate != null &&
              selectedDate!.year == date.year &&
              selectedDate!.month == date.month &&
              selectedDate!.day == date.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
                context.read<LessonBloc>().add(SetSelectedDate(date));
              });
            },
            child: Container(
              width: w * 0.13,
              height: w * 0.3,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w * 0.08),
                color: isSelected ? Color(0xffE1E1FF) : Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 0),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEE').format(date),
                          style: TextStyle(
                            color: isSelected
                                ? theColors.primaryColor
                                : Colors.black,
                            fontSize: 10.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          DateFormat('dd').format(date),
                          style: TextStyle(
                            color: isSelected
                                ? theColors.primaryColor
                                : Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      bottom: w * 0.013,
                      left: (w * 0.106 - w * 0.016) / 2,
                      child: Container(
                        height: w * 0.016,
                        width: w * 0.016,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
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
  }

  Widget _buildSelectedDateHeader(String selectedDateText, String todayDate) {
    return Text(
      selectedDate != null &&
          DateFormat('MMMM d, yyyy').format(selectedDate!) == todayDate
          ? "Today"
          : selectedDateText,
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildLessonsList() {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        if (state is LessonLoading) {
          return const Center(
              child: CircularProgressIndicator(
                color: theColors.primaryColor,
              ));
        } else if (state is LessonLoaded) {
          final filteredLessons = state.lessons.where((lesson) {
            DateTime lessonDate = DateTime.parse(lesson.date);
            return isSameDay(lessonDate, selectedDate!) &&
                lesson.lessonStatus == "Scheduled";
          }).toList();

          String lessonCountText =
              "${filteredLessons.length} Classes Available";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lessonCountText,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: theColors.textgrey,
                ),
              ),
              SizedBox(height: w * 0.03),
              if (filteredLessons.isEmpty)
                Center(
                  child: Text(
                    'There is no class on the selected date.',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredLessons.length,
                padding: EdgeInsets.only(top: w * 0.08),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final lesson = filteredLessons[index];
                  return Align(
                    heightFactor: 0.68,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassDetails(
                                startTime: lesson.time,
                                lessonid: lesson.id,
                              ),
                            ));
                      },
                      child: _buildLessonCard(lesson),
                    ),
                  );
                },
              ),
            ],
          );
        } else if (state is LessonError) {
          print('Error: ${state.message}');
          return Center(child: Text('No Data Available'));
         // return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No data'));
      },
    );
  }

  Widget _buildLessonCard(dynamic lesson) {
    return Column(
      children: [
        Stack(
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
                      bottomRight: Radius.circular(w * 0.03),
                    ),
                    border: Border.all(
                        width: w * 0.003, color: theColors.classbrdrclr)),
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
                            radius: 25,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: (lesson.tutorPhoto != null &&
                                lesson.tutorPhoto!.isNotEmpty)
                                ? NetworkImage(lesson.tutorPhoto!)
                                : null,
                            child: (lesson.tutorPhoto == null ||
                                lesson.tutorPhoto!.isEmpty)
                                ? Text(
                              lesson.tutorName.isNotEmpty
                                  ? lesson.tutorName[0].toUpperCase()
                                  : "?",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                                : null,
                          ),
                          Text(
                            "  Tutor: ${lesson.tutorName}",
                            style: TextStyle(fontSize: 11.sp),
                          )
                        ],
                      ),
                      SizedBox(height: w * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: theColors.white,
                                    border: Border.all(
                                        color: Color(0xff9C5633), width: w * 0.001),
                                    borderRadius:
                                    BorderRadius.circular(w * 0.05)),
                                child: Padding(
                                  padding: EdgeInsets.all(w * 0.005),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: w * 0.003, left: w * 0.01),
                                        child: Icon(
                                          Icons.access_time_outlined,
                                          size: w * 0.03,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: w * 0.01, right: w * 0.01),
                                        child: Text(
                                          "${lesson.time}",
                                          style: TextStyle(fontSize: 8.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "  Duration: ${lesson.lessonDuration} mins",
                                style: TextStyle(fontSize: 9.sp),
                              ),
                            ],
                          ),
                          SizedBox(width: w * 0.02),
                          _buildCountdownOrJoin(lesson.date, lesson.time, lesson.id),
                       //   _buildJoinButton(lesson.id),
                          // Row(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         color: theColors.white,
                          //         border: Border.all(color: Color(0xffDDDDDD)),
                          //         borderRadius: BorderRadius.circular(w * 0.05),
                          //       ),
                          //       child: Padding(
                          //         padding: EdgeInsets.symmetric(
                          //           vertical: w * 0.005,
                          //           horizontal: w * 0.01,
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: [
                          //             // Center(
                          //             //   child: Container(
                          //             //     height: w * 0.04,
                          //             //     width: w * 0.04,
                          //             //     decoration: BoxDecoration(
                          //             //       borderRadius:
                          //             //       BorderRadius.circular(w * 0.09),
                          //             //       color: Color(0x20F94246),
                          //             //     ),
                          //             //     child: Center(
                          //             //       child: Icon(
                          //             //         size: w * 0.03,
                          //             //         Icons.close_rounded,
                          //             //         color: Colors.red,
                          //             //       ),
                          //             //     ),
                          //             //   ),
                          //             // ),
                          //             // SizedBox(width: w * 0.02),
                          //             // Text(
                          //             //   "cancel",
                          //             //   style: TextStyle(fontSize: 8.sp),
                          //             // ),
                          //             _buildJoinButton(lesson.id),
                          //             SizedBox(width: w * 0.01),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      )
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
                          width: w * 0.003, color: theColors.classbrdrclr),
                      left: BorderSide(
                          width: w * 0.003, color: theColors.classbrdrclr),
                      right: BorderSide(
                          width: w * 0.003, color: theColors.classbrdrclr)),
                ),
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.only(top: w * 0.014),
                    child: Text(
                      "${lesson.subject}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 09.sp, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: 13,)
      ],
    );
  }

  Widget _buildCountdownOrJoin(String date, String time, int lessonId) {
    DateTime startTime = DateTime.parse("$date $time");
    // DateTime startTime = DateTime.parse("2025-09-13 19:34:00");
    DateTime now = DateTime.now();

    Duration remaining = startTime.difference(now);
print("remaining:$remaining");
print("now:$now");
print("startTime:$startTime");
    return TweenAnimationBuilder<Duration>(
      duration: remaining.isNegative ? Duration.zero : remaining,
      tween: Tween(
        begin: remaining.isNegative ? Duration.zero : remaining,
        end: Duration.zero,
      ),
      onEnd: () {
        // Timer completed → rebuild to show Join
      },
      builder: (context, value, child) {
        if (value.inSeconds <= 0) {
          // 👇 Join button show pannum
          return _buildJoinButton(lessonId);
        } else {
          // 👇 Timer show pannum
          String twoDigits(int n) => n.toString().padLeft(2, "0");
          final hours = twoDigits(value.inHours);
          final minutes = twoDigits(value.inMinutes.remainder(60));
          final seconds = twoDigits(value.inSeconds.remainder(60));

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(

                color: theColors.white,
                border: Border.all(color: const Color(0xffDDDDDD)),
                borderRadius: BorderRadius.circular(w * 0.05),
              ),

            child: Text(
              "$hours:$minutes:$seconds",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }

  /// date picker
  Future<void> _pickDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today, // Start with today
      firstDate: today,   // Block past dates
      lastDate: DateTime(today.year + 2), // Limit to 2 years in future
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green, // calendar header color
              onPrimary: Colors.white, // text on header
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      // Calendar automatically closes after selecting
    }
  }




}

