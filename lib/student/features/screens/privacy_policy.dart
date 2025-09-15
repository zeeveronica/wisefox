import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
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
          padding: EdgeInsets.all(16.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Introduction\n',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'At Prep, we are committed to protecting the privacy and security of our users. This Privacy Policy outlines how we collect, use, and safeguard your information when you use our app.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '1. Information We Collect\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '- Personal Information: We collect personal details you provide, such as your name, email address, and the names and details of students using the app.\n'
                          '- Usage Data: We collect data about how you interact with the app, including your activities, preferences, and any errors or issues encountered.\n'
                          '- Device Information: We may collect information about the device you use to access Prep, including device type, operating system, and unique device identifiers.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '2. How We Use Your Information\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '- To Provide Services: We use your information to operate and enhance the app’s functionality, such as managing study schedules and tracking progress.\n'
                          '- To Communicate: We may use your contact information to send updates, notifications, and promotional materials related to Prep.\n'
                          '- To Improve Our Services: We analyze usage data to improve the app’s features and performance.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '3. Data Security\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We implement security measures to protect your data from unauthorized access, alteration, or disclosure. Despite our efforts, no online service can be completely secure, so we cannot guarantee absolute protection.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '4. Sharing Your Information\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We do not sell or rent your personal information to third parties. We may share information with service providers who assist us in operating the app, provided they comply with our privacy standards.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '5. Your Choices\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '- Access and Update: You can access and update your personal information through the app’s settings.\n'
                          '- Opt-Out: You can opt-out of receiving promotional communications by following the unsubscribe instructions in those communications.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '6. Changes to This Policy\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We may update this Privacy Policy from time to time. Any changes will be posted on this page, and we encourage you to review it periodically.\n\n',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    TextSpan(
                      text: '7. Contact Us\n',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'If you have any questions or concerns about this Privacy Policy, please contact us at support@prep.com.',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
