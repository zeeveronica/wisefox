import 'package:wisefox/affiliate/bloc/bloc/lessons_bloc.dart';
import 'package:wisefox/main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String count;
  final String label;

  const CustomCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.count,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Container(
              child: Icon(icon, color: Colors.white),
              // height: h * 0.05,
              width: w * 0.06,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(label, style: TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ],
      ),
      width: w * 0.28,
      height: w * 0.16,
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
  void initState() {
    super.initState();
    // context.read<StudentsBloc>().add(FetchStudentCount());
  }

  @override
  Widget build(BuildContext context) {
    return
        // BlocBuilder<StudentsBloc, StudentsState>(
        //   builder: (context, state) {
        //     if (state is CalendarInitial) {
        //       return Center(child: Text('Please select an option.'));
        //     } else if (state is CalendarLoading) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (state is CalendarLoaded) {
        //       final data = state.response.data;
        //       return
        Row(
      children: [
        CustomCard(
          icon: Icons.people,
          iconColor: Color(0xff56AAC2),
          backgroundColor: Color(0xff7FD9FF),
          count: "",
          // data.client.toString(),
          label: "Clients",
        ),
        SizedBox(width: w * 0.02),
        GestureDetector(
          onTap: () {
            // Navigate to MyStudents page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MyStudents(),
            //   ),
            // );
          },
          child: CustomCard(
            icon: Icons.people,
            iconColor: Color(0xffCCAA3E),
            backgroundColor: Color(0xffF5D87C),
            count: "",
            //  data.student.toString(),
            label: "Student",
          ),
        ),
        SizedBox(width: w * 0.02),
        Expanded(
          child: CustomCard(
            icon: Icons.monetization_on,
            iconColor: Color(0xff63BD82),
            backgroundColor: Color(0xff86D963),
            count: "₹566",
            label: "Payment \n Amount",
          ),
        ),
      ],
    );
    //     } else if (state is CalendarError) {
    //       return Center(child: Text('Error: ${state.message}'));
    //     }
    //     return Container();
    //   },
    // );
  }
}

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
          image: AssetImage("assets/affiliate/images/slider.png"),
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
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: w * 0.06,
              width: w * 0.23,
              child: const Center(
                child: Text(
                  "Refer now",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveAllocationsContainer extends StatefulWidget {
  final Color circleColor;
  final String imagePath;
  final String title;
  final String count;

  const ActiveAllocationsContainer({
    Key? key,
    required this.circleColor,
    required this.imagePath,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  State<ActiveAllocationsContainer> createState() =>
      _ActiveAllocationsContainerState();
}

class _ActiveAllocationsContainerState
    extends State<ActiveAllocationsContainer> {
  void initState() {
    super.initState();
    // context.read<AllocationsBloc>().add(LoadAllocations());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: w * 0.17,
            width: w * 0.44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: w * 0.03,
                  ),
                  Expanded(
                    child: Text(
                      widget.count,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: w * 0.31,
            top: w * 0.0678,
            child: CircleAvatar(
              radius: 26,
              backgroundColor: widget.circleColor,
              child: Image(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.cover,
                height: w * 0.05,
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveAllocationsRow extends StatefulWidget {
  const ActiveAllocationsRow({
    Key? key,
  }) : super(key: key);

  @override
  State<ActiveAllocationsRow> createState() => _ActiveAllocationsRowState();
}

class _ActiveAllocationsRowState extends State<ActiveAllocationsRow> {
  void initState() {
    super.initState();
    // context.read<AllocationsBloc>().add(LoadAllocations());
  }

  @override
  Widget build(BuildContext context) {
    return
        //  BlocBuilder<AllocationsBloc, ClassesState>(
        //   builder: (context, state) {
        //     if (state is ClassesLoading) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (state is AllocationsLoaded) {
        //       final allocationsData = state.allocationsData;
        //       return
        Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ActiveAllocationsContainer(
                circleColor: const Color(0x40F7CACF),
                imagePath: "assets/affiliate/images/userstotal.png",
                title: "Total Leads",
                count: "10",
                // allocationsData.activeAllocations.toString(),
              ),
            ),
            Expanded(
              child: ActiveAllocationsContainer(
                circleColor: const Color(0x40FEEFC5),
                imagePath: "assets/affiliate/images/totalleads.png",
                title: "My Refer",
                count: "10",
                //  allocationsData.allocatedStudent.toString(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ActiveAllocationsContainer(
                circleColor: const Color(0xFFFEF8EB),
                imagePath: "assets/affiliate/images/refer-arrow.png",
                title: "Total Leads",
                count:
                    "2.0 hrs", // If you have data for this, update accordingly
              ),
            ),
            Expanded(
              child: ActiveAllocationsContainer(
                circleColor: const Color(0x40D1E8C7),
                imagePath: "assets/affiliate/images/income.png",
                title: "Total Payload",
                count: "£ 30",
                //  allocationsData.cancelledAllocations.toString(),
              ),
            ),

          ],
        ),
        
      ],
    );
    //   } else if (state is ClassesError) {
    //     return Center(child: Text('Error: ${state.message}'));
    //   } else {
    //     return Center(child: Text('No Data Available'));
    //   }
    // },
    // );
  }
}
