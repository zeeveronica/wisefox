
import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeeAllLessons extends StatefulWidget {
  const SeeAllLessons({super.key});

  @override
  State<SeeAllLessons> createState() => _SeeAllLessonsState();
}

class _SeeAllLessonsState extends State<SeeAllLessons>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

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
          "All Lessons",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/client/images/pagebackground.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7),
              BlendMode.lighten,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: w * 0.15,
              child: Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (i) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _tabController.animateTo(i);
                              });
                            },
                            child: Container(
                              height: w * 0.09,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: _tabController.index == i
                                    ? Color(0xffCACAD9)
                                    : Color(0xffFAFBFD),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  i == 0
                                      ? 'Today(6)'
                                      : i == 1
                                          ? 'Tomorrow(8)'
                                          : '26 Aug (6)',
                                  style: TextStyle(
                                      color: _tabController.index == i
                                          ? Colors.black
                                          : Colors.black,
                                      fontWeight: _tabController.index == i
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      fontSize: 10.sp),
                                ),
                              ),
                            ),
                          ),
                          if (i != 4)
                            Container(
                              height: w * 0.02,
                              width: 16.0,
                              color: Color(0xffFAFBFD),
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.all(w * 0.03),
                    child: ListView.builder(
                      itemCount: 20,
                      padding: EdgeInsets.only(top: w * 0.08),
                      itemBuilder: (context, index) {
                        return Align(
                          heightFactor: 0.68,
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Container(
                                  height: w * 0.43,
                                  width: w * 1,
                                ),
                                Positioned(
                                  top: w * 0.07,
                                  child: Container(
                                    height: w * 0.32,
                                    width: w * 0.94,
                                    decoration: BoxDecoration(
                                        color: theColors.classclr,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(w * 0.03),
                                          bottomLeft: Radius.circular(w * 0.03),
                                          bottomRight:
                                              Radius.circular(w * 0.03),
                                        ),
                                        border: Border.all(
                                            width: w * 0.003,
                                            color: theColors.classbrdrclr)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: w * 0.03,
                                        top: w * 0.03,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: w * 0.04,
                                              ),
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    theimage.profilepc),
                                              ),
                                              Text(
                                                "  Tutor: Reshma Nair",
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: w * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: theColors.white,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff9C5633),
                                                            width: w * 0.001),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    w * 0.05)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          w * 0.005),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: w *
                                                                        0.003),
                                                            child: Icon(
                                                              Icons
                                                                  .access_time_outlined,
                                                              size: w * 0.03,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: w * 0.01,
                                                          ),
                                                          Text(
                                                            "10:00 AM - 11:00 AM",
                                                            style: TextStyle(
                                                                fontSize: 8.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "  Duration: 1 hr",
                                                    style: TextStyle(
                                                        fontSize: 9.sp),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: theColors
                                                              .white,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xffDDDDDD)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(w *
                                                                      0.05)),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            w * 0.003),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            SizedBox(
                                                              width: w * 0.002,
                                                            ),
                                                            Center(
                                                              child: Container(
                                                                height:
                                                                    w * 0.04,
                                                                width: w * 0.04,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(w *
                                                                              0.09),
                                                                  color: Color(
                                                                      0x2000A276),
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: w *
                                                                        0.025,
                                                                    width: w *
                                                                        0.025,
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/client/images/Group 7965.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: w * 0.01,
                                                            ),
                                                            Text(
                                                              "Join Now",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      8.sp),
                                                            ),
                                                            SizedBox(
                                                              width: w * 0.01,
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    height: w * 0.0735,
                                    width: w * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(w * 0.15),
                                          topRight: Radius.circular(w * 0.15)),
                                      color: theColors.classclr,
                                      border: Border(
                                          top: BorderSide(
                                              width: w * 0.003,
                                              color: theColors.classbrdrclr),
                                          left: BorderSide(
                                              width: w * 0.003,
                                              color: theColors.classbrdrclr),
                                          right: BorderSide(
                                              width: w * 0.003,
                                              color: theColors.classbrdrclr)),
                                    ),
                                    child: FittedBox(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: w * 0.014),
                                        child: Text(
                                          "Mathematics",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 09.sp,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
