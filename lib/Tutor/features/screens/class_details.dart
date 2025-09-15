import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:wisefox/client/features/bloc/cancellessons/cancellesson_bloc.dart';
import 'package:wisefox/client/features/bloc/lessondetails/lessondetails_bloc.dart';
import 'package:wisefox/client/features/bloc/tutor/tutor_bloc.dart';
import 'package:wisefox/client/features/screens/chat_page.dart';
import 'package:wisefox/client/features/screens/tutor_info_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theicons.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassDetails extends StatefulWidget {
  final int lessonid;
  final String startTime;
  const ClassDetails(
      {super.key, required this.lessonid, required this.startTime});

  @override
  State<ClassDetails> createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  final TextEditingController _reasonController = TextEditingController();
  int? _lessonId;
  @override
  @override
  void initState() {
    super.initState();
    context.read<TutorBloc>().add(FetchTutors());
    context.read<CancelLessonBloc>().emit(CancelLessonInitial());
    _calculateRemainingTime();
    _startTimer();
    loadSavedTimezone();

    loadSavedTimezone().then((_) {
      if (_selectedTimeZone != null && _selectedTimeZone.isNotEmpty) {
        context.read<LessondetailsBloc>().add(
            FetchLessonDetails(widget.lessonid.toString(), _selectedTimeZone));
      } else {
        // Handle the case where the timezone is null or invalid
        print("Timezone is not available");
      }
    });
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
      context.read<LessondetailsBloc>().add(
          FetchLessonDetails(widget.lessonid.toString(), _selectedTimeZone));
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ));
              },
              child: Container(
                height: w * 0.14,
                width: w * 0.14,
                decoration: BoxDecoration(
                  color: theColors.white,
                  border: Border.all(color: theColors.primaryColor),
                  borderRadius: BorderRadius.circular(w * 0.09),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/client/icons/Group 7935.svg",
                    height: w * 0.05,
                    width: w * 0.05,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        final TextEditingController _textController =
                            TextEditingController();
                        final ScrollController _scrollController =
                            ScrollController();
                        final FocusNode _focusNode = FocusNode();
                        _textController.addListener(() {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          });
                        });

                        // Ensure `_lessonId` is correctly set before using it
                        final _lessonId = widget.lessonid;

                        return LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5.0, sigmaY: 5.0),
                                      child: Container(),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 16.0),
                                                Container(
                                                  height: 4.0,
                                                  width: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffE4EFF5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: SvgPicture.asset(
                                                          "assets/client/icons/close.svg"),
                                                    ),
                                                    SizedBox(width: 16.0),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Products",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "This will cancel your scheduled class for the day.",
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: w * 0.01),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Container(
                                              height: w * 0.4,
                                              decoration: BoxDecoration(
                                                color: Color(0xffF5F8FB),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0, right: 16.0),
                                                child: SingleChildScrollView(
                                                  controller: _scrollController,
                                                  child: TextField(
                                                    controller: _textController,
                                                    focusNode: _focusNode,
                                                    maxLines: null,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      labelText:
                                                          "Type Your Reason...",
                                                      labelStyle: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors.black),
                                                    ),
                                                    onEditingComplete: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onSubmitted: (value) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      print(
                                                          "Submitted value: $value");
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: w * 0.01),
                                          Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: BlocConsumer<
                                                  CancelLessonBloc,
                                                  CancelLessonState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is CancelLessonSuccess) {
                                                    // Show success message and close the modal
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Lesson cancelled successfully'),
                                                        backgroundColor:
                                                            theColors
                                                                .bottomnavColor,
                                                      ),
                                                    );

                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      Navigator.pop(context);
                                                    });
                                                  } else if (state
                                                      is CancelLessonFailure) {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Failed to cancel lesson: ${state.error}'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    });
                                                  }
                                                },
                                                builder: (context, state) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (_lessonId != null &&
                                                          _textController.text
                                                              .isNotEmpty) {
                                                        log("Canceling lesson with ID: $_lessonId and reason: ${_textController.text}");

                                                        // Dispatch the CancelLessonRequested event
                                                        BlocProvider.of<
                                                                    CancelLessonBloc>(
                                                                context)
                                                            .add(
                                                          CancelLessonRequested(
                                                            id: _lessonId!,
                                                            reasonForCancellation:
                                                                _textController
                                                                    .text,
                                                          ),
                                                        );

                                                        // Pop the context immediately after dispatching the event
                                                        Navigator.pop(context);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Please fill in all fields'),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: w *
                                                          0.15, // Adjust height as needed
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: theColors
                                                            .primaryColor, // Change to your desired color
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    w * 0.08),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Submit",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                height: w * 0.15,
                width: w * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xffCE2525),
                  borderRadius: BorderRadius.circular(w * 0.07),
                ),
                child: Center(
                  child: Text(
                    "Cancellation",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
          "Class Details",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            theicons.questionmark,
            color: theColors.white,
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: BlocBuilder<LessondetailsBloc, LessondetailsState>(
              builder: (context, state) {
                if (state is LessondetailsLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: theColors.primaryColor,
                  ));
                } else if (state is LessondetailsLoaded) {
                  final lesson = state.lessonData;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: w * 0.13,
                        decoration: BoxDecoration(
                          color: theColors.tabbarclr.withOpacity(0.5),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(w * 0.06),
                            bottom: Radius.circular(w * 0.06),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: w * 0.04,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${lesson.subject} Classes',
                                style: TextStyle(
                                    fontSize: 12.sp, color: Color(0xff53545E)),
                              ),
                              Container(
                                width: w * 0.35,
                                height: w * 0.11,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w * 0.05),
                                  color: theColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: theColors.white,
                                      size: w * 0.05,
                                    ),
                                    Text(
                                      _remainingTime != null
                                          ? formatDuration(_remainingTime!)
                                          : "Loading...",
                                      style: TextStyle(color: theColors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: w * 0.06,
                      ),
                      Text(
                        'Host: ${lesson.tutorName}',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: w * 0.04,
                      ),
                      Row(
                        children: [
                          Center(
                            child: Container(
                              height: w * 0.08,
                              width: w * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w * 0.09),
                                color: Color(0x15000000),
                              ),
                              child: Center(
                                child: Container(
                                    height: w * 0.035,
                                    width: w * 0.035,
                                    child: SvgPicture.asset(
                                        "assets/client/icons/calendar (8).svg")),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.02,
                          ),
                          Text(
                            "${lesson.date}",
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          SizedBox(
                            width: w * 0.02,
                          ),
                          Container(
                            height: w * 0.06,
                            width: w * 0.004,
                            color: theColors.verticaldvdrclr,
                          ),
                          SizedBox(
                            width: w * 0.02,
                          ),
                          Text(
                            "${lesson.time}",
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: w * 0.08,
                      ),
                      Text(
                        'Allocated Tutor',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: w * 0.04,
                      ),
                      BlocBuilder<TutorBloc, TutorState>(
                        builder: (context, state) {
                          if (state is TutorLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is TutorLoaded) {
                            return ListView.builder(
                              itemCount: state.tutors.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final tutor = state.tutors[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TutorInfo(tutor: tutor),
                                        ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: w * 0.01),
                                    height: w * 0.3,
                                    width: w,
                                    decoration: BoxDecoration(
                                      color: theColors.white.withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(w * 0.03),
                                      border: Border.all(
                                        width: w * 0.001,
                                        color: Color(0xffE7ECF8),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: w * 0.07,
                                            backgroundImage:
                                                AssetImage(theimage.profilepc),
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                tutor.userName,
                                                style:
                                                    TextStyle(fontSize: 12.sp),
                                              ),
                                              SizedBox(width: w * 0.02),
                                              Container(
                                                height: w * 0.04,
                                                width: w * 0.002,
                                                color:
                                                    theColors.verticaldvdrclr,
                                              ),
                                              SizedBox(width: w * 0.02),
                                              Text(
                                                tutor.country.toString(),
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: theColors.textgrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: w * 0.06,
                                                // width: w * 0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          w * 0.03),
                                                  border: Border.all(
                                                    width: w * 0.001,
                                                    color: Color(0xffEAEAEA),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: w * 0.02,
                                                        right: w * 0.02),
                                                    child: Text(
                                                      tutor.isActive
                                                          ? 'Active'
                                                          : 'On Leave', // Handle bool properly
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: tutor.isActive
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing:
                                              Icon(Icons.more_vert_outlined),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: w * 0.23),
                                            Container(
                                              width: w * 0.63,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: theColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                      SizedBox(width: w * 0.02),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_rounded,
                                                        size: w * 0.04,
                                                        color: theColors
                                                            .primaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ChatPage(),
                                                          ));
                                                    },
                                                    child: Center(
                                                      child: Container(
                                                        height: w * 0.08,
                                                        width: w * 0.08,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      w * 0.09),
                                                          color:
                                                              Color(0xffEDEDF5),
                                                        ),
                                                        child: Center(
                                                            child: tutor
                                                                    .isActive
                                                                ? SvgPicture.asset(
                                                                    theicons
                                                                        .messages)
                                                                : SvgPicture.asset(
                                                                    "assets/client/icons/mssg.svg")),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is TutorError) {
                            return Center(
                                child: Text('Error: ${state.message}'));
                          }
                          return Center(child: Text('No data'));
                        },
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Duration? _remainingTime;
  Timer? _timer;
  bool _isTimeReached = false;
  @override

  // Function to calculate the remaining time until the class time
  void _calculateRemainingTime() {
    try {
      // Get the current time
      DateTime now = DateTime.now();

      // Parse the class time string "HH:mm:ss"
      List<String> parts = widget.startTime.split(':');
      if (parts.length != 3) throw FormatException("Invalid time format");

      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(parts[2]);

      // Create a DateTime object for the class time today
      DateTime classTime =
          DateTime(now.year, now.month, now.day, hours, minutes, seconds);

      // If the class time is in the past, assume it's for tomorrow
      if (classTime.isBefore(now)) {
        classTime = classTime.add(Duration(days: 1));
      }

      // Calculate the remaining time
      _remainingTime = classTime.difference(now);
    } catch (e) {
      print("Error calculating remaining time: $e");
      _remainingTime = Duration.zero;
    }
  }

  // Start a timer that updates the remaining time every second
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _calculateRemainingTime();
        if (_remainingTime!.isNegative) {
          _remainingTime = Duration.zero;
          timer.cancel();
          _isTimeReached = true;
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
