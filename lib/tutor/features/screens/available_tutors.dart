import 'dart:ui';

import 'package:wisefox/client/features/screens/chat_page.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableTutors extends StatefulWidget {
  const AvailableTutors({super.key});

  @override
  State<AvailableTutors> createState() => _AvailableTutorsState();
}

class _AvailableTutorsState extends State<AvailableTutors> {
  Map<String, bool> values = {
    'Michael Scott': false,
    'Reshma Nair': false,
    'ubaise': false,
    'ahammed': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _showrequest(context);
        },
        child: Container(
          height: w * 0.3,
          width: w * 1,
          decoration:
              BoxDecoration(color: theColors.tabbarclr.withOpacity(0.5)),
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2 Tutors Selected"),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theColors.bottomnavColor,
                    borderRadius: BorderRadius.circular(w * 0.07),
                  ),
                  child: Center(
                    child: Text(
                      "Send Request",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: theColors.white),
                    ),
                  ),
                ),
              ],
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
          "Tutors",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: h,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(w * 0.03),
              child: Text("4 Tutors Available"),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (BuildContext context, int index) {
                String key = values.keys.elementAt(index);
                return Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      leading: Checkbox(
                        checkColor: theColors.primaryColor,
                        value: values[key],
                        onChanged: (bool? value) {
                          setState(() {
                            values[key] = value ?? false;
                          });
                        },
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          return const Color(0xffEFF0F0);
                        }),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.010),
                        ),
                        side: BorderSide(
                          width: w * 0.003,
                          color: theColors.primaryColor,
                        ),
                      ),
                      title: Row(
                        children: [
                          CircleAvatar(child: Image.asset(theimage.profilepc)),
                          SizedBox(width: w * 0.02),
                          Text(
                            key,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(width: w * 0.02),
                          Container(
                            height: w * 0.03,
                            width: 1,
                            color: Color(0xffD4D6D9),
                          ),
                          SizedBox(
                            width: w * 0.01,
                          ),
                          Icon(
                            Icons.star_outlined,
                            color: Color(0xffFFCE31),
                            size: w * 0.04,
                          ),
                          SizedBox(
                            width: w * 0.01,
                          ),
                          Text(
                            "5",
                            style: TextStyle(
                                fontSize: 11.sp, color: Color(0xff7D7D7D)),
                          )
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () => _showAlertDialog(context),
                        child: Container(
                          height: w * 0.07,
                          width: w * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.06),
                            color: theColors.white,
                            // border: Border.all(color: theColors.classbrdrclr)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("View Details"),
                              Container(
                                height: w * 0.06,
                                width: w * 0.06,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      theColors.primaryColor.withOpacity(0.1),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: w * 0.04,
                                  color: theColors.primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (index < values.length - 1)
                      Divider(
                        color: Color(0xffD4D6D9),
                        thickness: 1.0,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20.w),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 20.w,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 15.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(theimage.profilepc),
                                ),
                                SizedBox(height: 14.w),
                                Text(
                                  "Richard Valien",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5.w),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star_outlined,
                                      color: Color(0xffFFCE31),
                                      size: w * 0.04,
                                    ),
                                    SizedBox(
                                      width: w * 0.01,
                                    ),
                                    Text(
                                      "5",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Color(0xff7D7D7D)),
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: w * 0.05,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email Id",
                                            style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Phone number",
                                            style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Rate",
                                            style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Hours Complete",
                                            style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Country",
                                            style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.02,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            ":  reshmanair.gmail.com",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            ":  8776665355",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            ":  00.0",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            ":  0",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            ":  10 months ago",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: w * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showsuccessful(context);
                                  },
                                  child: Container(
                                    height: w * 0.11,
                                    width: w * 1,
                                    decoration: BoxDecoration(
                                      color: theColors.bottomnavColor,
                                      borderRadius:
                                          BorderRadius.circular(w * 0.03),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Request",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: theColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: w * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(),
                                        ));
                                  },
                                  child: Container(
                                    height: w * 0.11,
                                    width: w * 1,
                                    decoration: BoxDecoration(
                                        color: theColors.white,
                                        borderRadius:
                                            BorderRadius.circular(w * 0.03),
                                        border: Border.all(
                                            color: Color(0xffFDFDFD))),
                                    child: Center(
                                      child: Text(
                                        "Message",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: theColors.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))))
              ],
            ),
          );
        });
  }

  void _showrequest(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(),
              ),
            ),
            Center(
              child: AlertDialog(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: w * 0.06,
                            width: w * 0.06,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff707070)),
                            child: Icon(
                              Icons.close,
                              color: theColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: w * 0.05),
                    Image.asset(
                      "assets/client/images/Group 7902.png",
                      width: w * 0.3,
                      height: w * 0.2,
                    ),
                    SizedBox(height: w * 0.03),
                    Text(
                      "Request Successful",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: w * 0.03),
                    Text(
                      "2 Tutors are selected",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: w * 0.05),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: w * 0.12,
                        width: w * 1,
                        decoration: BoxDecoration(
                          color: theColors.bottomnavColor,
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                        child: Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: theColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showsuccessful(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(),
              ),
            ),
            Center(
              child: AlertDialog(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: w * 0.06,
                            width: w * 0.06,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff707070)),
                            child: Icon(
                              Icons.close,
                              color: theColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: w * 0.05),
                    Image.asset(
                      "assets/client/images/Group 7902.png",
                      width: w * 0.3,
                      height: w * 0.2,
                    ),
                    SizedBox(height: w * 0.03),
                    Text(
                      "Request Successful",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: w * 0.03),
                    Text(
                      "Tutor Name  :  Michael Scott",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: w * 0.05),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AvailableTutors(),
                            ));
                      },
                      child: Container(
                        height: w * 0.12,
                        width: w * 1,
                        decoration: BoxDecoration(
                          color: theColors.bottomnavColor,
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                        child: Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: theColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}
