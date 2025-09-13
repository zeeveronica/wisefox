// showModalBottomSheet(
//   context: context,
//   useSafeArea: true,
//   constraints: BoxConstraints(
//     maxHeight: double.infinity,
//   ),
//   scrollControlDisabledMaxHeightRatio: 1,
//   // useSafeArea: false,
//   backgroundColor: Colors.transparent,
//   builder: (BuildContext context) {
//     return StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         final FocusNode _focusNode = FocusNode();

//         _focusNode.addListener(() {
//           if (_focusNode.hasFocus) {}
//         });

//         return LayoutBuilder(
//           builder: (BuildContext context,
//               BoxConstraints constraints) {
//             final double screenHeight =
//                 MediaQuery.of(context).size.height;
//             final double keyboardHeight =
//                 MediaQuery.of(context).viewInsets.bottom;
//             final double availableHeight =
//                 screenHeight - keyboardHeight;

//             return FractionallySizedBox(
//               heightFactor: 0.5,
//               child: Container(
//                 height: availableHeight,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(w * 0.07),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: w * 0.01),
//                       height: w * 0.01,
//                       width: w * 0.15,
//                       decoration: BoxDecoration(
//                         color: Color(0xffE4EFF5),
//                         borderRadius:
//                             BorderRadius.circular(w * 0.03),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: SvgPicture.asset(
//                               "assets/student/icons/close.svg"),
//                         ),
//                         SizedBox(width: w * 0.03),
//                       ],
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.all(w * 0.03),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Products",
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: w * 0.02),
//                             Text(
//                               "This will cancel your scheduled class for the day.",
//                               style: TextStyle(
//                                 fontSize: 11.sp,
//                                 color: theColors.textgrey,
//                               ),
//                             ),
//                             SizedBox(height: w * 0.03),
//                             Container(
//                               height: w * 0.3,
//                               decoration: BoxDecoration(
//                                 color: theColors.classclr,
//                                 borderRadius:
//                                     BorderRadius.circular(
//                                         w * 0.03),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: w * 0.03),
//                                 child: TextField(
//                                   focusNode: _focusNode,
//                                   maxLines: null,
//                                   keyboardType:
//                                       TextInputType.multiline,
//                                   decoration: InputDecoration(
//                                     labelText:
//                                         "Type Your Reason...",
//                                     labelStyle: TextStyle(
//                                         fontSize: 11.sp,
//                                         color: Colors.black),
//                                     border: InputBorder.none,
//                                     enabledBorder:
//                                         InputBorder.none,
//                                     focusedBorder:
//                                         InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: w * 0.02),
//                             Container(
//                               height: w * 0.15,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: theColors.primaryColor,
//                                 borderRadius:
//                                     BorderRadius.circular(
//                                         w * 0.05),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "Submit",
//                                   style: TextStyle(
//                                       color: theColors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   },
// );

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:wisefox/student/features/utils/thecolors.dart';
// import 'package:wisefox/main.dart';

// class RecievedFilesPage extends StatefulWidget {
//   @override
//   _RecievedFilesPageState createState() => _RecievedFilesPageState();
// }

// class _RecievedFilesPageState extends State<RecievedFilesPage> {
//   List<String> _attachments = [];

//   Future<void> _pickFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();
//       if (result != null) {
//         setState(() {
//           _attachments.add(result.files.single.name);
//         });
//       } else {}
//     } catch (e) {
//       print("Error picking file: $e");
//     }
//   }

//   Future<void> _openFile(String filePath) async {
//     // Implement the logic to open the file using filePath
//     print("Opening file: $filePath");
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;

//     return Padding(
//       padding: EdgeInsets.all(w * 0.03),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: _pickFile,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.grey[200],
//               ),
//               height: h * 0.06,
//               width: w,
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.attach_file,
//                       color: Colors.orange,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       "Attach File",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _attachments.length,
//               itemBuilder: (context, index) {
//                 final attachment = _attachments[index];
//                 return ListTile(
//                   onTap: () async {
//                     // Open the file when tapped
//                     // Assuming you have the file path (you need to maintain the mapping of file names to paths)
//                     final filePath = ''; // You need to map file names to their paths
//                     if (filePath.isNotEmpty) {
//                       await _openFile(filePath);
//                     }
//                   },
//                   title: Text(attachment, style: TextStyle(color: Colors.blue)),
//                   leading: Icon(Icons.attachment, color: Colors.grey),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DottedBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = theColors.primaryColor
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final path = Path()
//       ..addRRect(RRect.fromRectAndRadius(
//         Rect.fromLTWH(0, 0, size.width, size.height),
//         Radius.circular(10), // Adjusted for consistency
//       ));

