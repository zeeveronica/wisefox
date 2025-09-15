import 'package:wisefox/client/features/bloc/isactive/is_active_bloc.dart';
import 'package:wisefox/client/features/bloc/studentcount/studentcount_bloc.dart';
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/client/features/bloc/tutor/tutor_bloc.dart';
import 'package:wisefox/client/features/model/sentedfile_model.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/screens/chat_page.dart';
import 'package:wisefox/client/features/screens/studentadmission.dart';
import 'package:wisefox/client/features/screens/tutor_info_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theicons.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/client/features/screens/studentinfo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyStudents extends StatefulWidget {
  const MyStudents({super.key});

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<StudentCountBloc>().add(FetchStudentCount());
    context.read<TutorBloc>().add(FetchTutors());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theColors.white,
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentAdmission(),
              ));
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: w * 0.03, right: w * 0.03, bottom: w * 0.02),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theColors.bottomnavColor,
              borderRadius: BorderRadius.circular(w * 0.07),
            ),
            child: Center(
              child: Text(
                "Add New Student",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: theColors.white),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bottomnav(
                  initialIndex: 2,
                ),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Text(
          "My Students",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(theimage.pagebackground),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7),
              BlendMode.lighten,
            ),
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: w * 0.003,
                      color: theColors.tabbarclr,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.09),
                  ),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Students...",
                      hintStyle: TextStyle(
                        fontSize: 10.sp,
                        color: theColors.textgrey,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 29,
                        color: Colors.grey,
                      ),
                      suffixIcon: Container(
                        height: w * 0.08,
                        width: w * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.09),
                          color: Color(0xffE7ECF8),
                        ),
                        child: Center(
                          child: SvgPicture.asset("assets/client/icons/more.svg"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: w * 0.04),
                BlocBuilder<StudentCountBloc, StudentCountState>(
                  builder: (context, state) {
                    if (state is StudentCountLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: theColors.primaryColor));
                    } else if (state is StudentCountLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatCard(
                            w,
                            Color(0xffB4B4F5),
                            "My Students",
                            state.studentCount.toString(),
                          ),
                          _buildStatCard(
                            w,
                            Color(0xffE2BEE2),
                            "Active",
                            state.activeStudents.toString(),
                          ),
                          _buildStatCard(
                            w,
                            Color(0xffC1C9EB),
                            "On Leave",
                            state.onLeaveStudents.toString(),
                          ),
                        ],
                      );
                    } else if (state is StudentCountError) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    return Center(child: Text('No data'));
                  },
                ),
                SizedBox(height: w * 0.04),
                Text(
                  'My Students',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: w * 0.03),
                BlocBuilder<DemoRequestBloc, DemoRequestState>(
                  builder: (context, state) {
                    if (state is DemoRequestedfilesLoaded &&
                        state.files.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.files.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final file = state.files[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: w * 0.01),
                            height: w * 0.3,
                            width: w,
                            decoration: BoxDecoration(
                              color: theColors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              border: Border.all(
                                width: w * 0.001,
                                color: Color(0xffE7ECF8),
                              ),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentInfoPage(student: file),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      "${file.firstName}",
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                    subtitle: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: w * 0.06,
                                          // width: w * 0.2,
                                          child: BlocConsumer<IsActiveBloc,
                                              IsActiveState>(
                                            listener: (context, isActiveState) {
                                              if (isActiveState
                                                  is IsActiveSuccess) {
                                                // Trigger refresh by refetching the files
                                                context
                                                    .read<StudentCountBloc>()
                                                    .add(FetchStudentCount());
                                              } else if (isActiveState
                                                  is IsActiveFailure) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Failed to update status: ${isActiveState.error}'),
                                                    backgroundColor:
                                                        theColors.primaryColor,
                                                  ),
                                                );
                                              }
                                            },
                                            builder: (context, isActiveState) {
                                              return GestureDetector(
                                                onTap: () {
                                                  _showStatusDialog(
                                                      context, file);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      // vertical: 5,
                                                      horizontal: 07),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: w * 0.001,
                                                        color: theColors
                                                            .lighttextgrey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            w * 0.06),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        file.activeChoices, // Displays the current selected status
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color:
                                                              file.activeChoices ==
                                                                      'Active'
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        size: w * 0.05,
                                                        color:
                                                            Color(0xff707070),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      radius: w * 0.07,
                                      backgroundImage:
                                          NetworkImage(file.studentPhoto),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    trailing: Icon(Icons.more_vert_outlined),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: w * 0.23),
                                    Container(
                                      width: w * 0.63,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "View Details",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: theColors.primaryColor,
                                                ),
                                              ),
                                              SizedBox(width: w * 0.02),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                size: w * 0.04,
                                                color: theColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatPage(),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Container(
                                                height: w * 0.08,
                                                width: w * 0.08,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          w * 0.09),
                                                  color: Color(0xffEDEDF5),
                                                ),
                                                child: Center(
                                                  child: file.isActive
                                                      ? SvgPicture.asset(
                                                          theicons.messages)
                                                      : SvgPicture.asset(
                                                          "assets/client/icons/mssg.svg"),
                                                ),
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
                          );
                        },
                      );
                    } else if (state is DemoRequestedLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: theColors.primaryColor,
                        ),
                      );
                    } else if (state is DemoRequestedfilesError) {
                      return Center(
                        child: Text('Error: ${state.error}'),
                      );
                    } else {
                      return Center(child: Text('No data available.'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStatusDialog(BuildContext context, StudentListModel file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: theColors.white,
          backgroundColor: theColors.white,
          title: Text(
            'Select Status',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ...['Active', 'Inactive', 'Onleave', 'Holiday']
                    .map((String value) {
                  return GestureDetector(
                    onTap: () {
                      // Call the BLoC to update the status
                      BlocProvider.of<IsActiveBloc>(context).add(
                        IsActiveRequested(
                          studentId: file.id.toString(),
                          status: value,
                        ),
                      );

                      // Update the displayed status in the dropdown
                      setState(() {
                        file.activeChoices = value;
                      });

                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == 'Active'
                              ? Colors.green
                              : (value == 'Inactive'
                                  ? Colors.red
                                  : (value == 'Onleave'
                                      ? Colors.orange
                                      : Colors.blue)),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(double w, Color color, String title, String count) {
    return Container(
      height: w * 0.2,
      width: w * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(theimage.triangle),
        ),
        borderRadius: BorderRadius.circular(w * 0.03),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: w * 0.03,
          left: w * 0.03,
          right: w * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            Text(
              count,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
