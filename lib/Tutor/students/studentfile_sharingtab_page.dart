import 'package:wisefox/client/features/screens/Tabbar_page_share.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/recieved_files.dart';
import 'package:wisefox/client/students/studentsentedfile_page.dart';
import 'package:flutter/material.dart';

class StudentFileSharingPage extends StatelessWidget {
  const StudentFileSharingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theColors.primaryColor,
          title: Text(
            "File Sharing",
            style: TextStyle(color: theColors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  theimage.pagebackground,
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.7),
                  colorBlendMode: BlendMode.lighten,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: w * 0.03),
                  PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(w * 0.09)),
                        color: Color(0xffE7ECF8).withOpacity(0.5),
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: theColors.primaryColor,
                            width: 1.0,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(w * 0.09)),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: theColors.textgrey,
                        tabs: [
                          TabbarPageshare(
                            title: "Received Files",
                          ),
                          TabbarPageshare(
                            title: "Sent Files",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: w * 0.03),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        StudentRecievedFilesPage(),
                        StudentSentFilePage(),
                      ],
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
