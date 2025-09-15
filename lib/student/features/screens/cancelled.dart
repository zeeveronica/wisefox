// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:wisefox/student/features/bloc/lessondetails/lessondetails_bloc.dart';
// import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
// import 'package:wisefox/student/features/screens/active_lessons.dart';
// import 'package:wisefox/student/features/screens/cancelled_lessons.dart';
// import 'package:wisefox/student/features/utils/thecolors.dart';
// import 'package:wisefox/student/features/utils/theimage.dart';
// import 'package:wisefox/main.dart';
//
// class CancelledPage extends StatefulWidget {
//   const CancelledPage({super.key});
//
//   @override
//   State<CancelledPage> createState() => _CancelledPageState();
// }
//
// class _CancelledPageState extends State<CancelledPage> {
//   final List<DateTime> dates =
//       List.generate(07, (index) => DateTime.now().add(Duration(days: index)));
//   DateTime focusedDay = DateTime.now();
//   DateTime? selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<LessonBloc>().add(FetchLessons('cancelled'));
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
//           child: BlocBuilder<LessondetailsBloc, LessondetailsState>(
//             builder: (context, state) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Cancelled Lessons",
//                     style:
//                         TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 6,
//                       vertical: 10.0,
//                     ),
//                     height: w * 0.25,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: dates.length,
//                       itemBuilder: (context, index) {
//                         DateTime date = dates[index];
//                         bool isSelected = selectedDate != null &&
//                             selectedDate!.year == date.year &&
//                             selectedDate!.month == date.month &&
//                             selectedDate!.day == date.day;
//
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedDate = date;
//
//                               context
//                                   .read<LessonBloc>()
//                                   .add(SetSelectedDate(date));
//                             });
//                           },
//                           child: Container(
//                             width: w * 0.13,
//                             height: w * 0.3,
//                             padding: EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(w * 0.08),
//                               color: isSelected
//                                   ? Color(0xffE1E1FF)
//                                   : Colors.transparent,
//                               border: Border.all(
//                                 color: Colors.transparent,
//                                 width: 0,
//                               ),
//                             ),
//                             child: Stack(
//                               children: [
//                                 Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         DateFormat('EEE').format(date),
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? theColors.primaryColor
//                                               : Colors.black,
//                                           fontSize: 10.sp,
//                                           fontWeight: isSelected
//                                               ? FontWeight.w600
//                                               : FontWeight.w500,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5.0),
//                                       Text(
//                                         DateFormat('dd').format(date),
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? theColors.primaryColor
//                                               : Colors.black,
//                                           fontSize: 10.sp,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 if (isSelected)
//                                   Positioned(
//                                     bottom: w * 0.013,
//                                     left: (w * 0.106 - w * 0.016) / 2,
//                                     child: Container(
//                                       height: w * 0.016,
//                                       width: w * 0.016,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: w * 0.03,
//                   ),
//                   // Text(
//                   //   todayDate,
//                   //   style: TextStyle(fontSize: 11.sp),
//                   // ),
//                   Text(
//                     selectedDate != null &&
//                             DateFormat('MMMM d, yyyy').format(selectedDate!) ==
//                                 todayDate
//                         ? "Today"
//                         : selectedDateText,
//                     style:
//                         TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
//                   ),
//                   BlocBuilder<LessonBloc, LessonState>(
//                     builder: (context, state) {
//                       if (state is LessonLoading) {
//                         return Center(
//                             child: CircularProgressIndicator(
//                                 color: theColors.primaryColor));
//                       } else if (state is LessonLoaded) {
//                         final filteredLessons = state.lessons.where((lesson) {
//                           DateTime lessonDate = DateTime.parse(lesson.date);
//                           return isSameDay(lessonDate, selectedDate!);
//                         }).toList();
//
//                         String lessonCountText =
//                             "${filteredLessons.length} Classes Available";
//
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               lessonCountText,
//                               style: TextStyle(
//                                 fontSize: 11.sp,
//                                 color: theColors.textgrey,
//                               ),
//                             ),
//                             SizedBox(
//                               height: w * 0.03,
//                             ),
//                             if (filteredLessons.isEmpty)
//                               Center(
//                                 child: Text(
//                                   'There is no class on the selected date.',
//                                   style: TextStyle(fontSize: 12.sp),
//                                 ),
//                               ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: filteredLessons.length,
//                               padding: EdgeInsets.only(top: w * 0.08),
//                               physics: NeverScrollableScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 final lesson = filteredLessons[index];
//                                 print('lesson12312312');
//                                 print(lesson);
//                                 print(lesson.id);
//                                 return Align(
//                                   heightFactor: 0.68,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CancelledLessonPage(
//                                               lessonid: lesson.id,
//                                             ),
//                                           ));
//                                     },
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           height: w * 0.43,
//                                           width: w * 1,
//                                         ),
//                                         Positioned(
//                                           top: w * 0.07,
//                                           child: Container(
//                                             height: w * 0.32,
//                                             width: w * 0.94,
//                                             decoration: BoxDecoration(
//                                                 color: theColors.classclr,
//                                                 borderRadius: BorderRadius.only(
//                                                   topRight:
//                                                       Radius.circular(w * 0.03),
//                                                   bottomLeft:
//                                                       Radius.circular(w * 0.03),
//                                                   bottomRight:
//                                                       Radius.circular(w * 0.03),
//                                                 ),
//                                                 border: Border.all(
//                                                     width: w * 0.003,
//                                                     color: theColors
//                                                         .classbrdrclr)),
//                                             child: Padding(
//                                               padding: EdgeInsets.only(
//                                                 left: w * 0.03,
//                                                 top: w * 0.03,
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: w * 0.04,
//                                                       ),
//                                                       // CircleAvatar(
//                                                       //   backgroundImage:
//                                                       //       NetworkImage(
//                                                       //           lesson.day),
//                                                       //   backgroundColor:
//                                                       //       Colors.grey[200],
//                                                       // ),
//                                                       CircleAvatar(
//                                                         radius: 25,
//                                                         backgroundColor: Colors.grey[200],
//                                                         backgroundImage: (lesson.tutorPhoto != null && lesson.tutorPhoto!.isNotEmpty)
//                                                             ? NetworkImage(lesson.tutorPhoto!)
//                                                             : null,
//                                                         child: (lesson.tutorPhoto == null || lesson.tutorPhoto!.isEmpty)
//                                                             ? Text(
//                                                           lesson.tutorName.isNotEmpty
//                                                               ? lesson.tutorName[0].toUpperCase()
//                                                               : "?",
//                                                           style: TextStyle(
//                                                             fontSize: 20,
//                                                             fontWeight: FontWeight.bold,
//                                                             color: Colors.black,
//                                                           ),
//                                                         )
//                                                             : null,
//                                                       ),
//
//                                                       Text(
//                                                         "  Tutor: ${lesson.tutorName}",
//                                                         style: TextStyle(
//                                                             fontSize: 11.sp),
//                                                       )
//                                                     ],
//                                                   ),
//                                                   SizedBox(
//                                                     height: w * 0.02,
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Container(
//                                                             decoration: BoxDecoration(
//                                                                 color: theColors
//                                                                     .white,
//                                                                 border: Border.all(
//                                                                     color: Color(
//                                                                         0xff9C5633),
//                                                                     width: w *
//                                                                         0.001),
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(w *
//                                                                             0.05)),
//                                                             child: Padding(
//                                                               padding: EdgeInsets
//                                                                   .all(w *
//                                                                       0.005),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceEvenly,
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding: EdgeInsets.only(
//                                                                         left: w *
//                                                                             0.01,
//                                                                         bottom: w *
//                                                                             0.003),
//                                                                     child: Icon(
//                                                                       Icons
//                                                                           .access_time_outlined,
//                                                                       size: w *
//                                                                           0.03,
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding: EdgeInsets.only(
//                                                                         left: w *
//                                                                             0.01,
//                                                                         right: w *
//                                                                             0.01),
//                                                                     child: Text(
//                                                                       "${lesson.time}",
//                                                                       style: TextStyle(
//                                                                           fontSize:
//                                                                               8.sp),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Text(
//                                                             "  Duration: ${lesson.lessonDuration} hr",
//                                                             style: TextStyle(
//                                                                 fontSize: 9.sp),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         width: w * 0.02,
//                                                       ),
//                                                       Container(
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 theColors.white,
//                                                             border: Border.all(
//                                                                 color: Color(
//                                                                     0xffDDDDDD)),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(w *
//                                                                         0.05)),
//                                                         child: Center(
//                                                           child: Padding(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                     top: w *
//                                                                         0.005,
//                                                                     bottom: w *
//                                                                         0.005,
//                                                                     left: w *
//                                                                         0.02,
//                                                                     right: w *
//                                                                         0.02),
//                                                             child: Text(
//                                                               "Cancelled",
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize:
//                                                                       8.sp),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           child: Container(
//                                             height: w * 0.0735,
//                                             width: w * 0.4,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft:
//                                                       Radius.circular(w * 0.15),
//                                                   topRight: Radius.circular(
//                                                       w * 0.15)),
//                                               color: theColors.classclr,
//                                               border: Border(
//                                                   top: BorderSide(
//                                                       width: w * 0.003,
//                                                       color: theColors
//                                                           .classbrdrclr),
//                                                   left: BorderSide(
//                                                       width: w * 0.003,
//                                                       color: theColors
//                                                           .classbrdrclr),
//                                                   right: BorderSide(
//                                                       width: w * 0.003,
//                                                       color: theColors
//                                                           .classbrdrclr)),
//                                             ),
//                                             child: FittedBox(
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: w * 0.014),
//                                                 child: Text(
//                                                   "${lesson.subject}",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       fontSize: 09.sp,
//                                                       fontWeight:
//                                                           FontWeight.w900),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         );
//                       } else if (state is LessonError) {
//                         return Center(child: Text('Error: ${state.message}'));
//                       }
//                       return Center(child: Text('No data'));
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
import 'package:wisefox/student/features/screens/active_lessons.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';

class CancelledPage extends StatefulWidget {
  const CancelledPage({super.key});

  @override
  State<CancelledPage> createState() => _CancelledPageState();
}

class _CancelledPageState extends State<CancelledPage> {
  // Generate last 7 days (including today)
  final List<DateTime> dates = List.generate(7, (index) =>
      DateTime.now().subtract(Duration(days: 6 - index)));

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;
  Future<void> _pickDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today, // Start with today
      firstDate: DateTime(1900), // Allow very old dates (customize if needed)
      lastDate: DateTime(today.year + 50), // Allow up to 50 years in future
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
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
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    // Initial API call for today's cancelled lessons
    _fetchLessonsForDate(selectedDate!);
  }

  // Method to fetch lessons for a specific date
  void _fetchLessonsForDate(DateTime date) {
    // Format the date as needed by your API (adjust format as per your backend requirement)
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // Add the API call with the selected date
    context.read<LessonBloc>().add(FetchLessons('cancelled', date : formattedDate));

    // If your existing API doesn't support date filtering, you might need:
    // context.read<LessonBloc>().add(FetchLessons('cancelled'));
    // And then filter in the UI (which you're already doing)
  }

  bool isSameDay(DateTime lessonDate, DateTime selectedDate) {
    return lessonDate.year == selectedDate.year &&
        lessonDate.month == selectedDate.month &&
        lessonDate.day == selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    String selectedDateText = selectedDate != null
        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
        : todayDate;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _refreshLessons,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cancelled Lessons",
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),

                    GestureDetector(
                      onTap: (){ _pickDate(context);},
                      child: Container(
                        height: w * 0.08,
                        width: w * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.02),
                          color: theColors.tabbarclr.withOpacity(0.5),
                        ),
                        child: Center(
                          child: SizedBox(
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
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 6,
                  ),
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
                          });

                          // Call API when date is selected
                          _fetchLessonsForDate(date);

                          // Also update the bloc state for selected date
                          context.read<LessonBloc>().add(SetSelectedDate(date));
                        },
                        child: Container(
                          width: w * 0.13,
                          height: w * 0.3,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.08),
                            color: isSelected
                                ? Color(0xffE1E1FF)
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0,
                            ),
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
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                Text(
                  selectedDate != null &&
                      DateFormat('MMMM d, yyyy').format(selectedDate!) ==
                          todayDate
                      ? "Today"
                      : selectedDateText,
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                BlocBuilder<LessonBloc, LessonState>(
                  builder: (context, state) {
                    if (state is LessonLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                            color: theColors.primaryColor,
                          ));
                    } else if (state is LessonLoaded) {
                      final filteredLessons = state.lessons.where((lesson) {
                        DateTime lessonDate = DateTime.parse(lesson.date);
                        return isSameDay(lessonDate, selectedDate!);
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
                          SizedBox(
                            height: w * 0.03,
                          ),
                          if (filteredLessons.isEmpty)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: w * 0.1),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.event_note,
                                      size: w * 0.15,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: w * 0.03),
                                    Text(
                                      'No cancelled classes on this date.',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
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
                                          builder: (context) => ActiveLessons(
                                            lessonId: lesson.id,
                                          ),
                                        ));
                                  },
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
                                                topRight:
                                                Radius.circular(w * 0.03),
                                                bottomLeft:
                                                Radius.circular(w * 0.03),
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
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Colors.grey[200],
                                                      backgroundImage: (lesson.tutorPhoto != null && lesson.tutorPhoto!.isNotEmpty)
                                                          ? NetworkImage(lesson.tutorPhoto!)
                                                          : null,
                                                      child: (lesson.tutorPhoto == null || lesson.tutorPhoto!.isEmpty)
                                                          ? Text(
                                                        lesson.tutorName.isNotEmpty
                                                            ? lesson.tutorName[0].toUpperCase()
                                                            : "?",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                          : null,
                                                    ),
                                                    Text(
                                                      "  Tutor: ${lesson.tutorName}",
                                                      style: TextStyle(
                                                          fontSize: 11.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: w * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                              theColors.white,
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xff9C5633),
                                                                  width:
                                                                  w * 0.001),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(w *
                                                                  0.05)),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets.all(
                                                                w * 0.005),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: w *
                                                                          0.01,
                                                                      bottom: w *
                                                                          0.003),
                                                                  child: Icon(
                                                                    Icons
                                                                        .access_time_outlined,
                                                                    size:
                                                                    w * 0.03,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: w *
                                                                          0.01,
                                                                      right: w *
                                                                          0.01),
                                                                  child: Text(
                                                                    "${lesson.time}",
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
                                                          "  Duration: ${lesson.lessonDuration} hr",
                                                          style: TextStyle(
                                                              fontSize: 9.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.02,
                                                    ),
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
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: w * 0.005,
                                                              bottom:
                                                              w * 0.005,
                                                              left: w * 0.02,
                                                              right:
                                                              w * 0.02),
                                                          child: Text(
                                                            "cancelled",
                                                            style: TextStyle(
                                                                color:
                                                                Colors.green,
                                                                fontSize: 8.sp),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                topLeft:
                                                Radius.circular(w * 0.15),
                                                topRight:
                                                Radius.circular(w * 0.15)),
                                            color: theColors.classclr,
                                            border: Border(
                                                top: BorderSide(
                                                    width: w * 0.003,
                                                    color:
                                                    theColors.classbrdrclr),
                                                left: BorderSide(
                                                    width: w * 0.003,
                                                    color:
                                                    theColors.classbrdrclr),
                                                right: BorderSide(
                                                    width: w * 0.003,
                                                    color:
                                                    theColors.classbrdrclr)),
                                          ),
                                          child: FittedBox(
                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(top: w * 0.014),
                                              child: Text(
                                                "${lesson.subject}",
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
                        ],
                      );
                    } else if (state is LessonError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: w * 0.1),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: w * 0.15,
                                color: Colors.red[300],
                              ),
                              SizedBox(height: w * 0.03),
                              Text(
                                'Unable to load lessons',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.red[600],
                                ),
                              ),
                              SizedBox(height: w * 0.02),
                              ElevatedButton(
                                onPressed: () => _refreshLessons(),
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: w * 0.1),
                        child: Text(
                          'No data available',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshLessons() async {
    if (selectedDate != null) {
      _fetchLessonsForDate(selectedDate!);
    }
  }
}