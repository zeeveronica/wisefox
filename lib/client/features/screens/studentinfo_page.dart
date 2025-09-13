import 'package:wisefox/client/features/model/sentedfile_model.dart';

import 'package:wisefox/client/features/screens/tutor_page.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class StudentInfoPage extends StatefulWidget {
  final StudentListModel student;
  const StudentInfoPage({
    super.key,
    required this.student,
  });

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  final List<DateTime> dates =
      List.generate(30, (index) => DateTime.now().add(Duration(days: index)));
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    String selectedDateText = selectedDate != null
        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
        : todayDate;
    return Scaffold(
      backgroundColor: theColors.white,
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorPage(),
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
                "Done",
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
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Text(
          "Tutor Info",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.more_vert_outlined,
            color: theColors.white,
          ),
          SizedBox(
            width: w * 0.02,
          )
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
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: w * 0.18,
                  width: w * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.09),
                      color: theColors.tabbarclr.withOpacity(0.5)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: w * 0.06,
                      backgroundImage:
                          NetworkImage(widget.student.studentPhoto.toString()),
                      backgroundColor: Colors.grey[200],
                    ),
                    title: Row(
                      children: [
                        Text(
                          widget.student.fullName,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xff53545E),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: w * 0.03,
                        ),
                        Container(
                          height: w * 0.06,
                          width: w * 0.18,
                          decoration: BoxDecoration(
                            color: theColors.white,
                            borderRadius: BorderRadius.circular(w * 0.03),
                            border: Border.all(
                              width: w * 0.001,
                              color: Color(0xffEAEAEA),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              // "active",
                              widget.student.isActive ? 'Active' : 'On Leave',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: widget.student.isActive
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: w * 0.05,
                          color: Color(0xffFFCE31),
                        ),
                        Text(" 4.5"),
                        SizedBox(width: w * 0.02),
                        Container(
                          height: w * 0.04,
                          width: w * 0.003,
                          color: theColors.verticaldvdrclr,
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          // "Uk",
                          widget.student.country,
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theColors.tabbarclr.withOpacity(0.5),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                      bottom: Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                          height: w * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Subjects for Tution',
                                style: TextStyle(
                                    fontSize: 11.sp, color: Color(0xff53545E)),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Biology, Chemistry, Maths',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Color(0xff53545E),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.03,
                        ),
                        Divider(
                          color: theColors.divider,
                          height: w * 0.02,
                        ),
                        SizedBox(
                          height: w * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Email Id',
                                style: TextStyle(
                                    fontSize: 11.sp, color: Color(0xff53545E)),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'reshmanair@gmail.com',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Color(0xff53545E),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tutor Allocations",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                    Container(
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
                            "assets/client/icons/more.svg",
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: w * 0.02,
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
                // Text(
                //   todayDate,
                //   style: TextStyle(fontSize: 11.sp),
                // ),
                Text(
                  selectedDate != null &&
                          DateFormat('MMMM d, yyyy').format(selectedDate!) ==
                              todayDate
                      ? "Today"
                      : selectedDateText,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  "6 Classes Available",
                  style: TextStyle(fontSize: 11.sp, color: theColors.textgrey),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  padding: EdgeInsets.only(top: w * 0.08),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
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
                                      bottomRight: Radius.circular(w * 0.03),
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
                                            backgroundImage:
                                                AssetImage(theimage.profilepc),
                                          ),
                                          Text(
                                            "  Tutor: Reshma Nair",
                                            style: TextStyle(fontSize: 11.sp),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: w * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                // width: w * 0.37,
                                                // height: w * 0.07,
                                                decoration: BoxDecoration(
                                                    color: theColors.white,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xff9C5633),
                                                        width: w * 0.001),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            w * 0.05)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(w * 0.005),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: w * 0.01,
                                                                bottom:
                                                                    w * 0.003),
                                                        child: Icon(
                                                          Icons
                                                              .access_time_outlined,
                                                          size: w * 0.03,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: w * 0.01,
                                                                right:
                                                                    w * 0.01),
                                                        child: Text(
                                                          "10:00 AM - 11:00 AM",
                                                          style: TextStyle(
                                                              fontSize: 8.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "  Duration: 1 hr",
                                                style:
                                                    TextStyle(fontSize: 9.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          Container(
                                            // width: w * 0.24,
                                            // height: w * 0.08,
                                            decoration: BoxDecoration(
                                                color: theColors.white,
                                                border: Border.all(
                                                    color: Color(0xffDDDDDD)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.05)),

                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: w * 0.005,
                                                    bottom: w * 0.005,
                                                    left: w * 0.02,
                                                    right: w * 0.02),
                                                child: Text(
                                                  "Cancelled",
                                                  style: TextStyle(
                                                      color: Colors.red,
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
                              // top: w * 0.01,
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
                                          color: theColors.classbrdrclr)),
                                ),
                                child: FittedBox(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: w * 0.014),
                                    child: Text(
                                      "Mathematics",
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
                SizedBox(
                  height: w * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
