import 'dart:developer';
import 'dart:ui';

import 'package:wisefox/client/features/bloc/sendfiles/send_files_bloc.dart';
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_bloc.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_event.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_state.dart';
import 'package:wisefox/client/features/model/studentsendfile.dart';
import 'package:wisefox/client/features/screens/open_recieved_file.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/studentsharefile_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class StudentSentFilePage extends StatefulWidget {
  const StudentSentFilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentSentFilePageState createState() => _StudentSentFilePageState();
}

class _StudentSentFilePageState extends State<StudentSentFilePage> {
  void initState() {
    super.initState();
    // Trigger the LoadReceivedFiles event to load the received files
    context.read<StudentSendFileBloc>().add(StudentLoadSendFiles());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      builder: (context) => StudentShareFilePage(),
                    ));
              },
              child: Container(
                width: w * 1,
                height: w * 0.15,
                decoration: BoxDecoration(
                  color: theColors.tabbarclr,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomPaint(
                  painter: DottedBorderPainter(),
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                    child: Row(
                      children: [
                        Container(
                          height: w * 0.13,
                          width: w * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theColors.primaryColor,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/client/icons/share.svg",
                              height: w * 0.08,
                              width: w * 0.08,
                              fit: BoxFit.contain,
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
                              'Share a File',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: w * 0.01,
                            ),
                            Text(
                              'Lorem Ipsum is simply dummy text',
                              style: TextStyle(
                                fontSize: 9.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Sent Files"),
            BlocBuilder<StudentSendFileBloc, StudentSendFileState>(
              builder: (context, state) {
                if (state is StudentSendFileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is StudentSendFileLoaded) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.studentsendFiles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final sendfile = state.studentsendFiles[index];
                      return Container(
                        margin: EdgeInsets.only(top: w * 0.03),
                        height: w * 0.35,
                        width: w * 1,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffE7ECF8), width: w * 0.003),
                          borderRadius: BorderRadius.circular(w * 0.02),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OpenRecievedFile(
                                        fileUrl: sendfile
                                            .file, // Pass the file URL to the next page
                                        receiverName: sendfile
                                            .receiver, // Pass other necessary data
                                        notes: sendfile.notes,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: SvgPicture.asset(
                                      "assets/client/icons/files.svg"),
                                  title: Text(
                                    "${sendfile.file}",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xff0EA5E9),
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(0xff0EA5E9),
                                      decorationThickness: 1.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Sender:${sendfile.sender}",
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      _showLogoutDialog(context, sendfile);
                                    },
                                    child: Container(
                                      height: w * 0.08,
                                      width: w * 0.08,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(w * 0.02),
                                        color: theColors.tabbarclr
                                            .withOpacity(0.5),
                                      ),
                                      child: Icon(
                                        Icons.delete_outline_outlined,
                                        color: theColors.textgrey,
                                        size: w * 0.04,
                                      ),
                                    ),
                                  ),
                                  onTap: null,
                                ),
                              ),
                            ),
                            Container(
                              height: w * 0.08,
                              width: w * 1,
                              decoration: BoxDecoration(
                                color: theColors.classclr,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(w * 0.02),
                                  bottomRight: Radius.circular(w * 0.02),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.05,
                                  ),
                                  SvgPicture.asset(
                                    "assets/client/icons/calendar (8).svg",
                                  ),
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  Text(
                                    _formatDate(sendfile.date),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: theColors.textgrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is StudentSendFileError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context, StudentSendfile sendfile) {
  // double h = ScreenUtil().screenHeight;
  // double w = ScreenUtil().screenWidth;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 9.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: AlertDialog(
              title: Column(
                children: [
                  Text(
                    "Are you sure you want to delete?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: w * 0.10,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: w * 0.001,
                              color: theColors.tabbarclr.withOpacity(0.8),
                            ),
                            right: BorderSide(
                              width: w * 0.001,
                              color: theColors.tabbarclr,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: theColors.textgrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<StudentSendFileBloc>().add(
                            StudentDeleteSendFile(
                                sendfile.id)); // Pass the file id
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: w * 0.10,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: w * 0.001,
                              color: theColors.tabbarclr,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              color: Color(0xff1E3A6E),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white.withOpacity(0.7),
              elevation: 0,
            ),
          ),
        ],
      );
    },
  );
  void _showLogoutDialog(BuildContext context, file) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(),
              ),
            ),
            Center(
              child: AlertDialog(
                title: Column(
                  children: [
                    Text(
                      "Are you sure you want to delete ?",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: w * 0.10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                  right: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: theColors.textgrey,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<StudentSendFileBloc>()
                                  .add(StudentDeleteSendFile(file.id));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('File deleted successfully')),
                              );
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: w * 0.10,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: w * 0.002,
                                    color: theColors.tabbarclr.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

String _formatDate(String date) {
  try {
    // Adjust based on the known format
    log('${date}');
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    return DateFormat('dd-MMM-yyyy').format(parsedDate);
  } catch (e) {
    // Handle errors
    print("Error formatting date: $e");
    return date; // Return the original date in case of error
  }
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
