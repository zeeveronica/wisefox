import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wisefox/apps/features/bloc/webView/web_view_bloc.dart';
import 'package:wisefox/apps/features/bloc/webView/web_view_event.dart';
import 'package:wisefox/apps/features/bloc/webView/web_view_state.dart';
import 'package:wisefox/apps/model/user.dart';

import 'package:wisefox/apps/utils/utils.dart';
import 'package:wisefox/student/features/bloc/demolessons/demo_lessons_bloc.dart';
import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
import 'package:wisefox/student/features/bloc/overviewcount/overviewcount_bloc.dart';
import 'package:wisefox/student/features/bloc/students/student_bloc.dart';
import 'package:wisefox/student/features/screens/bottom_nav.dart';
import 'package:wisefox/student/features/screens/class_details.dart';
import 'package:wisefox/student/features/screens/demo_seeall.dart';
import 'package:wisefox/student/features/screens/notification.dart';
import 'package:wisefox/student/features/screens/tutor_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';
import '../../../apps/widget/commingSoon.dart';
import 'timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<DateTime> dates =
      List.generate(07, (index) => DateTime.now().add(Duration(days: index)));
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;
  User? student;

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(FetchLessons('upcoming'));
    selectedDate = DateTime.now();
    context.read<StudentBloc>().add(FetchStudents());
    context.read<OverviewBloc>().add(FetchOverviewCount());
    context.read<DemoLessonsBloc>().add(FetchDemoLessons());
    _tabController = TabController(length: 5, vsync: this);



    _loadUser();
  }
