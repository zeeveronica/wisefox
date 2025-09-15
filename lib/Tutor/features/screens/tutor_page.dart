import 'package:wisefox/client/features/bloc/tutor/tutor_bloc.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/screens/chat_page.dart';
import 'package:wisefox/client/features/screens/tutor_info_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theicons.dart';
import '../../../apps/utils/theimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<TutorBloc>().add(FetchTutors());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theColors.white,
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
          "Tutor",
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
                      hintText: "Search Tutor",
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
                BlocBuilder<TutorBloc, TutorState>(
                  builder: (context, state) {
                    if (state is TutorLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: theColors.primaryColor));
                    } else if (state is TutorLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatCard(
                            w,
                            Color(0xffB4B4F5),
                            "Tutor's",
                            state.tutorCount.toString(),
                          ),
                          _buildStatCard(
                            w,
                            Color(0xffE2BEE2),
                            "Active",
                            state.activeTutors.toString(),
                          ),
                          _buildStatCard(
                            w,
                            Color(0xffC1C9EB),
                            "On Leave",
                            state.onLeaveTutors.toString(),
                          ),
                        ],
                      );
                    } else if (state is TutorError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return Center(child: Text('No data'));
                  },
                ),
                SizedBox(height: w * 0.04),
                Text(
                  'My Tutors',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: w * 0.03),
                BlocBuilder<TutorBloc, TutorState>(
                  builder: (context, state) {
                    if (state is TutorLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: theColors.primaryColor));
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
                                  builder: (context) => TutorInfo(
                                    tutor: tutor,
                                  ),
                                ),
                              );
                            },
                            child: Container(
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
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: w * 0.07,
                                      backgroundImage:
                                          NetworkImage(tutor.photo.toString()),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          tutor.userName,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                        SizedBox(width: w * 0.02),
                                        Container(
                                          height: w * 0.04,
                                          width: w * 0.002,
                                          color: theColors.verticaldvdrclr,
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
                                          width: w * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            border: Border.all(
                                              width: w * 0.001,
                                              color: Color(0xffEAEAEA),
                                            ),
                                          ),
                                          child: Center(
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
                                      ],
                                    ),
                                    trailing: Icon(Icons.more_vert_outlined),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "View Details",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color:
                                                        theColors.primaryColor,
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
                                                    ));
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
                                                      child: tutor.isActive
                                                          ? SvgPicture.asset(
                                                              theicons.messages)
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
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return Center(child: Text('No data'));
                  },
                )
              ],
            ),
          ),
        ),
      ),
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
