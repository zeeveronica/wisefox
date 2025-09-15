import 'package:wisefox/client/features/screens/chat_page.dart';
import '../../apps/utils/thecolors.dart';
import '../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StudentMessage extends StatelessWidget {
  StudentMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Messages",
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: w * 0.04, left: w * 0.04, right: w * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w * 0.79,
                    // height: w * 0.12,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: w * 0.002, color: theColors.tabbarclr),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(w * 0.09),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search...",
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: Color(0xffA4AAAF)),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: w * 0.01),
                          child: Icon(Icons.search,
                              size: 25, color: Color(0xffA4AAAF)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: w * 0.12,
                    width: w * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(w * 0.09),
                      color: Color(0xffE7ECF8),
                    ),
                    child: Center(
                        child: SvgPicture.asset("assets/client/icons/save.svg")),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: w * 0.04,
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Expanded(
              child: Container(
                width: w * 1,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                                bottom: BorderSide(
                                    color: theColors.tabbarclr,
                                    width: w * 0.003))),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Michael Scott",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffF9FAF5).withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(w * 0.03)),
                                    child: Center(
                                        child: Text(
                                      "Tutor",
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Color(0xff00008B)),
                                    )),
                                    height: h * 0.02,
                                    width: w * 0.13,
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: w * 0.011,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              color: theColors.textgrey,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          "As a web designer your role is crucial in creating...",
                                        ),
                                        SizedBox(
                                          height: w * 0.011,
                                        ),
                                        Text(
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                color: theColors.textgrey),
                                            "13 oct 2022,Mon |  6:00 am."),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: const CircleAvatar(
                                radius: 23,
                                backgroundImage: AssetImage(theimage.profilepc),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
