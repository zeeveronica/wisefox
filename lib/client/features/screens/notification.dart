import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isExpanded1 = true;
  bool isExpanded2 = true;

  @override
  void initState() {
    super.initState();
    isExpanded1 = true;
    isExpanded2 = true;
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Ensure this is set correctly
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bottomnav(initialIndex: 2),
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text("Notifications", style: TextStyle(color: Colors.white)),
        backgroundColor: theColors.primaryColor,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: w * 0.03),
              Text('25 Notifications',
                  style: TextStyle(fontSize: 14.sp, color: Colors.black)),
              ExpansionTile(
                trailing: Text("Mark as read",
                    style: TextStyle(fontSize: 10, color: Color(0xff080557))),
                iconColor: Colors.transparent,
                collapsedIconColor: Colors.transparent,
                shape: Border(),
                initiallyExpanded: isExpanded1,
                title: Row(
                  children: [
                    Text('New Notification', style: TextStyle(fontSize: 12)),
                    Icon(
                      isExpanded1
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                  ],
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isExpanded1 = expanded);
                },
                children: <Widget>[
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: theColors.tabbarclr.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: w,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Stack(
                                      children: [
                                        Container(
                                          height: h * 0.15,
                                          width: w * 0.15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  theimage.profilepc),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 11,
                                              backgroundColor:
                                                  Color(0xffF9C529),
                                              child: Icon(Icons.notifications,
                                                  size: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    title: Text("Reshma Nair Allocated",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                        "Mathematics - 01:00 PM - 02:30 PM",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey)),
                                    trailing: Text("09:35",
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                trailing: Text("Mark as read",
                    style: TextStyle(fontSize: 10, color: Color(0xff080557))),
                iconColor: Colors.transparent,
                collapsedIconColor: Colors.transparent,
                shape: Border(),
                initiallyExpanded: isExpanded2,
                title: Row(
                  children: [
                    Text('Earlier Notification',
                        style: TextStyle(fontSize: 12)),
                    Icon(
                      isExpanded2
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                  ],
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isExpanded2 = expanded);
                },
                children: <Widget>[
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: theColors.tabbarclr.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: w,
                              child: ListTile(
                                leading: Stack(
                                  children: [
                                    Container(
                                      height: h * 0.15,
                                      width: w * 0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(theimage.profilepc),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: w * 0.028,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 11,
                                          backgroundColor: Color(0xffF9C529),
                                          child: Icon(Icons.notifications,
                                              size: 15, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text("Arun Nair Allocated",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Mathematics - 01:00 PM - 02:30 PM",
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.grey)),
                                trailing: const Text("09:35",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.black)),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
