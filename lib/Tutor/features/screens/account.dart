import 'dart:ui';

import 'package:wisefox/apps/login.dart';
import 'package:wisefox/apps/utils/utils.dart';
import 'package:wisefox/client/features/bloc/auth_bloc.dart';

import 'package:wisefox/client/features/bloc/clients/client_bloc.dart';
import 'package:wisefox/client/features/screens/about_page.dart';
import 'package:wisefox/client/features/screens/billshistory_page.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/screens/feedback.dart';
import 'package:wisefox/client/features/screens/help_center.dart';
import 'package:wisefox/client/features/screens/login_page.dart';
import 'package:wisefox/client/features/screens/personel_info.dart';
import 'package:wisefox/client/features/screens/privacy_policy.dart';
import 'package:wisefox/client/features/screens/secuirity.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myaccount extends StatefulWidget {
  const Myaccount({super.key});

  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  String _selectedItem = "UTC"; // Default to UTC

  List<String> _availableTimeZones = [
    "UTC",
    "Europe/London",
    "Africa/Lagos",
    "Asia/Kolkata"
  ];
  void loadSavedTimezone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTimezone = prefs.getString('selected_timezone');
    setState(() {
      _selectedItem = savedTimezone!;
    });
  }

  void initState() {
    super.initState();
    // Future.microtask(() => context.read<UserBloc>().add(LoadUser()));
    loadSavedTimezone();
  }

  void saveTimezone(String timezone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_timezone', timezone);
  }

  // Method to save timezone preference (you can customize it)
  void _saveTimeZonePreference(String newValue) {
    // Save the selected timezone, e.g., to shared preferences or a database
    print("TimeZone saved: $newValue");
  }

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
                // Container(
                //   // height: w * 0.19,
                //   decoration: BoxDecoration(
                //     color: Color(0xffE7ECF8).withOpacity(0.5),
                //     borderRadius: BorderRadius.circular(w * 0.1),
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       BlocBuilder<ClientBloc, ClientState>(
                //         builder: (context, state) {
                //           if (state is ClientLoading) {
                //             return Center(child: CircularProgressIndicator());
                //           } else if (state is ClientLoaded) {
                //             final client = state.clients.isNotEmpty
                //                 ? state.clients[0]
                //                 : null;
                //
                //             if (client != null) {
                //               return Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     // color: Colors.grey.withOpacity(0.2),
                //                     borderRadius: BorderRadius.circular(30),
                //                   ),
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(14.0),
                //                     child: Stack(
                //                       children: [
                //                         Positioned(
                //                           top: 0,
                //                           left: 0,
                //                           child: CircleAvatar(
                //                             radius: w * 0.08,
                //                             backgroundImage: NetworkImage(client
                //                                 .clientPhoto), // Load image from URL
                //                             backgroundColor: Colors.grey[200],
                //                           ),
                //                         ),
                //                         Padding(
                //                           padding: EdgeInsets.only(left: 80.0),
                //                           child: Column(
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.start,
                //                             children: [
                //                               Row(
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .spaceBetween,
                //                                 children: [
                //                                   Text(
                //                                     '${client.firstName}',
                //                                     style: TextStyle(
                //                                       color: Colors.black,
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       fontSize: 12,
                //                                     ),
                //                                   ),
                //                                   SizedBox(
                //                                     height: h * 0.04,
                //                                   ),
                //                                   Container(
                //                                     decoration: BoxDecoration(
                //                                       color: Color(0xff48BA6F),
                //                                       borderRadius:
                //                                           BorderRadius.circular(
                //                                               20),
                //                                     ),
                //                                     height: w * 0.06,
                //                                     width: w * 0.19,
                //                                     child: Padding(
                //                                       padding: const EdgeInsets
                //                                           .symmetric(
                //                                           horizontal: 8.0),
                //                                       child: Row(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .spaceBetween,
                //                                         children: [
                //                                           Text(
                //                                             "Active",
                //                                             style: TextStyle(
                //                                               color:
                //                                                   Colors.white,
                //                                               fontSize: 8.sp,
                //                                             ),
                //                                           ),
                //                                           Icon(
                //                                             Icons
                //                                                 .arrow_drop_down,
                //                                             color: Colors.white,
                //                                             size: 17,
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                               // SizedBox(height: 5),
                //                               Text(
                //                                 '${client.email}',
                //                                 style: TextStyle(
                //                                     fontSize: 10,
                //                                     color: Colors.black),
                //                               ),
                //                               SizedBox(height: 5),
                //                               // Container(
                //                               //   decoration: BoxDecoration(
                //                               //     color: Color(0xffffffff),
                //                               //     borderRadius:
                //                               //         BorderRadius.circular(20),
                //                               //   ),
                //                               //   height: w * 0.06,
                //                               //   width: w * 0.19,
                //                               //   child: Padding(
                //                               //     padding: const EdgeInsets
                //                               //         .symmetric(
                //                               //         horizontal: 8.0),
                //                               //     child: Row(
                //                               //       mainAxisAlignment:
                //                               //           MainAxisAlignment
                //                               //               .spaceAround,
                //                               //       children: [
                //                               //         Icon(
                //                               //           Icons.star,
                //                               //           color: Colors.yellow,
                //                               //           size: 15,
                //                               //         ),
                //                               //         Expanded(
                //                               //           child: ListView.builder(
                //                               //               shrinkWrap: true,
                //                               //               itemCount:
                //                               //                   client
                //                               //                   .id
                //                               //                   .length,
                //                               //               itemBuilder:
                //                               //                   (BuildContext
                //                               //                           context,
                //                               //                       int index) {
                //                               //                 return Text(
                //                               //                   '${state.user.tutorRateDetails[index].tutorRate}',
                //                               //                   style:
                //                               //                       TextStyle(
                //                               //                     color: Colors
                //                               //                         .black,
                //                               //                     fontSize:
                //                               //                         10.sp,
                //                               //                   ),
                //                               //                 );
                //                               //               }),
                //                               //         ),
                //                               //       ],
                //                               //     ),
                //                               //   ),
                //                               // ),
                //                               Text(
                //                                 "Invite a friend to WiseFox and get ₹20",
                //                                 style: TextStyle(fontSize: 11),
                //                               ),
                //                               SizedBox(height: 10),
                //                               DottedBorderContainer(),
                //                             ],
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               );
                //               // return ListTile(
                //               //   contentPadding:
                //               //       EdgeInsets.symmetric(horizontal: w * 0.02),
                //               //   leading: CircleAvatar(
                //               //     radius: w * 0.08,
                //               //     backgroundImage: NetworkImage(client
                //               //         .clientPhoto), // Load image from URL
                //               //     backgroundColor: Colors.grey[200],
                //               //   ),
                //               //   title: Text(
                //               //     client.firstName,
                //               //     style: TextStyle(
                //               //       color: Colors.black,
                //               //       fontWeight: FontWeight.bold,
                //               //       fontSize: 11.sp,
                //               //     ),
                //               //   ),
                //               //   subtitle: Text(
                //               //     client.email,
                //               //     maxLines: 1,
                //               //     overflow: TextOverflow.ellipsis,
                //               //     style: TextStyle(fontSize: 8.sp),
                //               //   ),
                //               // trailing: Container(
                //               //   decoration: BoxDecoration(
                //               //     color: Color(0xff48BA6F),
                //               //     borderRadius: BorderRadius.circular(20),
                //               //   ),
                //               //   // height: h * 0.04,
                //               //   width: w * 0.24,
                //               //   child: Padding(
                //               //     padding: EdgeInsets.only(
                //               //         top: 6, bottom: 6, left: 2, right: 1),
                //               //     child: Row(
                //               //       mainAxisAlignment:
                //               //           MainAxisAlignment.spaceEvenly,
                //               //       children: [
                //               //         Text(
                //               //           "Active",
                //               //           style: TextStyle(
                //               //             color: Colors.white,
                //               //             fontSize: 11.sp,
                //               //           ),
                //               //         ),
                //               //         SizedBox(width: w * 0.01),
                //               //         Icon(
                //               //           Icons.arrow_drop_down,
                //               //           color: Colors.white,
                //               //         ),
                //               //       ],
                //               //     ),
                //               //   ),
                //               // ),
                //               // );
                //             } else {
                //               return Center(
                //                   child: Text('No student data available'));
                //             }
                //           } else if (state is ClientError) {
                //             return Center(
                //                 child: Text('Error: ${state.message}'));
                //           }
                //           return Center(child: Text('No data'));
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 16),
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
                          SvgPicture.asset("assets/client/icons/person rounded.svg")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BillsHistoryPage(),
                        ));
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                  title: Text(
                    "Billing History",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Payouts",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Color(0xff8994A0),
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                      child: SvgPicture.asset("assets/client/icons/billing.svg")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Security(),
                        ));
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                  title: Text(
                    "Security",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Login history",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Color(0xff8994A0),
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                      child: SvgPicture.asset("assets/client/icons/secuirity.svg")),
                ),
                Divider(
                  color: Color(0x26AEAEAE),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time Zone",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        DropdownButton<String>(
                          iconSize: 0,
                          elevation: 0,
                          underline: SizedBox.shrink(),
                          value: _selectedItem,
                          hint: Text("Select Timezone"),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue!;
                              // context
                              //     .read<UserBloc>()
                              //     .add(UpdateTimezoneEvent(_selectedItem));
                              saveTimezone(_selectedItem!);
                            });
                          },
                          items: _availableTimeZones
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Color(0xff8994A0),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black, // Optional: adjust color if needed
                    ),
                  ],
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
                        child: SvgPicture.asset("assets/client/icons/headphones.svg")),
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
                      "About WiseFox",
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
                // ListTile(
                //   onTap: () {
                //     _showLogoutDialog(context);
                //   },
                //   contentPadding:
                //       EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                //   trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04),
                //   title: Text(
                //     "Logout",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 12.sp,
                //         fontWeight: FontWeight.w500),
                //   ),
                //   leading: CircleAvatar(
                //     backgroundColor: theColors.tabbarclr.withOpacity(0.5),
                //     child: Icon(
                //       Icons.logout,
                //       size: 16,
                //       color: Color(0xff616161),
                //     ),
                //   ),
                // ),
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
                              Navigator.pop(context);
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
                              //AppUtils.clearStudent();

                              BlocProvider.of<AuthBloc>(context)
                                  .add(LogoutButtonPressed(context));

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

  // void _showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Stack(
  //         children: [
  //           Positioned.fill(
  //             child: BackdropFilter(
  //               filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  //               child: Container(),
  //             ),
  //           ),
  //           Center(
  //             child: AlertDialog(
  //               title: Column(
  //                 children: [
  //                   Text(
  //                     "Log out",
  //                     style: TextStyle(
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   SizedBox(height: 10),
  //                   Text(
  //                     "Are you sure you want to logout?",
  //                     style: TextStyle(
  //                       fontSize: 13.sp,
  //                       color: Colors.grey[700],
  //                     ),
  //                   ),
  //                   SizedBox(height: 20),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Expanded(
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: Container(
  //                             height: w * 0.10,
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 top: BorderSide(
  //                                   width: w * 0.002,
  //                                   color: theColors.tabbarclr.withOpacity(0.5),
  //                                 ),
  //                                 right: BorderSide(
  //                                   width: w * 0.002,
  //                                   color: theColors.tabbarclr.withOpacity(0.5),
  //                                 ),
  //                               ),
  //                             ),
  //                             alignment: Alignment.center,
  //                             child: Text(
  //                               "Cancel",
  //                               style: TextStyle(
  //                                   color: theColors.textgrey,
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.w600),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: BlocListener<AuthBloc, AuthState>(
  //                           listener: (context, state) {
  //                             if (state is LogoutSuccess) {
  //                               ScaffoldMessenger.of(context).showSnackBar(
  //                                 SnackBar(content: Text('Logout success')),
  //                               );
  //                               Navigator.pushAndRemoveUntil(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: (context) => UnifiedLoginPage(),
  //                                 ),
  //                                     (route) => false,
  //                               );
  //                             } else if (state is PrepFailure) {
  //                               ScaffoldMessenger.of(context).showSnackBar(
  //                                 SnackBar(
  //                                     content: Text(
  //                                         'Logout failed: ${state.error}')),
  //                               );
  //                             }
  //                           },
  //                           child: InkWell(
  //                             onTap: () {
  //                               AppUtils.clearTutor();
  //
  //                               context
  //                                   .read<AuthBloc>()
  //                                   .add(LogoutButtonPressed(context));
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => UnifiedLoginPage()));
  //                             },
  //                             child: Container(
  //                               height: w * 0.10,
  //                               decoration: BoxDecoration(
  //                                 border: Border(
  //                                   top: BorderSide(
  //                                     width: w * 0.001,
  //                                     color: theColors.tabbarclr,
  //                                   ),
  //                                 ),
  //                               ),
  //                               alignment: Alignment.center,
  //                               child: Text(
  //                                 "Yes",
  //                                 style: TextStyle(
  //                                     color: Color(0xff1E3A6E),
  //                                     fontSize: 14.sp,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               contentPadding:
  //                   EdgeInsets.symmetric(vertical: 20, horizontal: 24),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               backgroundColor: Colors.white,
  //               elevation: 0,
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

