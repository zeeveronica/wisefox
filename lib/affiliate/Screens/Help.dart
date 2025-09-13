import 'package:wisefox/main.dart';
import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluedark,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Help Center",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/affiliate/images/baground3.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.5), BlendMode.colorDodge))),
        child: ListView(
          children: const [
            ExpansionTile(
              shape: Border(),
              title: Text(
                'Getting Started',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  title: Text(
                    'How to create an account',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  subtitle: Text(
                    'Step-by-step guide on account creation.',
                    style: TextStyle(color: AppColors.textgrey, fontSize: 11),
                  ),
                ),
                ListTile(
                  title: Text(
                    'How to navigate the app',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  subtitle: Text(
                    'Basic navigation tips and tricks.',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              shape: Border(),
              title: Text(
                'Troubleshooting',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Common issues and fixes',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  subtitle: Text(
                    'Resolve common problems with the app.',
                    style: TextStyle(color: AppColors.textgrey, fontSize: 11),
                  ),
                ),
                ListTile(
                  title: Text('Contact support',
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  subtitle: Text(
                    'How to get in touch with support.',
                    style: TextStyle(color: AppColors.textgrey, fontSize: 11),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              shape: Border(),
              title: Text(
                'Advanced Features',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Using advanced settings',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  subtitle: Text(
                    'Learn about advanced features.',
                    style: TextStyle(color: AppColors.textgrey, fontSize: 11),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Customizing your experience',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  subtitle: Text(
                    'Tips on personalizing the app.',
                    style: TextStyle(color: AppColors.textgrey, fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
