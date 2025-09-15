// import 'package:wisefox/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomCard extends StatelessWidget {
//   final SvgPicture svgIcon;
//   final Color iconColor;
//   final Color backgroundColor;
//   final String count;
//   final String label;

//   const CustomCard({
//     Key? key,
//     required this.svgIcon,
//     required this.iconColor,
//     required this.backgroundColor,
//     required this.count,
//     required this.label,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: w * 0.08, // Adjust size of the container
//             width: w * 0.08,
//             decoration: BoxDecoration(
//               color: iconColor,
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//             ),
//             child: Center(
//               child: svgIcon, // SVG Icon will scale inside this container
//             ),
//           ),
//           SizedBox(
//             width: w * 0.02,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 count,
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     label,
//                     style: TextStyle(fontSize: 8.sp),
//                   ),
//                   Text(icon),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//       width: w * 0.3,
//       height: w * 0.17,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         border: Border.all(color: Colors.white),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OverviewRow extends StatefulWidget {
//   const OverviewRow({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<OverviewRow> createState() => _OverviewRowState();
// }

// class _OverviewRowState extends State<OverviewRow> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         CustomCard(
//           svgIcon: SvgPicture.asset(
//             'assets/client/icons/users-avatar.svg',
//             height: 15.h, // Set SVG height
//             width: 30.w, // Set SVG width
//             fit: BoxFit.cover,
//           ),
//           iconColor: Color(0xff56AAC2),
//           backgroundColor: Color(0xff7FD9FF),
//           count: "02",
//           label: "Clients",
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: CustomCard(
//             svgIcon: SvgPicture.asset(
//               'assets/client/icons/teacher.svg',
//               height: 15.h, // Set SVG height
//               width: 30.w, // Set SVG width
//               fit: BoxFit.cover,
//             ),
//             iconColor: Color(0xffCCAA3E),
//             backgroundColor: Color(0xffF5D87C),
//             count: "056",
//             label: "Student",
//           ),
//         ),
//         CustomCard(
//           svgIcon: SvgPicture.asset(
//             'assets/client/icons/usd-circle (1).svg',
//             height: 15.h, // Set SVG height
//             width: 30.w, // Set SVG width
//             fit: BoxFit.cover,
//           ),
//           iconColor: Color(0xff63BD82),
//           backgroundColor: Color(0xff86D963),
//           count: "566",
//           label: "Balance\ncredits",
//         ),
//       ],
//     );
//   }
// }
import 'package:wisefox/client/features/bloc/dashboard/dashboard_bloc.dart';
import 'package:wisefox/client/features/screens/mystudents.dart';
import 'package:wisefox/client/features/screens/tutor_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomCard extends StatelessWidget {
  final SvgPicture svgIcon;
  final Color iconColor;
  final Color backgroundColor;
  final String count;
  final String label;
  final Icon? trailingIcon; // Optional trailing icon

  const CustomCard({
    Key? key,
    required this.svgIcon,
    required this.iconColor,
    required this.backgroundColor,
    required this.count,
    required this.label,
    this.trailingIcon, // Initialize the optional icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: w * 0.08, // Adjust size of the container
            width: w * 0.08,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: svgIcon, // SVG Icon will scale inside this container
            ),
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 8.sp),
                  ),
                  if (trailingIcon != null) ...[
                    SizedBox(
                        width: 4.w), // Add some space between label and icon
                    trailingIcon!, // Display the optional icon
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
      width: w * 0.3,
      height: w * 0.17,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}

class OverviewRow extends StatefulWidget {
  const OverviewRow({
    Key? key,
  }) : super(key: key);

  @override
  State<OverviewRow> createState() => _OverviewRowState();
}

class _OverviewRowState extends State<OverviewRow> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return Center(
              child: CircularProgressIndicator(color: theColors.primaryColor));
        } else if (state is DashboardLoaded) {
          final dashboard = state.dashboardData;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyStudents(),
                      ));
                },
                child: CustomCard(
                  svgIcon: SvgPicture.asset(
                    'assets/client/icons/users-avatar.svg',
                    height: 15.h, // Set SVG height
                    width: 30.w, // Set SVG width
                    fit: BoxFit.cover,
                  ),
                  iconColor: Color(0xff56AAC2),
                  backgroundColor: Color(0xff7FD9FF),
                  count: "${dashboard.clientStudents}",
                  label: "Student",
                  trailingIcon: Icon(Icons.arrow_forward,
                      size: 11.sp, color: Color(0xff363636)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TutorPage(),
                      ));
                },
                child: CustomCard(
                  svgIcon: SvgPicture.asset(
                    'assets/client/icons/teacher.svg',
                    height: 15.h,
                    width: 30.w,
                    fit: BoxFit.cover,
                  ),
                  iconColor: Color(0xffCCAA3E),
                  backgroundColor: Color(0xffF5D87C),
                  count: "${dashboard.clientTutors}",
                  label: "Tutor",
                  trailingIcon: Icon(Icons.arrow_forward,
                      size: 11.sp, color: Color(0xff363636)),
                ),
              ),
              CustomCard(
                svgIcon: SvgPicture.asset(
                  'assets/client/icons/usd-circle (1).svg',
                  height: 15.h, // Set SVG height
                  width: 30.w, // Set SVG width
                  fit: BoxFit.cover,
                ),
                iconColor: Color(0xff63BD82),
                backgroundColor: Color(0xff86D963),
                count: "${dashboard.balanceCredits}",
                label: "Balance\ncredits",
              ),
            ],
          );
        } else if (state is DashboardError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          // return Center(child: Text('No data'));
          return Center(child: Text('Coming Soon'));
        }
      },
    );
  }
}
