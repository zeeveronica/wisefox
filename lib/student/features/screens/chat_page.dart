import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wisefox/student/features/screens/bottom_nav.dart';
import 'package:wisefox/student/features/utils/thecolors.dart';
import 'package:wisefox/student/features/utils/theimage.dart';
import 'package:wisefox/main.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theColors.white,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => Bottomnav(
            //         initialIndex: 3,
            //       ),
            //     ));
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: w * 0.04,
              backgroundImage: AssetImage(theimage.profilepc),
            ),
            SizedBox(
              width: w * 0.03,
            ),
            Text(
              "Reshma Nair",
              style: TextStyle(color: theColors.white, fontSize: 14.sp),
            ),
          ],
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
                SizedBox(height: w * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: w * 0.15,
                        endIndent: w * 0.02,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      child: Text(
                        "13 Oct 2022",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: theColors.textgrey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: w * 0.02,
                        endIndent: w * 0.15,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: w * 0.03),
                Row(
                  children: [
                    CircleAvatar(
                      radius: w * 0.05,
                      backgroundImage: AssetImage(theimage.profilepc),
                    ),
                    SizedBox(width: w * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reshma Nair",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "1m ago",
                          style: TextStyle(fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: w * 0.03),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9FC),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(w * 0.05),
                      bottomLeft: Radius.circular(w * 0.05),
                      bottomRight: Radius.circular(w * 0.05),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.03),
                    child: Text(
                      "Lorem Ipsum is simply dummy\ntext of the printing",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: w * 0.03),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9FC),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(w * 0.05),
                      bottomLeft: Radius.circular(w * 0.05),
                      bottomRight: Radius.circular(w * 0.05),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.03),
                    child: Text(
                      "Just let me know!",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: w * 0.03),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: w * 0.05,
                            backgroundImage: AssetImage(theimage.getstartimg),
                          ),
                          SizedBox(width: w * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Me",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Just Now",
                                style: TextStyle(fontSize: 9.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: w * 0.03),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF9F9FC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w * 0.05),
                            bottomLeft: Radius.circular(w * 0.05),
                            bottomRight: Radius.circular(w * 0.05),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(w * 0.03),
                          child: Text(
                            "Lorem Ipsum is simply dummy\ntext of the printing ",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: w * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.rotate(
                            angle: 0.7,
                            child: Icon(
                              Icons.attach_file_outlined,
                              size: w * 0.04,
                              color: Color(0xff8994A0),
                            ),
                          ),
                          Text("Attachments")
                        ],
                      ),
                      SizedBox(height: w * 0.03),
                      Container(
                        width: w * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.03),
                          color: Color(0xffF9F9FC),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: w * 0.06,
                              backgroundColor: Color(0xffEA4335),
                              child: SvgPicture.asset(
                                "assets/student/icons/imgadd.svg",
                                fit: BoxFit.fill,
                              )),
                          title: Text(
                            "BT4521366458.jpg",
                            style: TextStyle(
                                color: Color(0xff363636), fontSize: 12.sp),
                          ),
                          subtitle: Text(
                            "200KB",
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xffABABAB)),
                          ),
                          trailing: Icon(
                            Icons.file_download_outlined,
                            color: Color(0xff707070),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Padding(
          padding: EdgeInsets.only(left: w * 0.03, bottom: w * 0.02),
          child: Row(
            children: [
              Container(
                height: w * 0.13,
                width: w * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.08),
                  color: Color(0xffF5F8FB),
                ),
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  // textAlign: TextAlign.center,
                  textInputAction: TextInputAction.send,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: TextStyle(fontSize: 11.sp),
                    suffixIcon: Icon(Icons.attach_file_outlined),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: w * 0.06, vertical: w * 0.02),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.03,
              ),
              Container(
                height: w * 0.13,
                width: w * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.09),
                    color: theColors.bottomnavColor),
                child: Center(
                    child: Container(
                        height: w * 0.05,
                        width: w * 0.05,
                        child:
                            SvgPicture.asset("assets/student/icons/share_right.svg"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
