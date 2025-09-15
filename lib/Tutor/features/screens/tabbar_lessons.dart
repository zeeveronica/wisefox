import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsTabbar extends StatelessWidget {
  final String title;
  const LessonsTabbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          title,
          style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ]),
    );
  }
}
