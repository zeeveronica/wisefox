import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wisefox/student/features/screens/login_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theicons.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';

class GetstartPage extends StatefulWidget {
  const GetstartPage({super.key});

  @override
  _GetstartPageState createState() => _GetstartPageState();
}

class _GetstartPageState extends State<GetstartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 17.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(theimage.backgroundimg),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: w * 0.14,
                ),
                Container(
                  width: w,
                  height: w * 0.8,
                  child: Image.asset(
                    theimage.getstartimg,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  theimage.logo,
                  alignment: Alignment.topCenter,
                  height: w * 0.15,
                  width: w * 0.3,
                ),
                Column(
                  children: [
                    Text(
                      "Find Your",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Perfect Tutor",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and",
                  style: TextStyle(fontSize: 9.sp, color: theColors.textgrey),
                ),
                Text(
                  "typesetting industry.",
                  style: TextStyle(fontSize: 9.sp, color: theColors.textgrey),
                ),
                SizedBox(
                  height: w * 0.10,
                ),
                Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color(0xff959595),
                      BlendMode.srcIn,
                    ),
                    child: Lottie.asset(
                      'assets/student/lottie/Animation - 1723019843227.json',
                      height: w * 0.08,
                      width: w * 0.09,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                Text("Get Started"),
                SizedBox(
                  height: w * 0.04,
                ),
                GestureDetector(
                  onVerticalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! < 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else if (details.primaryVelocity! > 0) {}
                  },
                  child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_animation.value),
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(theicons.getstrtButton)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
