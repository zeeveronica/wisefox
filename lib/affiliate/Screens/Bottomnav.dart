import 'package:wisefox/affiliate/Screens/Homepage.dart';
import 'package:wisefox/affiliate/Screens/Leadspage.dart';
import 'package:wisefox/affiliate/Screens/MyAccount.dart';
import 'package:wisefox/main.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Bottomnav extends StatefulWidget {
  final int initialIndex;

  Bottomnav({this.initialIndex = 0});

  @override
  _BottomnavState createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(left: w * 0.04, right: w * 0.04, bottom: w * 0.04),
        child: ClipPath(
          clipper: RoundedRectangleClipper(radius: 30.0),
          child: CurvedNavigationBar(
            index: _currentIndex,
            height: 56.0,
            items: <Widget>[
              _buildNavItem(
                  _currentIndex == 0
                      ? 'assets/affiliate/images/Leadsdark.svg'
                      : "assets/affiliate/images/Leadslight.svg",
                  "Leads",
                  0),
              _buildNavItem(
                  _currentIndex == 1
                      ? 'assets/affiliate/images/Homedark.svg'
                      : 'assets/affiliate/images/Homelight.svg',
                  "Home",
                  1),
              _buildNavItem(
                  _currentIndex == 2
                      ? 'assets/affiliate/images/accountdark.svg'
                      : "assets/affiliate/images/accountlight.svg",
                  "Account",
                  2),
            ],
            color: Color(0xff080557),
            buttonBackgroundColor: Colors.transparent,
            backgroundColor: Colors.white,
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
          color: isSelected ? Color(0xff080557) : Color(0xff7F8897),
          width: 20,
          height: 20,
        ),
        // Color(0xff8591A5),
        SizedBox(
          height: w * 0.01,
        ),
        if (!isSelected)
          Text(
            label,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Color(0xff7F8897),
              // Color(0xff8591A5),
              fontSize: 8.sp,
            ),
            maxLines: 1,
          ),
      ],
    );
  }

  final List<Widget> _pages = [
    Leadspage(),
    Homepage(),
    Myaccount(),
  ];
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
