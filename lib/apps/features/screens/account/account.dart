import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisefox/apps/features/screens/account/personal_info.dart';
import 'package:wisefox/apps/login.dart';
import 'package:wisefox/apps/utils/thecolors.dart';
import 'package:wisefox/apps/utils/utils.dart';
import 'package:wisefox/apps/features/bloc/auth_bloc.dart';
import 'package:wisefox/student/features/screens/about_page.dart';
import 'package:wisefox/student/features/screens/feedback.dart';
import 'package:wisefox/student/features/screens/help_center.dart';
import 'package:wisefox/student/features/screens/privacy_policy.dart';
import 'package:wisefox/student/features/screens/secuirity.dart';

import 'package:wisefox/main.dart';

import '../../../utils/theimage.dart';

class Myaccount extends StatefulWidget {
  const Myaccount({super.key});

  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theColors.primaryColor,
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(color: Colors.white),
        ),
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
                Text(
                  "APP SETTINGS",
                  style: TextStyle(
                    letterSpacing: w * 0.006,
                    color: theColors.textgrey,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalDetailsPage(),
                        ));
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                  title: Text(
                    "Personal Info",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Manage your profile information",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Color(0xff8994A0),
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                      child:
                          SvgPicture.asset("assets/student/icons/person rounded.svg")),
                ),
                // ListTile(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Security(),
                  //       ));
                  // },
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  // trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                  // title: Text(
                  //   "Security",
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  // subtitle: Text(
                  //   "Login history",
                  //   style: TextStyle(
                  //     fontSize: 9.sp,
                  //     color: Color(0xff8994A0),
                  //   ),
                  // ),
                //   leading: CircleAvatar(
                //       backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                //       child: SvgPicture.asset("assets/student/icons/secuirity.svg")),
                // ),
                Divider(
                  color: Color(0x26AEAEAE),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Help(),
                        ));
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                    title: Text(
                      "Help Center",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                        child: SvgPicture.asset("assets/student/icons/headphones.svg")),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutPage(),
                        ));
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                    title: Text(
                      "About Wisefox",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                        child: Icon(Icons.error_outline,
                            size: 16, color: Color(0xff616161))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage(),
                        ));
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                        child: Icon(
                          Icons.privacy_tip_outlined,
                          size: 16,
                          color: Color(0xff616161),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Feedbackpage(),
                        ));
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                    title: Text(
                      "Feedback",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                        child: Icon(
                          Icons.feedback_outlined,
                          size: 16,
                          color: Color(0xff616161),
                        )),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                    child: Icon(
                      Icons.logout,
                      size: 16,
                      color: Color(0xff616161),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Are you sure you want to logout?",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Cancel
                            },
                            child: Container(
                              height: w * 0.10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                  right: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: theColors.textgrey,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Clear any local app data if needed
                              AppUtils.clearUser();

                              // Dispatch Logout event to AuthBloc
                              BlocProvider.of<AuthBloc>(context).add(Logout());

                              // Navigate to login page and remove all previous routes
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UnifiedLoginPage(),
                                ),
                                    (route) => false,
                              );
                            },
                            child: Container(
                              height: w * 0.10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Color(0xff1E3A6E),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
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