class DottedBorderContainer extends StatelessWidget {
  // Fetch the referral code from SharedPreferences
  Future<String> _getReferralCode() async {
    var logindata = await SharedPreferencesHelper.getData('loginData');
    return logindata["referralcode"] ?? 'No Code'; // Default if null
  }

  // Copy referral code to clipboard
  void _copyToClipboard(BuildContext context, String referralCode) {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Referral code copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.56,
      height: h * 0.03,
      decoration: BoxDecoration(),
      child: CustomPaint(
        painter: DottedBorderPainter(),
        child: FutureBuilder<String>(
          future: _getReferralCode(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show a loader while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String referralCode = snapshot.data ?? 'No Code';
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Copy your code',
                        style: TextStyle(fontSize: 6, color: Colors.black),
                      ),
                    ),
                  ),
                  // Make referral code clickable
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _copyToClipboard(
                          context, referralCode), // Copy code on tap
                      child: Text(
                        referralCode, // Display referral code here
                        style: TextStyle(
                          fontSize: 7,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration
                              .underline, // Optional: underline to indicate clickability
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: h * 0.03,
                      width: w * 0.02,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Invite',
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashWidth = 5.0;
    final dashSpace = 5.0;
    final borderRadius = 10.0; // Adjust this value for desired border radius

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // Draw dashed border along the path
    final path = Path()..addRRect(rrect);
    final dashPath = _createDashPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashPath(Path source, double dashWidth, double dashSpace) {
    final dashPath = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final start = distance;
        final end = distance + dashWidth;
        dashPath.addPath(
          pathMetric.extractPath(start, end),
          Offset.zero,
        );
        distance = end + dashSpace;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
