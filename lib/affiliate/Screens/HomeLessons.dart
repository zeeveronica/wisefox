// Define your AppColors and ClassesBloc somewhere in your project

import 'package:wisefox/main.dart';
import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Lessons extends StatefulWidget {
  final TabController tabController2;

  Lessons({required this.tabController2});

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<Lessons> {
  // Map<DateTime, List<Upcomming>> dateToClassesMap = {};
  int selectedIndex = 0;
  List<DateTime> dates = [];
  DateTime? selectedDate;
  List<String> tabTitles = []; // Add this field

  @override
  void initState() {
    super.initState();

    // Fetch classes for "Today" on widget initialization
    _fetchDataForSelectedDate(DateTime.now());
    _generateTabTitles();
    widget.tabController2.addListener(_handleTabSelection);
  }

  void _fetchDataForSelectedDate(DateTime date) {
    // Fetch data from the Bloc for the selected date
    // context.read<ClassesBloc>().add(FetchClassesForDate(date));
  }

  void _generateTabTitles() {
    final DateFormat dateFormat = DateFormat('d MMM');
    final today = DateTime.now();

    dates = List.generate(
        5, (i) => today.add(Duration(days: i))); // Generate dates for tabs

    tabTitles = dates.map((date) {
      String label;
      if (date.day == today.day &&
          date.month == today.month &&
          date.year == today.year) {
        label = 'Today';
      } else if (date.day == today.add(Duration(days: 1)).day &&
          date.month == today.month &&
          date.year == today.year) {
        label = 'Tomorrow';
      } else {
        label = dateFormat.format(date);
      }

      return '$label';
    }).toList();
  }

  int getClassCountForDate(DateTime date) {
    // Ensure the date is formatted correctly (remove time component)
    final formattedDate = DateTime(date.year, date.month, date.day);

    // Get the list of classes for the formatted date
    // final classes = dateToClassesMap[formattedDate] ?? [];

    // Return the length of the list
    return 0;
  }

  void _handleTabSelection() {
    if (widget.tabController2.index < dates.length) {
      setState(() {
        selectedIndex = widget.tabController2.index;
        selectedDate = dates[selectedIndex];
        // context.read<ClassesBloc>().add(FetchClassesForDate(selectedDate!));
      });
    }
  }

  @override
  void dispose() {
    widget.tabController2.removeListener(_handleTabSelection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    dates.forEach((date) {
      print('Date: $date, Number of classes: ${getClassCountForDate(date)}');
    });
    return Column(
      children: [
        Container(
          height: w * 0.19,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tabTitles.length, (i) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.tabController2.animateTo(i);
                        },
                        child: Container(
                          height: w * 0.10,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: selectedIndex == i
                                ? Color(0xffCACAD9)
                                : AppColors.divider.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              tabTitles[i],
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: selectedIndex == i
                                    ? Colors.black
                                    : Colors.black,
                                fontWeight: selectedIndex == i
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (i != tabTitles.length - 1)
                        Container(
                          width: 16.0,
                          height: 5.0,
                          color: AppColors.divider.withOpacity(0.1),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(height: w * 0.03),
        // BlocBuilder<ClassesBloc, ClassesState>(
        //   builder: (context, state) {
        //     if (state is ClassesLoading) {
        //       CircularProgressIndicator();
        //     } else if (state is ClassesLoaded) {
        //       final upcomingClasss = state.classes;

        //       _generateTabTitles();
        //       if (upcomingClasss.isEmpty) {
        //         return Center(
        //           child: Padding(
        //             padding: const EdgeInsets.all(24.0),
        //             child: Text(
        //               'No scheduled classes.',
        //               style: TextStyle(fontSize: 16, color: Colors.grey),
        //             ),
        //           ),
        //         );
        //       }
        // return
        ListView.builder(
          shrinkWrap: true,
          // itemCount: upcomingClasss.length,
          itemCount: 5,
          padding: EdgeInsets.only(top: w * 0.08),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // // final classData = upcomingClasss[index];
            // String imageUrl = classData.students[0].studentPhoto ?? '';
            // bool isValidUrl = imageUrl.startsWith('https://');
            return InkWell(
              onTap: () {
                // log("date time is ${classData.time}");

                // final DateTime endTime =
                //     DateTime.parse(classData.time.toString());
                // Navigator.push(
                //     context,
                //       MaterialPageRoute(
                //           builder: (context) => ClassDetails(
                //               lessonId: classData.id,
                //               startTime: classData.time)));
              },
              child: Align(
                heightFactor: 0.7,
                child: Stack(
                  children: [
                    Container(
                      height: w * 0.450,
                      width: w * 1,
                      // color: theColors.primaryColor,
                    ),
                    Positioned(
                      top: w * 0.07,
                      child: Container(
                        height: w * 0.320,
                        width: w * 0.94,
                        decoration: BoxDecoration(
                            color: AppColors.tabbarclr,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(w * 0.02),
                            ),
                            border: Border.all(color: AppColors.container)),
                        child: Padding(
                          padding: EdgeInsets.all(w * 0.03),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  ClipOval(
                                    child: Image.network(
                                      // isValidUrl
                                      //     ? imageUrl
                                      //     :
                                      '', // Use the URL if valid, otherwise an empty string
                                      width: w *
                                          0.02, // Adjust the width as needed
                                      height: h *
                                          0.04, // Adjust the height as needed
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image(
                                          image: CustomImage
                                              .defaultImage, // Use the default image from CustomImage
                                          width: w * 0.09,
                                          height: h * 0.04,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      // "${classData.studentCount}
                                      "Students Allocated",
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: w * 0.03,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  Container(
                                    width: w * 0.38,
                                    height: w * 0.07,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff9C5633),
                                            width: w * 0.001),
                                        borderRadius:
                                            BorderRadius.circular(w * 0.05)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          size: w * 0.04,
                                        ),
                                        Text(
                                          // "${classData.timeSlot}",
                                          "",
                                          style: TextStyle(fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "  Duration:"
                                    // ${classData.lessonDuration} hr",
                                    ,
                                    style: TextStyle(fontSize: 8.sp),
                                  ),
                                  SizedBox(
                                    width: w * 0.05,
                                  ),
                                  Container(
                                    width: w * 0.17,
                                    height: w * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border:
                                        //     // Border.all(color: Color(0xffDDDDDD)),
                                        borderRadius:
                                            BorderRadius.circular(w * 0.05)),
                                    // child: InkWell(onTap: (){
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                                    // },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Container(
                                            height: w * 0.04,
                                            width: w * 0.03,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.09),
                                              color: Color(0xffF5F8FB),
                                            ),
                                            child: Center(
                                                child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        Color(0x40F7CACF),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Color(0xffF94246),
                                                      size: 11,
                                                    ))),
                                          ),
                                        ),
                                        Text(
                                          "cancell",
                                          style: TextStyle(fontSize: 8.sp),
                                        )
                                      ],
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
                      top: w * 0.01,
                      child: Container(
                        height: w * 0.0650,
                        width: w * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(w * 0.15),
                              topRight: Radius.circular(w * 0.15)),
                          color: AppColors.tabbarclr,
                          border: Border(
                              top: BorderSide(
                                  width: w * 0.0034, color: Color(0xffDCE4F2)),
                              left: BorderSide(
                                width: w * 0.003,
                                color: Color(0xffDCE4F2),
                              ),
                              right: BorderSide(
                                  width: w * 0.004, color: Color(0xffDCE4F2))),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: w * 0.012),
                          child: Text(
                            // "${classData.subject}",
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

          //   } else if (state is ClassesError) {
          //     return Center(
          //       child: Text("Error:${state.message}"),
          //     );
          //   }
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // },
          // ),
        )
      ],
    );
  }
}

class HelpAndSuppot extends StatelessWidget {
  final double height;
  final double width;

  const HelpAndSuppot({required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(w * 0.01),
      child: Container(
        height: w * 0.30,
        width: w * 1,
        decoration: BoxDecoration(
            // color: Color(0xffFAFBFD),
            borderRadius: BorderRadius.circular(w * 0.03),
            image: DecorationImage(
                image: AssetImage("assets/affiliate/images/slide.png"),
                fit: BoxFit.fill)),
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Help and Support",
                style:
                    TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600),
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.",
                style: TextStyle(fontSize: w * 0.02),
              ),
              Row(
                children: [
                  Container(
                    width: w * 0.24,
                    height: w * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.05)),
                    child: Center(
                      child: Text(
                        "View Now",
                        style:
                            TextStyle(fontSize: 9.sp, color: Color(0xff00008B)),
                      ),
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

class TabContent2 extends StatefulWidget {
  const TabContent2({Key? key}) : super(key: key);

  @override
  State<TabContent2> createState() => _TabContent2State();
}

class _TabContent2State extends State<TabContent2> {
  @override
  void initState() {
    super.initState();
    // context.read<DemoBloc>().add(FetchdemoClasses());
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<DemoBloc, ClassesState>(
    // builder: (context, state) {
    //   if (state is FetchdemoClasses) {
    //     return Center(child: CircularProgressIndicator());
    //   } else if (state is ClassesError) {
    //     return Center(child: Text(state.message));
    //   } else if (state is DemoLoaded) {
    //     final lesson = state.lessonresponse.isNotEmpty
    //         ? state.lessonresponse.first
    //         : null;

    //     if (lesson == null) {
    //       return Center(child: Text('No data available'));
    //     }

    return Padding(
      padding: EdgeInsets.all(w * 0.03),
      child: Container(
        height: w * 0.25,
        width: w * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/affiliate/images/triangle.png"),
                fit: BoxFit.cover),
            border: Border.all(color: Color(0xffEEF2F9)),
            color: Color(0xffA9C2DE).withOpacity(0.9),
            borderRadius: BorderRadius.circular(w * 0.03)),
        child: Padding(
          padding: EdgeInsets.all(w * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: w * 0.03,
                  ),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          height: w * 0.06,
                          width: w * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.09),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Container(
                                height: w * 0.035,
                                width: w * 0.035,
                                child: SvgPicture.asset(
                                    "assets/affiliate/images/video1.svg")),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.02,
                      ),
                      Text(
                        "Demo Class:"
                        //  ${lesson.subjectName}",
                        ,
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: w * 0.03,
                        ),
                        // Text(
                        //   demoLesson.time,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(fontSize: 8.sp),
                        // ),
                        Container(
                          height: 40,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: w * 0.001,
                            width: 20,
                            indent: 12,
                            endIndent: 12,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "Tutor: "
                            // ${lesson.tutorName}",
                            ,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 8.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: w * 0.07,
                      ),
                      GestureDetector(
                        onTap: () {
                          // InAppWebView(
                          //     initialUrlRequest: URLRequest(
                          //         url: WebUri(
                          //             "https://flutter.dev")));
                        },
                        child: Container(
                          // width: w * 0.25,
                          height: w * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.bluedark),
                              borderRadius: BorderRadius.circular(w * 0.05)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: w * 0.03, right: w * 0.03),
                              child: Text(
                                "View Now",
                                style: TextStyle(
                                    fontSize: 11.sp, color: AppColors.bluedark),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: w * 0.13,
                  width: w * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.09),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                        height: w * 0.06,
                        width: w * 0.06,
                        child:
                            SvgPicture.asset("assets/affiliate/images/notification.svg")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //     }
    //     return Container();
    //   },
    // );
  }
}
