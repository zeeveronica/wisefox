import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_bloc.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_event.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_state.dart';
import 'package:wisefox/client/features/screens/open_recieved_file.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/client/students/studentsharefile_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StudentRecievedFilesPage extends StatefulWidget {
  @override
  _StudentRecievedFilesPageState createState() =>
      _StudentRecievedFilesPageState();
}

class _StudentRecievedFilesPageState extends State<StudentRecievedFilesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StudentReceivedFileBloc>().add(StudentReceivedFileEvent());
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
            SizedBox(height: w * 0.03),
            Text(
              "Received Files",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            BlocBuilder<StudentReceivedFileBloc, StudentReceivedFileState>(
              builder: (context, state) {
                if (state is StudentReceivedFileLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: theColors.primaryColor));
                } else if (state is StudentReceivedFileLoaded) {
                  final files = state
                      .studentreceivedFiles; // Get the list of files from state

                  return ListView.builder(
                    itemCount: files.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final file = files[index]; // Access each file data

                      return Container(
                        margin: EdgeInsets.only(top: w * 0.02),
                        width: w * 1,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: theColors.tabbarclr, width: w * 0.003),
                          borderRadius: BorderRadius.circular(w * 0.02),
                          color: theColors.white,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OpenRecievedFile(
                                        fileUrl: file
                                            .file, // Pass the file URL to the next page
                                        receiverName: file
                                            .title, // Pass other necessary data
                                        notes: file.notes,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  file.file, // Use the file's title
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Color(0xff0EA5E9),
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xff0EA5E9),
                                    decorationThickness: 1.0,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                "Sender: ${file.title}",
                                style: TextStyle(fontSize: 10.sp),
                              ),
                              leading:
                                  SvgPicture.asset("assets/client/icons/files.svg"),
                              trailing: Container(
                                height: w * 0.08,
                                width: w * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w * 0.02),
                                  color: theColors.tabbarclr.withOpacity(0.5),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: theColors.textgrey,
                                  size: w * 0.04,
                                ),
                              ),
                              onTap: () {
                                // Handle tap to view file
                              },
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
                                  SizedBox(width: w * 0.05),
                                  SvgPicture.asset(
                                    "assets/client/icons/calendar (8).svg",
                                    color: theColors.textgrey,
                                  ),
                                  SizedBox(width: w * 0.03),
                                  Text(
                                    '22 May 2024', // You can replace this with a date from file if available
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
                } else if (state is StudentReceivedFileError) {
                  return Center(
                      child: Text(state.message)); // Handle error state
                } else {
                  return Center(
                      child: Text(
                          'No files available')); // Default view if no data
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theColors.primaryColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(10), // Adjusted for consistency
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