//     final dashWidth = 5;
//     final dashSpace = 5;
//     final totalLength =
//         path.computeMetrics().fold(0.0, (sum, metric) => sum + metric.length);

//     double distance = 0;

//     while (distance < totalLength) {
//       final metrics = path.computeMetrics();
//       for (final metric in metrics) {
//         final length = metric.length;
//         if (distance >= length) {
//           distance -= length;
//           continue;
//         }

//         final startOffset = distance;
//         final endOffset = distance + dashWidth;
//         if (endOffset > length) {
//           // Adjust the endOffset if it exceeds the path length
//           final extra = endOffset - length;
//           distance = length;
//           continue;
//         }

//         final startTangent = metric.getTangentForOffset(startOffset);
//         final endTangent = metric.getTangentForOffset(endOffset);

//         if (startTangent != null && endTangent != null) {
//           canvas.drawLine(
//             startTangent.position,
//             endTangent.position,
//             paint,
//           );
//         }
//         distance += dashWidth + dashSpace;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:wisefox/student/features/screens/share_file_page.dart';
// import 'package:wisefox/student/features/utils/thecolors.dart';
// import 'package:wisefox/main.dart';

// class RecievedFilesPage extends StatefulWidget {
//   @override
//   _RecievedFilesPageState createState() => _RecievedFilesPageState();
// }

// class _RecievedFilesPageState extends State<RecievedFilesPage> {
//   List<String> _attachments = [];

