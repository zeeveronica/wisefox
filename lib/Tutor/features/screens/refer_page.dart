
import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferNowContainer extends StatelessWidget {
  const ReferNowContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: w * 0.28,
      width: w * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/client/images/Group 7903.png"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: w * 0.17,
            width: w * 0.07,
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.03, top: w * 0.02),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: w * 0.06,
              width: w * 0.23,
              child: Center(
                child: Text(
                  "Refer now",
                  style:
                      TextStyle(fontSize: 10.sp, color: theColors.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
