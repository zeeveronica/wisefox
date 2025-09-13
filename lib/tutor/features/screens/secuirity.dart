import 'dart:ui';

import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theColors.white,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Bottomnav(
                    initialIndex: 4,
                  ),
                ));
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Text(
          "Security",
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: w * 0.03,
                ),
                Text(
                  "Account login activity",
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: w * 0.02,
                ),
                Text(
                  "You're currently logged in on these devices",
                  style: TextStyle(color: Color(0xff4A5361), fontSize: 10.sp),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: theColors.tabbarclr.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(w * 0.03)),
                  width: w,
                  // padding: EdgeInsets.all(w * 0.03),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.03)),
                          height: w * 0.12,
                          width: w * 0.15,
                          child: Icon(Icons.phone_iphone_outlined),
                        ),
                        title: Text(
                          "iPhone 12 Pro",
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "os Angeles,- Mar 16 at 2:47PM",
                          style:
                              TextStyle(fontSize: 9, color: theColors.textgrey),
                        ),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text("Logout",
                              style: TextStyle(
                                  color: theColors.primaryColor,
                                  fontSize: 10.sp)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                const Text(
                  "Logins on other devices",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: theColors.tabbarclr.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          width: w,
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: w * 0.10,
                              width: w * 0.15,
                              child: const Icon(Icons.phone_iphone_outlined),
                            ),
                            title: Text(
                              "iPhone 12 Pro",
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "Washington, - Nov 06 at 10:43AM",
                              style: TextStyle(
                                  fontSize: 8.sp, color: theColors.textgrey),
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text("Logout",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: theColors.primaryColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: GestureDetector(
          onTap: () => _showLogoutDialog(context),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: w * 0.001,
                color: Color(0xffF90000),
              ),
              borderRadius: BorderRadius.circular(w * 0.09),
            ),
            height: 55,
            // width: w * 1,
            child: Center(
              child: Text(
                "Logout All",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffF90000)),
              ),
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
                              Navigator.of(context).pop();
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => LoginPage(),
                              //     ));
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
