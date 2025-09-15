import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:wisefox/client/features/bloc/clientdemolesson/clientdemolesson_bloc.dart';
import 'package:wisefox/client/features/bloc/student/students_bloc.dart';
import 'package:wisefox/client/features/bloc/clients/client_bloc.dart';
import 'package:wisefox/client/features/bloc/dashboard/dashboard_bloc.dart';
import 'package:wisefox/client/features/bloc/demolessons/demo_lessons_bloc.dart';
import 'package:wisefox/client/features/bloc/clientlesson/clientlesson_bloc.dart';
import 'package:wisefox/client/features/bloc/clientoverviewcount/clientoverviewcount_bloc.dart';
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/client/features/bloc/tutorlist/tutorlist_bloc.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/screens/class_details.dart';
import 'package:wisefox/client/features/screens/clientdemolesson.dart';
import 'package:wisefox/client/students/demo_seeall.dart';
import 'package:wisefox/client/features/screens/notification.dart';
import 'package:wisefox/client/features/screens/overview_page.dart';
import 'package:wisefox/client/features/screens/refer_page.dart';
import 'package:wisefox/client/features/screens/search_page.dart';
import 'package:wisefox/client/features/screens/tutor_page.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/studenthome_page.dart';
import 'package:wisefox/client/students/studentsbottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({
    super.key,
  });

  @override
  State<TutorHomePage> createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _academicYearController = TextEditingController();
  String? _selectedStudent;
  // bool _showStudents = true; // Start with showing students
  bool _isClientDropdownVisible = false; // Track dropdown visibility
  String? _defaultClientName;

  void _selectClientStudent(String label) {
    setState(() {
      _selectedStudent = label;
      _academicYearController.text = _selectedStudent ?? '';
      _isClientDropdownVisible = false;
    });
  }

  void _toggleClientDropdown(String id) {
    setState(() {
      _isClientDropdownVisible = !_isClientDropdownVisible;
    });
    context.read<StudentBloc>().add(SelectStudent(id));
    log("${SelectStudent}");
  }

  Future<void> _saveSelectedStudentId(String studentId) async {
    await SharedPreferencesHelper.saveData("selectedStudentId", studentId);
    log("Sav selectedStudentId: $studentId");
  }

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<DateTime> dates =
      List.generate(07, (index) => DateTime.now().add(Duration(days: index)));
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    loadSavedTimezone();
    selectedDate = DateTime.now();
    loadSavedTimezone().then((_) {
      // Ensure that _selectedTimeZone has a value before dispatching events
      if (_selectedTimeZone != null && _selectedTimeZone.isNotEmpty) {
        // context.read<ClassesBloc>().add(FetchClassesOngoing(_selectedTimeZone));
        context
            .read<ClientLessonBloc>()
            .add(FetchLessons('upcomingmob', _selectedTimeZone));
      } else {
        // Handle the case where the timezone is null or invalid
        print("Timezone is not available");
      }
    });
    // context.read<ClientLessonBloc>().add(FetchLessons('upcomingmob'));
    selectedDate = DateTime.now();
    context.read<ClientBloc>().add(FetchClients());
    context.read<ClientOverviewBloc>().add(FetchClientOverviewCount());
    context
        .read<ClientDemoLessonBloc>()
        .add(FetchClientDemoLessons('demo_lessons', _selectedTimeZone));
    context.read<DashboardBloc>().add(FetchDashboardData());
    context.read<DemoRequestBloc>().add(FetchSentedfiles());
    _tabController = TabController(length: 5, vsync: this);
  }

  String _selectedTimeZone = 'UTC';

  @override
  Future<void> loadSavedTimezone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTimezone = prefs.getString('selected_timezone');
    print("Loaded TimeZone: $savedTimezone"); // Debug print

    setState(() {
      _selectedTimeZone = savedTimezone ?? 'UTC'; // Default value if not set
    });

    if (_selectedTimeZone != 'UTC') {
      context
          .read<ClientLessonBloc>()
          .add(FetchLessons('upcomingmob', _selectedTimeZone));
    }
  }

  Future<void> saveTimezone(String timezone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_timezone', timezone);
    print("TimeZone saved: $timezone"); // Debug print
  }

  void _onTimezoneSelected(String newValue) {
    setState(() {
      _selectedTimeZone = newValue;
    });
    saveTimezone(newValue);
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
    return Scaffold(
      backgroundColor: theColors.white,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leadingWidth: w * 0.36,
        leading: BlocBuilder<ClientBloc, ClientState>(
          builder: (context, state) {
            // if (state is ClientLoading) {
            //   return Center(
            //       child:
            //           CircularProgressIndicator(color: theColors.primaryColor));
            // } else if (state is ClientLoaded) {
            //   final student =
            //       state.clients.isNotEmpty ? state.clients[0] : null;
            //
            //   if (student != null) {
            //     // Store the default client name on initial load
            //     if (_defaultClientName == null) {
            //       _defaultClientName = student.firstName;
            //     }
            //
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           width: w * 0.01,
            //         ),
            //         CircleAvatar(
            //           radius: w * 0.05,
            //           backgroundImage: NetworkImage(student.clientPhoto),
            //           backgroundColor: Colors.grey[200],
            //         ),
            //         SizedBox(
            //           width: w * 0.01,
            //         ),
            //         Expanded(
            //           child: GestureDetector(
            //             onTap: () =>
            //                 _toggleClientDropdown(student.id.toString()),
            //             child: AbsorbPointer(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "${appbardate}",
            //                     overflow: TextOverflow.ellipsis,
            //                     maxLines: 1,
            //                     style: TextStyle(
            //                       fontSize: 08.sp,
            //                       color: theColors.white,
            //                     ),
            //                   ),
            //                   Row(
            //                     children: [
            //                       Text(
            //                         student.firstName,
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                           fontSize: 08.sp,
            //                           fontWeight: FontWeight.w600,
            //                           color: theColors.white,
            //                         ),
            //                       ),
            //                       Icon(
            //                         Icons.keyboard_arrow_down_outlined,
            //                         color: theColors.white,
            //                         size: w * 0.04,
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     );
            //   } else {
            //     return Center(child: Text('No student data available'));
            //   }
            // } else if (state is ClientError) {
            //   return Center(child: Text('Error: ${state.message}'));
            // }
            return Center(child: Text(''));
          },
        ),
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
                      builder: (context) => Notifications(),
                    ));
              },
              child: SvgPicture.asset("assets/client/icons/Group 7937.svg"))
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
              if (_isClientDropdownVisible) // Dropdown content
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF4F4F4)),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: BlocBuilder<DemoRequestBloc, DemoRequestState>(
                      builder: (context, state) {
                        if (state is DemoRequestedLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is DemoRequestedfilesLoaded) {
                          return Container(
                            // Adjust height as needed
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.files.length,
                              itemBuilder: (context, index) {
                                final file = state.files[index];
                                return ListTile(
                                  title: Text(
                                    file.firstName,
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  onTap: () async {
                                    final selectedStudentId = file.id;
                                    await _saveSelectedStudentId(
                                        selectedStudentId.toString());

                                    context.read<StudentBloc>().add(
                                        SelectStudent(
                                            selectedStudentId.toString()));

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentsBottomnav(),
                                      ),
                                    );
                                    _selectClientStudent(file.firstName);
                                  },
                                );
                              },
                            ),
                          );
                        } else if (state is DemoRequestedfilesError) {
                          return Center(
                              child: Text('Error loading academic years'));
                        } else {
                          return Center(
                              child: Text('No academic years available'));
                        }
                      },
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: Container(
                  width: w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: w * 0.002,
                      color: theColors.tabbarclr,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  child: TextFormField(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(),
                          ));
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Students...",
                      hintStyle: TextStyle(
                        fontSize: 11.sp,
                        color: theColors.lighttextgrey,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 22,
                        color: theColors.lighttextgrey,
                      ),
                    ),
                  ),
                ),
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
                                            "assets/client/images/Group 7944.png")),
                                    SizedBox(
                                      height: w * 0.03,
                                    ),
                                    Text(
                                      "Online Tuition Classes",
                                      style: TextStyle(
                                          fontSize: w * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: theColors.white),
                                    ),
                                    Text(
                                      "Available!",
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
                                              BorderRadius.circular(w * 0.01)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          Text(
                                            "Add your student",
                                            style:
                                                TextStyle(fontSize: w * 0.023),
                                          ),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
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
              Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: Text(
                  "Overview",
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: OverviewRow(),
              ),
              SizedBox(
                height: w * 0.02,
              ),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: theColors.primaryColor));
                  } else if (state is DashboardLoaded) {
                    final dashboard = state.dashboardData;
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
                              "Allocated",
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
                                              overflow: TextOverflow.ellipsis,
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
                                                  dashboard.demoClasses
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
                                                  "assets/client/images/Group 8017.png",
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
                                              "Active Allocations",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                                  dashboard.activeAllocations
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
                                                  "assets/client/images/Group 8019.png",
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
                            ),
                            SizedBox(
                              height: w * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => TutorPage(),
                                    //     ));
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
                                                "Weekly Tution Hours",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
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
                                                    dashboard.weeklyTuitionHrs
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
                                                child: Icon(
                                                  Icons.access_time,
                                                  size: w * 0.07,
                                                  color: Color(0xff51A6B5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                              overflow: TextOverflow.ellipsis,
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
                                                  dashboard.cancelledLessons
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
                                                child: Icon(
                                              Icons.close,
                                              color: Color(0xff345326),
                                              size: w * 0.06,
                                            )),
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
                  } else if (state is DashboardError) {
                    // return Center(child: Text('Error: ${state.message}'));
                    return Center(child: Text('Coming Soon'));
                  } else {
                    // return Center(child: Text('No data'));
                    return Center(child: Text('Coming Soon'));
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: ReferNowContainer(),
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
                              builder: (context) => ClientDemoSeeall(),
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
              BlocBuilder<ClientDemoLessonBloc, ClientDemoLessonState>(
                builder: (context, state) {
                  if (state is ClientDemoLessonLoaded &&
                      state.lessons.isNotEmpty) {
                    final demoLesson =
                        state.lessons.first; // Get the first lesson
                    log("time is ${demoLesson.time}");

                    return Padding(
                      padding: EdgeInsets.all(w * 0.03),
                      child: Container(
                        height: w * 0.25,
                        width: w * 1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/client/images/triangle.png"),
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
                                                    "assets/client/icons/Group 7973.svg")),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Text(
                                        "Demo Class: ${demoLesson.subject}",
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
                                            "assets/client/icons/notification (10).svg")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is ClientDemoLessonLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: theColors.primaryColor),
                    ); // Show loading indicator
                  } else if (state is ClientDemoLessonError) {
                    // return Text('Error: ${state.message}');
                    return Center(child: Text('Coming Soon'));
                  } else {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.all(w * 0.03),
                      child: Text('No lessons available'),
                    ));
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
                                              .read<ClientLessonBloc>()
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
              BlocBuilder<ClientLessonBloc, ClientLessonState>(
                builder: (context, state) {
                  if (state is ClientLessonLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: theColors.primaryColor));
                  } else if (state is ClientLessonLoaded) {
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
                                              top: w * 0.03,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: w * 0.02),
                                                    CircleAvatar(
                                                      radius: w * 0.05,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              lesson.tutorName),
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                    ),
                                                    SizedBox(width: w * 0.02),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "${lesson.studentInfo.length} Student Allocated",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: w * 0.007),
                                                          Container(
                                                            height: w * 0.04,
                                                            width: w * 0.002,
                                                            color: Color(
                                                                0xffDCE4F2),
                                                          ),
                                                          SizedBox(
                                                              width: w * 0.007),
                                                          Expanded(
                                                            child: Text(
                                                              "Tutor: ${lesson.tutorName}",

                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp),
                                                              // In case the text is long
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: w * 0.007),
                                                          Container(
                                                            height: w * 0.04,
                                                            width: w * 0.003,
                                                            color: Color(
                                                                0xffDCE4F2),
                                                          ),
                                                          SizedBox(
                                                              width: w * 0.007),
                                                          Expanded(
                                                            child: Text(
                                                              "Rate: £${lesson.clientRate}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: w * 0.02),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: w * 0.02,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: theColors
                                                                  .white,
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xff9C5633),
                                                                width:
                                                                    w * 0.001,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(w *
                                                                          0.05),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .all(w *
                                                                      0.005),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: w *
                                                                          0.01,
                                                                      bottom: w *
                                                                          0.003,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .access_time_outlined,
                                                                      size: w *
                                                                          0.03,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: w *
                                                                          0.01,
                                                                      right: w *
                                                                          0.01,
                                                                    ),
                                                                    child: Text(
                                                                      "${lesson.time}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              8.sp),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      right: w *
                                                                          0.01,
                                                                    ),
                                                                    child: Text(
                                                                      "- ${lesson.endTime}",
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
                                                            "   Duration: ${lesson.lessonDuration} hr",
                                                            style: TextStyle(
                                                                fontSize: 9.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: w * 0.02),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                theColors.white,
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xffDDDDDD)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(w *
                                                                        0.05),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical:
                                                                  w * 0.005,
                                                              horizontal:
                                                                  w * 0.01,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                SizedBox(
                                                                    width: w *
                                                                        0.002),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: w *
                                                                        0.04,
                                                                    width: w *
                                                                        0.04,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(w *
                                                                              0.09),
                                                                      color: Color(
                                                                          0x2000A276),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        height: w *
                                                                            0.025,
                                                                        width: w *
                                                                            0.025,
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/client/images/Group 7965.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: w *
                                                                        0.01),
                                                                Text(
                                                                  "Join Now",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          8.sp),
                                                                ),
                                                                SizedBox(
                                                                    width: w *
                                                                        0.01),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: w * 0.02,
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
                  } else if (state is ClientLessonError) {
                    // return Center(child: Text('Error: ${state.message}'));
                    return Center(child: Text('Coming Soon'));
                  }
                  // return Center(child: Text('No data'));
                  return Center(child: Text('Coming Soon'));
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
                          image: AssetImage("assets/client/images/Group 7936.png"),
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
