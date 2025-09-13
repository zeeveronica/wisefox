import 'dart:developer';
import 'dart:ui';

import 'package:wisefox/affiliate/Screens/AddNewLead.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Leadspage extends StatefulWidget {
  const Leadspage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SentFilePageState createState() => _SentFilePageState();
}

class _SentFilePageState extends State<Leadspage> {
  List<bool> _expandedState = List.generate(10, (index) => false);

  @override
  void initState() {
    super.initState();
    List<bool> _expandedState = List.generate(10, (index) => false);
    // Set the initial expanded state to true
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluedark,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:
            Text("Leads", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Container(
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/affiliate/images/baground2.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.3), BlendMode.lighten),
        )),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Addnewlead(),
                      ));
                },
                child: Container(
                  width: w * 1,
                  height: w * 0.2,
                  decoration: BoxDecoration(
                    color: AppColors.divider.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomPaint(
                    painter: DottedBorderPainter(),
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.03,
                        ),
                        Container(
                          height: w * 0.13,
                          width: w * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff00008B),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/affiliate/images/Addbutton.svg",
                              height: w * 0.08,
                              width: w * 0.13,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add a Newlead',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Lorem Ipsum is simply dummy text of the',
                              style: TextStyle(
                                fontSize: 8.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Leads",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/affiliate/images/Leadsbutton.svg",
                        height: w * 0.04,
                      ),
                    ),
                    height: w * 0.10,
                    width: w * 0.10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.classbrdrclr),
                  )
                ],
              ),
              SizedBox(
                height: w * 0.06,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          // height: h * 0.16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xffDCE4F2))),
                          child: ExpansionTile(
                            trailing: InkWell(
                              onTap: () {
                                _showAlertDialog(context);
                              },
                              child: Container(
                                height: w * 0.09,
                                width: w * 0.24,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Color(0xffDCE4F2))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "View All",
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: const Color(0xff080557),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(w * 0.01),
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Color(0xff00A276).withOpacity(0.1),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 10,
                                          color: Color(0xff00A276),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            iconColor: Colors.transparent,
                            collapsedIconColor: Colors.transparent,
                            shape: const Border(),
                            initiallyExpanded: _expandedState[index],
                            title: Row(
                              children: [
                                Container(
                                  height: w * 0.15,
                                  width: w * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/affiliate/images/photo2.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: w * (0.01)),
                                          Text(
                                            'Maxi Thomas',
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              // Set a fixed height for the container to avoid overflow
                                              height: w *
                                                  0.05, // Adjst this value based on your layout
                                              width: w *
                                                  0.05, // Adjust this value if necessary
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffEFF0F0)),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  _expandedState[index]
                                                      ? Icons
                                                          .keyboard_arrow_up_outlined
                                                      : Icons
                                                          .keyboard_arrow_down_outlined,
                                                  color: Color(0xff000000),
                                                  size:
                                                      16.0, // You can adjust the icon size to fit properly
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: w * (0.02)),
                                        Text(
                                          'Active ',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          '|',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: AppColors.divider),
                                        ),
                                        Text(
                                          'Uk ',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onExpansionChanged: (bool expanded) {
                              setState(() => _expandedState[index] = expanded);
                            },
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Centers the Row itself
                                children: [
                                  SizedBox(width: w * (0.18)),
                                  SizedBox(
                                    width:
                                        30.0, // Fixed width to ensure alignment
                                    child: SvgPicture.asset(
                                      "assets/affiliate/images/envelope.svg",
                                      height: 10.0, // Adjust size of the icon
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          5.0), // Spacing between icon and text
                                  Text(
                                    "reshmanair@gmail.com",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight:
                                          FontWeight.w500, // Styling the text
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(width: w * (0.02)),
                              // Space between the two rows
                              // Second Row with phone icon and text
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Centers the Row itself
                                children: [
                                  SizedBox(width: w * (0.19)),
                                  SizedBox(
                                    width:
                                        20.0, // Same fixed width as the first row for alignment
                                    child: SvgPicture.asset(
                                      "assets/affiliate/images/phone.svg",
                                      height: 10.0, // Adjust size of the icon
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8.0), // Spacing between icon and text
                                  Text(
                                    "768767676776",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight:
                                          FontWeight.w500, // Styling the text
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: w * 0.06),
                            ],
                          ),
                        ),
                        SizedBox(height: w * 0.02),
                      ],
                    );
                  }),
              //     } else if (state is SendFileError) {
              //       return Center(child: Text(state.message));
              //     }
              //     return Container();
              //   },
              // ),
            ],
          ),
        )),
      ),
    );
  }
}

void _showAlertDialog(
  BuildContext context,
) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20.w),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15.w,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage("assets/affiliate/images/photo2.png"),
                              ),
                              SizedBox(height: 14.w),
                              Text(
                                "Richard vAlien",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5.w),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff48BA6F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: w * 0.08,
                                width: w * 0.19,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Active",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.sp,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.05,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ID",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "Email Id",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "Phone number",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "1st Rate",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "2nd Rate",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "Clients",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "3rd Rate",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          "Last Login",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ": 14322",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": reshmanair.gmail.com",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ":  8776665355",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11),
                                        ),
                                        Text(
                                          ": 00.0",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          ": 00.0",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          ": 00.0",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          ": 0",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          ": 10 months ago",
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 11.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))))
            ],
          ),
        );
      });
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff00008B)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(10), // Adjusted for consistency
      ));

    final dashWidth = 5;
    final dashSpace = 5;
    final totalLength =
        path.computeMetrics().fold(0.0, (sum, metric) => sum + metric.length);

    double distance = 0;

    while (distance < totalLength) {
      final metrics = path.computeMetrics();
      for (final metric in metrics) {
        final length = metric.length;
        if (distance >= length) {
          distance -= length;
          continue;
        }

        final startOffset = distance;
        final endOffset = distance + dashWidth;
        if (endOffset > length) {
          final extra = endOffset - length;
          distance = length;
          continue;
        }

        final startTangent = metric.getTangentForOffset(startOffset);
        final endTangent = metric.getTangentForOffset(endOffset);

        if (startTangent != null && endTangent != null) {
          canvas.drawLine(
            startTangent.position,
            endTangent.position,
            paint,
          );
        }
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