Future<void> getUserName() async {

  var loginData = await SharedPreferencesHelper.getData("loginData");
  var activeId = loginData["user"]["activeId"];
   var firstName = loginData["user"]["firstName"];}
  Future<void> _loadUser() async {
    final s = await AppUtils.getUser();
    if (s != null) {
      setState(() {
        student = s;
      });
    }
  }

  void _handleJoinMeeting(int lessonId) {
    context.read<WebViewBloc>().add(CreateMeeting(lessonId: lessonId));
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
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      theColors.primaryColor),
                                ),
                              )
                            : SizedBox(
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static List<String> carousel = [
    theimage.homecvr,
    theimage.homecvr,
    theimage.homecvr,
    theimage.homecvr,
  ];
  int _currentIndex = 0;
  bool isSameDay(DateTime lessonDate, DateTime selectedDate) {
    return lessonDate.year == selectedDate.year &&
        lessonDate.month == selectedDate.month &&
        lessonDate.day == selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    String appbardate = DateFormat('EEEE, MMM d').format(DateTime.now());
    String selectedDateText = selectedDate != null
        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
        : todayDate;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theColors.white,
        appBar:
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theColors.primaryColor,
          leadingWidth: w * 0.4,
          title: Image.asset(
            "assets/common/images/logo.png",
            width: w * 0.2,
            height: w * 0.2,
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                       // builder: (context) => Notifications(),
                        builder: (context) => ComingSoonPage(message:'Notifications', leadingIcon: true,),
                      ));
                },
                child: SvgPicture.asset("assets/student/icons/Group 7937.svg"))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: h,
            width: w,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(theimage.pagebackground),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), BlendMode.lighten),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                SizedBox(
                  height: w * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02),
                  child: Text(
                    'Hey ${student?.firstName ?? 'Student'}, ready to get started?',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // makes it heading style
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.02,
                ),
                Container(
                  width: w,
                  // height: h * 0.25,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: carousel.length,
                        options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            aspectRatio: 2,
                            viewportFraction: 1,
                            autoPlay: true),
                        itemBuilder: (context, index, realIndex) {
                          return Padding(
                            padding: EdgeInsets.all(w * 0.02),
                            child: Container(
                              height: h * 0.2,
                              width: w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w * 0.02),
                                image: DecorationImage(
                                  image: AssetImage(carousel[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: w * 0.05,
                                      ),
                                      Container(
                                          width: w * 0.25,
                                          child: Image.asset(
                                              "assets/common/images/logo.png")),
                                      // "assets/student/images/Group 7944.png")),
                                      SizedBox(
                                        height: w * 0.03,
                                      ),
                                      Text(
                                        "Find The Online Tutor",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w700,
                                            color: theColors.white),
                                      ),
                                      Text(
                                        "For you",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w700,
                                            color: theColors.white),
                                      ),
                                      SizedBox(
                                        height: w * 0.02,
                                      ),
                                      Container(
                                        height: w * 0.06,
                                        // width: w * 0.3,
                                        decoration: BoxDecoration(
                                            color: theColors.white,
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            Text(
                                              "Take a Trial Class",
                                              style:
                                                  TextStyle(fontSize: w * 0.023),
                                            ),
                                            SizedBox(
                                              width: w * 0.02,
                                            ),
                                            Icon(Icons.play_circle_fill_outlined)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: w * 0.07,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: w * 0.04,
                        left: w * 0.81,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentIndex,
                            count: carousel.length,
                            effect: ScaleEffect(
                                dotHeight: 6,
                                dotWidth: 6,
                                activeDotColor: Colors.white,
                                dotColor: Colors.white,
                                scale: 1.6,
                                spacing: w * 0.01),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: w * 0.02,
                ),
                BlocBuilder<OverviewBloc, OverviewState>(
                  builder: (context, state) {
                    if (state is OverviewLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: theColors.primaryColor));
                    } else if (state is OverviewLoaded) {
                      final overview = state.overviewCount;
                      return Container(
                        height: w * 0.69,
                        width: w * 1,
                        color: Color(0xffF2F2F9),
                        child: Padding(
                          padding: EdgeInsets.all(w * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overview",
                                style: TextStyle(
                                    fontSize: 13.sp, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: w * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: w * 0.25,
                                    width: w * 0.45,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.02),
                                      color: theColors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: w * 0.05, left: w * 0.03),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Demo Classes",
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              SizedBox(
                                                height: w * 0.025,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    overview.demoLessons
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: w * 0.06,
                                            left: w * 0.28,
                                            child: Container(
                                              height: w * 0.16,
                                              width: w * 0.16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.09),
                                                color: Color(0x20F7CACF),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  height: w * 0.06,
                                                  width: w * 0.06,
                                                  child: Image.asset(
                                                    "assets/student/images/Group 8017.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TutorPage(),
                                          ));
                                    },
                                    child: Container(
                                      height: w * 0.25,
                                      width: w * 0.45,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(w * 0.02),
                                        color: theColors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: w * 0.05, left: w * 0.03),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Tutors",
                                                  style:
                                                      TextStyle(fontSize: 12.sp),
                                                ),
                                                SizedBox(
                                                  height: w * 0.025,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      overview.allocatedTutors
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top: w * 0.06,
                                              left: w * 0.28,
                                              child: Container(
                                                height: w * 0.16,
                                                width: w * 0.16,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          w * 0.09),
                                                  color: Color(0x30D5F0F5),
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    height: w * 0.055,
                                                    width: w * 0.06,
                                                    child: Image.asset(
                                                      "assets/student/images/Group 8018.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: w * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: w * 0.25,
                                    width: w * 0.45,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.02),
                                      color: theColors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: w * 0.05, left: w * 0.03),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Active Lessons",
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              SizedBox(
                                                height: w * 0.025,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    overview.activeLessons
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: w * 0.06,
                                            left: w * 0.28,
                                            child: Container(
                                              height: w * 0.16,
                                              width: w * 0.16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.09),
                                                color: Color(0x30FEEFC5),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  height: w * 0.06,
                                                  width: w * 0.06,
                                                  child: Image.asset(
                                                    "assets/student/images/Group 8019.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: w * 0.25,
                                    width: w * 0.45,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.02),
                                      color: theColors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: w * 0.05, left: w * 0.03),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Cancelled Lessons",
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 11.sp),
                                              ),
                                              SizedBox(
                                                height: w * 0.025,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    overview.cancelledLessons
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: w * 0.06,
                                            left: w * 0.28,
                                            child: Container(
                                              height: w * 0.16,
                                              width: w * 0.16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.09),
                                                color: Color(0x30D1E8C7),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  height: w * 0.063,
                                                  width: w * 0.045,
                                                  child: Image.asset(
                                                    "assets/student/images/Group 8020.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    else if (state is OverviewError) {
                      print('Error: ${state.message}');
                      return Center(child: Text('No Data Available'));
                    } else {
                      return Center(child: Text('No data'));
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: w * 0.03, top: w * 0.03, right: w * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Demo Lessons",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DemoSeeall(),
                              ));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 11.sp, color: theColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<DemoLessonsBloc, DemoLessonsState>(
                  builder: (context, state) {
                    if (state is DemoLessonsLoaded &&
                        state.demoLessons.isNotEmpty) {
                      final demoLesson =
                          state.demoLessons.first; // Get the first lesson
                      log("time is ${demoLesson.time}");
      
                      return Padding(
                        padding: EdgeInsets.all(w * 0.03),
                        child: Container(
                          height: w * 0.25,
                          width: w * 1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/student/images/triangle.png"),
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
                                              borderRadius:
                                                  BorderRadius.circular(w * 0.09),
                                              color: theColors.white,
                                            ),
                                            child: Center(
                                              child: Container(
                                                  height: w * 0.035,
                                                  width: w * 0.035,
                                                  child: SvgPicture.asset(
                                                      "assets/student/icons/Group 7973.svg")),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          "Demo Class: ${demoLesson.subjectName}",
                                          style: TextStyle(fontSize: 12.sp),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              "Tutor: ${demoLesson.tutorName}",
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
                                            InAppWebView(
                                                initialUrlRequest: URLRequest(
                                                    url: WebUri(
                                                        "https://flutter.dev")));
                                          },
                                          child: Container(
                                            // width: w * 0.25,
                                            height: w * 0.06,
                                            decoration: BoxDecoration(
                                                color: theColors.white,
                                                border: Border.all(
                                                    color:
                                                        theColors.primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.05)),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: w * 0.03,
                                                    right: w * 0.03),
                                                child: Text(
                                                  "View Now",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color:
                                                          theColors.primaryColor),
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
                                      borderRadius:
                                          BorderRadius.circular(w * 0.09),
                                      color: theColors.white,
                                    ),
                                    child: Center(
                                      child: Container(
                                          height: w * 0.06,
                                          width: w * 0.06,
                                          child: SvgPicture.asset(
                                              "assets/student/icons/notification (10).svg")),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state is DemoLessonsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: theColors.primaryColor),
                      ); // Show loading indicator
                    } else if (state is DemoLessonsError) {
                      print('Error: ${state.message}');
                      return Center(child: Text('No Data Available'));
                      // return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return Center(child: Text('No lessons available'));
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: w * 0.03, top: w * 0.03, right: w * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lessons",
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bottomnav(
                                        initialIndex: 0,
                                      )));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 11.sp, color: theColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                      height: w * 0.16, // Adjusted height as per new design
                      child: ListView.builder(
                        physics:
                            NeverScrollableScrollPhysics(), // Prevent scrolling of the ListView
                        itemCount:
                            1, // Only one item to hold the horizontal scroll view
                        shrinkWrap:
                            true, // Ensure the ListView only takes up as much space as needed
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(w * 0.02),
                            child: Container(
                              height:
                                  w * 0.1, // Adjusted height for the container
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < dates.length; i++) ...[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedDate = dates[i];
                                            context
                                                .read<LessonBloc>()
                                                .add(SetSelectedDate(dates[i]));
                                          });
                                        },
                                        child: Container(
                                          width: w * 0.23,
                                          height: w * 0.09,
                                          padding: EdgeInsets.only(
                                              top: w * 0.01,
                                              left: w * 0.004,
                                              right: w * 0.004),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.08),
                                            color: selectedDate != null &&
                                                    selectedDate!.year ==
                                                        dates[i].year &&
                                                    selectedDate!.month ==
                                                        dates[i].month &&
                                                    selectedDate!.day ==
                                                        dates[i].day
                                                ? Color(
                                                    0xffCACAD9) // Selected color
                                                : Color(
                                                    0xffFAFBFD), // Unselected color
                                            border: Border.all(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _getDateLabel(dates[i]),
                                                  style: TextStyle(
                                                    color: selectedDate != null &&
                                                            selectedDate!.year ==
                                                                dates[i].year &&
                                                            selectedDate!.month ==
                                                                dates[i].month &&
                                                            selectedDate!.day ==
                                                                dates[i].day
                                                        ? Colors.black
                                                        : Colors.black,
                                                    fontSize: 10.sp,
                                                    fontWeight: selectedDate !=
                                                                null &&
                                                            selectedDate!.year ==
                                                                dates[i].year &&
                                                            selectedDate!.month ==
                                                                dates[i].month &&
                                                            selectedDate!.day ==
                                                                dates[i].day
                                                        ? FontWeight.w600
                                                        : FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (i != dates.length - 1)
                                        Container(
                                          height: w * 0.02,
                                          width: 16.0,
                                          color: Color(0xffFAFBFD),
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                BlocBuilder<LessonBloc, LessonState>(
                  builder: (context, state) {
                    if (state is LessonLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: theColors.primaryColor));
                    } else if (state is LessonLoaded) {
                      final filteredLessons = state.lessons.where((lesson) {
                        DateTime lessonDate = DateTime.parse(lesson.date);
                        return isSameDay(lessonDate, selectedDate!);
                      }).toList();
      
                      String lessonCountText =
                          "${filteredLessons.length} Classes Available";
      
                      return Padding(
                        padding: EdgeInsets.all(w * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              padding: EdgeInsets.only(top: w * 0.04),
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
                                                    color:
                                                        theColors.classbrdrclr)),
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
                                                        backgroundImage:
                                                            AssetImage(theimage
                                                                .profilepc),
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
                                                                color: theColors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xff9C5633),
                                                                    width: w *
                                                                        0.001),
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
                                                                      size: w *
                                                                          0.03,
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
                                                      // _buildJoinButton(lesson.id),
                                                      // Row(
                                                      //   children: [
                                                      //     Container(
                                                      //       decoration:
                                                      //           BoxDecoration(
                                                      //         color:
                                                      //             theColors.white,
                                                      //         border: Border.all(
                                                      //           color: Color(
                                                      //               0xffDDDDDD),
                                                      //         ),
                                                      //         borderRadius:
                                                      //             BorderRadius
                                                      //                 .circular(w *
                                                      //                     0.05),
                                                      //       ),
                                                      //       child: Padding(
                                                      //         padding: EdgeInsets
                                                      //             .symmetric(
                                                      //           vertical:
                                                      //               w * 0.005,
                                                      //           horizontal:
                                                      //               w * 0.01,
                                                      //         ),
                                                      //         child: Row(
                                                      //           mainAxisAlignment:
                                                      //               MainAxisAlignment
                                                      //                   .spaceAround,
                                                      //           children: [
                                                      //             SizedBox(
                                                      //               width:
                                                      //                   w * 0.002,
                                                      //             ),
                                                      //             Center(
                                                      //               child:
                                                      //                   Container(
                                                      //                 height: w *
                                                      //                     0.04,
                                                      //                 width: w *
                                                      //                     0.04,
                                                      //                 decoration:
                                                      //                     BoxDecoration(
                                                      //                   borderRadius:
                                                      //                       BorderRadius.circular(w *
                                                      //                           0.09),
                                                      //                   color: Color(
                                                      //                       0x2000A276),
                                                      //                 ),
                                                      //                 child:
                                                      //                     Center(
                                                      //                   child:
                                                      //                       Container(
                                                      //                     height: w *
                                                      //                         0.025,
                                                      //                     width: w *
                                                      //                         0.025,
                                                      //                     child: Image
                                                      //                         .asset(
                                                      //                       "assets/student/images/Group 7965.png",
                                                      //                       fit: BoxFit
                                                      //                           .cover,
                                                      //                     ),
                                                      //                   ),
                                                      //                 ),
                                                      //               ),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               width:
                                                      //                   w * 0.01,
                                                      //             ),
                                                      //             Text(
                                                      //               "Join Now",
                                                      //               style: TextStyle(
                                                      //                   fontSize:
                                                      //                       8.sp),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               width:
                                                      //                   w * 0.01,
                                                      //             ),
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
                                                      color: theColors
                                                          .classbrdrclr)),
                                            ),
                                            child: FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: w * 0.014,
                                                    left: w * 0.01,
                                                    right: w * 0.01),
                                                child: Text(
                                                  lesson.subject,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 09.sp,
                                                      fontWeight:
                                                          FontWeight.w900),
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
                        ),
                      );
                    } else if (state is LessonError) {
                      print('Error: ${state.message}');
                      return Center(child: Text('No Data Available'));
                      //return Center(child: Text('Error: ${state.message}'));
                    }
                    return Center(child: Text('No data'));
                  },
                ),
                SizedBox(
                  height: w * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.all(w * 0.03),
                  child: Container(
                    height: w * 0.3,
                    width: w * 1,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: Color(0xffFAFBFD).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(w * 0.03),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/student/images/Group 7936.png"),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: w * 0.03, top: w * 0.03, left: w * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Help and Support",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.",
                            style: TextStyle(fontSize: 8.sp),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: w * 0.2,
                              height: w * 0.05,
                              decoration: BoxDecoration(
                                  color: theColors.white,
                                  border:
                                      Border.all(color: theColors.primaryColor),
                                  borderRadius: BorderRadius.circular(w * 0.05)),
                              child: Center(
                                child: Text(
                                  "View Now",
                                  style: TextStyle(
                                      fontSize: 8.sp,
                                      color: theColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDateLabel(DateTime date) {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(Duration(days: 1));

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return 'Tomorrow';
    } else {
      return DateFormat('d MMM').format(date);
    }
  }
}
