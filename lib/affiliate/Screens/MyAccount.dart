import 'dart:developer';
import 'dart:ui';

import 'package:wisefox/affiliate/Screens/Help.dart';
import 'package:wisefox/affiliate/Screens/LoginPage.dart';
import 'package:wisefox/affiliate/Screens/Personalinfo.dart';
import 'package:wisefox/affiliate/Screens/Security.dart';
import 'package:wisefox/affiliate/Screens/about.dart';
import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Myaccount extends StatefulWidget {
  const Myaccount({
    super.key,
  });

  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  @override
  Widget build(BuildContext context) {
    // Initialize screen dimensions
    double h = ScreenUtil().screenHeight;
    double w = ScreenUtil().screenWidth;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff00008B),
          centerTitle: true,
          title: const Text(
            "My Account",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        body: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/affiliate/images/baground3.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6), BlendMode.lighten),
            )),
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // BlocBuilder<UserBloc, ClassesState>(
                //   builder: (context, state) {
                //     log("state in myaccount is $state");
                //     if (state is ClassesLoading) {
                //       return Center(child: CircularProgressIndicator());
                //     } else if (state is UserLoaded) {
                // return
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: ClipOval(
                              child: CircleAvatar(
                                radius: 34,
                                backgroundColor: Colors
                                    .transparent, // Optional: Makes the background transparent
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/affiliate/images/photo2.png",
                                    fit: BoxFit.cover,
                                    width: w * 0.23, // Double the radius value
                                    height: h * 0.20, // Double the radius value
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 80.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Richard ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.04,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff48BA6F),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: w * 0.07,
                                      width: w * 0.19,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Active",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8.sp,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'reshmanair@gmail.com',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Invite a friend to WiseFox and get ₹20",
                                  style: TextStyle(fontSize: 11),
                                ),
                                SizedBox(height: 10),
                                DottedBorderContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //     } else if (state is ClassesError) {
                //       return Center(child: Text('Error: ${state.message}'));
                //     }
                //     return Center(child: Text('No user data'));
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "APP SETTINGS",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalDetailsPage()));
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      title: Text(
                        "Personal Info",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      subtitle: Text(
                        "Manage your profile information",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 11),
                      ),
                      leading: CircleAvatar(
                          backgroundColor: AppColors.divider.withOpacity(0.1),
                          child: SvgPicture.asset("assets/affiliate/images/users.svg")),
                    ),
                  ],
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Security()));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  title: Text(
                    "Security",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  subtitle: Text(
                    "Login history",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 11),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: AppColors.divider.withOpacity(0.1),
                      child: SvgPicture.asset("assets/affiliate/images/security.svg")),
                ),
                Divider(
                  height:
                      0, // Set the height of the divider to zero to reduce space
                  thickness: 1, // Set thickness of the divider
                  color: Colors.grey[300], // Set color of the divider
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Help()));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  title: Text(
                    "Help Center",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: AppColors.divider.withOpacity(0.1),
                      child: SvgPicture.asset("assets/affiliate/images/headphones.svg")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  title: Text(
                    "About WiseFox",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: AppColors.divider.withOpacity(0.1),
                      child: SvgPicture.asset("assets/affiliate/images/help.svg")),
                ),
                // ListTile(
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //         builder: (context) => PrivacyPolicyPage()));
                //   },
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     size: 16,
                //   ),
                //   title: Text(
                //     "Privacy Policy",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 12),
                //   ),
                //   leading: CircleAvatar(
                //       backgroundColor: AppColors.divider.withOpacity(0.1),
                //       child: Icon(
                //         Icons.privacy_tip_outlined,
                //         color: AppColors.textgrey.withOpacity(0.7),
                //         size: 18,
                //       )),
                // ),
                // ListTile(
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //         builder: (context) => Feedbackpage()));
                //   },
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     size: 16,
                //   ),
                //   title: Text(
                //     "FeedBack",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 12),
                //   ),
                //   leading: CircleAvatar(
                //     backgroundColor: AppColors.divider.withOpacity(0.1),
                //     child: Icon(
                //       Icons.feedback_outlined,
                //       color: AppColors.textgrey.withOpacity(0.7),
                //       size: 18,
                //     ),
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: AppColors.divider.withOpacity(0.1),
                      child: SvgPicture.asset("assets/affiliate/images/logout.svg")),
                ),
              ],
            )))));
  }

  void _showLogoutDialog(BuildContext context) {
    double h = ScreenUtil().screenHeight;
    double w = ScreenUtil().screenWidth;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Stack(children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 9.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                title: Column(
                  children: [
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Are you sure you want to logout?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: w * 0.10,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: w * 0.001,
                                color: AppColors.tabbarclr.withOpacity(0.8),
                              ),
                              right: BorderSide(
                                width: w * 0.001,
                                color: AppColors.tabbarclr,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: AppColors.textgrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Container(
                          height: w * 0.10,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: w * 0.001,
                                color: AppColors.tabbarclr,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white.withOpacity(0.7),
                elevation: 0,
              ),
            )
          ]);
        });
  }
}