//   Future<void> _pickFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();
//       if (result != null) {
//         setState(() {
//           _attachments.add(result.files.single.name);
//         });
//       } else {
//         print("No file selected.");
//       }
//     } catch (e) {
//       print("Error picking file: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(w * 0.03),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             // onTap: _pickFile,
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ShareFilePage(),
//                   ));
//             },
//             child: Container(
//               width: double.infinity,
//               height: h * 0.1,
//               decoration: BoxDecoration(
//                 color: theColors.tabbarclr,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: CustomPaint(
//                 painter: DottedBorderPainter(),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       height: w * 0.1,
//                       width: w * 0.1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: theColors.primaryColor,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           "assets/student/icons/share.svg",
//                           height: w * 0.08,
//                           width: w * 0.08,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Share a File',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           'Lorem Ipsum is simply dummy text of the printing',
//                           style: TextStyle(
//                             fontSize: 9.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 1,
//               //  _attachments.length,
//               itemBuilder: (context, index) {
//                 final attachment = _attachments[index];
//                 return Container(
//                   height: w * 0.25, // Height of the existing container
//                   width: w * 1, // Width of the existing container
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(w * 0.03),
//                     color: theColors.white,
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListTile(
//                           // onTap: () async {
//                           //   // final filePath = '';
//                           //   // if (filePath.isNotEmpty) {
//                           //   //   await _openFile(filePath);
//                           //   }
//                           // },
//                           title: Text(
//                             "dxffxd",
//                             // attachment,
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: Color(0xff0EA5E9),
//                               decoration: TextDecoration.underline,
//                               decorationColor: Color(0xff0EA5E9),
//                               decorationThickness: 1.0,
//                             ),
//                           ),
//                           subtitle: Text(
//                             "Sender: Reshma Nair",
//                             style: TextStyle(fontSize: 10.sp),
//                           ),
//                           leading: SvgPicture.asset("assets/student/icons/files.svg"),
//                           trailing: Icon(Icons.arrow_forward_rounded),
//                         ),
//                       ),
//                       Container(
//                         height: w * 0.08,
//                         width: w * 1,
//                         decoration: BoxDecoration(
//                           color: theColors.classclr,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(w * 0.03),
//                             bottomRight: Radius.circular(w * 0.03),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: w * 0.05,
//                             ),
//                             SvgPicture.asset(
//                               "assets/student/icons/calendar (8).svg",
//                               color: theColors.textgrey,
//                             ),
//                             SizedBox(
//                               width: w * 0.03,
//                             ),
//                             Text(
//                               '22 May 2024',
//                               style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: theColors.textgrey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _openFile(String filePath) async {
//     print("Opening file: $filePath");
//   }
// }

// class DottedBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = theColors.primaryColor
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final path = Path()
//       ..addRRect(RRect.fromRectAndRadius(
//         Rect.fromLTWH(0, 0, size.width, size.height),
//         Radius.circular(10), // Adjusted for consistency
//       ));

//     final dashWidth = 5;
//     final dashSpace = 5;
//     final totalLength =
//         path.computeMetrics().fold(0.0, (sum, metric) => sum + metric.length);

//     double distance = 0;

//     while (distance < totalLength) {
//       final metrics = path.computeMetrics();
//       for (final metric in metrics) {
//         final length = metric.length;
//         if (distance >= length) {
//           distance -= length;
//           continue;
//         }

//         final startOffset = distance;
//         final endOffset = distance + dashWidth;
//         if (endOffset > length) {
//           final extra = endOffset - length;
//           distance = length;
//           continue;
//         }

//         final startTangent = metric.getTangentForOffset(startOffset);
//         final endTangent = metric.getTangentForOffset(endOffset);

//         if (startTangent != null && endTangent != null) {
//           canvas.drawLine(
//             startTangent.position,
//             endTangent.position,
//             paint,
//           );
//         }
//         distance += dashWidth + dashSpace;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
// import 'package:flutter/material.dart';

// class NavCustomPainter extends CustomPainter {
//   final double pos;
//   final int length;
//   final Color color;
//   final TextDirection textDirection;

//   NavCustomPainter(this.pos, this.length, this.color, this.textDirection);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final double width = size.width;
//     final double height = size.height;

//     final Path path = Path();
//     final double buttonWidth = width / length;

//     if (textDirection == TextDirection.ltr) {
//       path.moveTo(0, height);
//       path.lineTo(pos * width, height);
//       path.lineTo(pos * width + buttonWidth, height - 30);
//       path.lineTo(width, height - 30);
//       path.lineTo(width, 0);
//       path.lineTo(0, 0);
//       path.close();
//     } else {
//       path.moveTo(width, height);
//       path.lineTo((1 - pos) * width, height);
//       path.lineTo((1 - pos) * width - buttonWidth, height - 30);
//       path.lineTo(0, height - 30);
//       path.lineTo(0, 0);
//       path.lineTo(width, 0);
//       path.close();
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }



// Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: h * 0.078,
//                     child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 1,
//                       scrollDirection: Axis.vertical,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.all(w * 0.03),
//                           child: Container(
//                             height: h * 0.07,
//                             alignment: Alignment.centerLeft,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   for (int i = 0; i < 5; i++) ...[
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           _tabController.animateTo(i);
//                                         });
//                                       },
//                                       child: Container(
//                                         // width: w * 0.3,
//                                         height: w * 0.09,
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16.0, vertical: 3.0),
//                                         decoration: BoxDecoration(
//                                           color: _tabController.index == i
//                                               ? Color(0xffCACAD9)
//                                               : Color(0xffFAFBFD),
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             i == 0
//                                                 ? 'Today'
//                                                 : i == 1
//                                                     ? 'Tomorrow'
//                                                     : '26 Aug',
//                                             style: TextStyle(
//                                                 color: _tabController.index == i
//                                                     ? Colors.black
//                                                     : Colors.black,
//                                                 fontWeight:
//                                                     _tabController.index == i
//                                                         ? FontWeight.w600
//                                                         : FontWeight.normal,
//                                                 fontSize: 10.sp),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     if (i != 4)
//                                       Container(
//                                         height: w * 0.02,
//                                         width: 16.0,
//                                         color: Color(0xffFAFBFD),
//                                       ),
//                                   ],
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),