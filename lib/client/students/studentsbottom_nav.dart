import 'package:wisefox/client/features/screens/clientlessons_page.dart';
import '../../apps/utils/thecolors.dart';
import '../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/studentaccount.dart';
import 'package:wisefox/client/students/studentfile_sharingtab_page.dart';
import 'package:wisefox/client/students/studenthome_page.dart';
import 'package:wisefox/client/students/message_page.dart';
import 'package:wisefox/client/students/studentslessons_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StudentsBottomnav extends StatefulWidget {
  final int initialIndex;

  StudentsBottomnav({
    this.initialIndex = 2,
  });

  @override
  _StudentsBottomnavState createState() => _StudentsBottomnavState();
}

class _StudentsBottomnavState extends State<StudentsBottomnav> {
  late int _currentIndex;
  late List<Widget> _pages; // Make _pages a late variable

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    // Initialize _pages inside initState where widget is accessible
    _pages = [
      StudentsLessonsPage(),
      StudentFileSharingPage(),
      StudentsHomePage(),
      StudentMessage(),
      Studentaccount(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: w * 0.03, left: w * 0.03),
        child: ClipPath(
          clipper: RoundedRectangleClipper(radius: 30.0),
          child: CurvedNavigationBar(
            index: _currentIndex,
            height: 60.0,
            items: <Widget>[
              _buildNavItem(
                  _currentIndex == 0
                      ? 'assets/client/icons/calendar (7) (1).svg'
                      : "assets/client/icons/allocationslightff.svg",
                  "Lessons",
                  0),
              _buildNavItem(
                  _currentIndex == 1
                      ? 'assets/client/icons/sharefilled1.svg'
                      : 'assets/client/icons/up share.svg',
                  "File Sharing",
                  1),
              _buildNavItem(
                  _currentIndex == 2
                      ? 'assets/client/icons/homefilled.svg'
                      : "assets/client/icons/home.svg",
                  "Home",
                  2),
              _buildNavItem(
                  _currentIndex == 3
                      ? 'assets/client/icons/chatsvg.svg'
                      : 'assets/client/icons/chatoutlined.svg',
                  "Messages",
                  3),
              _buildNavItem(
                  _currentIndex == 4
                      ? 'assets/client/icons/Group 7936.svg'
                      : "assets/client/icons/persons.svg",
                  "My Account",
                  4),
            ],
            color: theColors.bottomnavColor,
            buttonBackgroundColor: Colors.transparent,
            backgroundColor: theColors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgPath, String label, int index) {
    bool isSelected = _currentIndex == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: w * 0.02,
        ),
        SvgPicture.asset(
          svgPath,
          color: isSelected ? Color(0xff080557) : Color(0xff8591A5),
          width: 20,
          height: 20,
        ),
        SizedBox(
          height: w * 0.01,
        ),
        if (!isSelected)
          Text(
            label,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Color(0xff8591A5),
              fontSize: 8.sp,
            ),
            maxLines: 1,
          ),
      ],
    );
  }
}

class RoundedRectangleClipper extends CustomClipper<Path> {
  final double radius;

  RoundedRectangleClipper({this.radius = 10.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(radius),
    ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
