// import 'dart:async';
// import 'dart:ui';
// import 'package:wisefox/client/features/bloc/isactive/is_active_bloc.dart';
// import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
// import 'package:wisefox/client/features/bloc/studentcount/studentcount_bloc.dart';
// import 'package:wisefox/client/features/model/sentedfile_model.dart';
// import 'package:wisefox/client/features/screens/democlassrequirment.dart';
// import 'package:wisefox/client/features/screens/open_recieved_file.dart';
// import 'package:wisefox/client/features/screens/studentadmission.dart';
// import 'package:wisefox/client/features/utils/thecolors.dart';
// import 'package:wisefox/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DemoRequest extends StatefulWidget {
//   @override
//   _DemoRequestState createState() => _DemoRequestState();
// }

// class _DemoRequestState extends State<DemoRequest> {
//   String? _selectedStatus; // Variable to hold the selected status
//   // final TextEditingController _searchController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   // Timer? _debounce;

//   @override
//   void initState() {
//     context.read<DemoRequestBloc>().add(FetchSentedfiles());

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: theColors.primaryColor,
//         title: Text(
//           "Demo Request",
//           style: TextStyle(color: theColors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => StudentAdmission(),
//                       ));
//                 },
//                 child: Container(
//                   width: w * 1,
//                   height: w * 0.15,
//                   decoration: BoxDecoration(
//                     color: theColors.tabbarclr,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: CustomPaint(
//                     painter: DottedBorderPainter(),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: w * 0.13,
//                             width: w * 0.13,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: theColors.primaryColor,
//                             ),
//                             child: Icon(
//                               Icons.person_add_alt,
//                               color: theColors.white,
//                             ),
//                           ),
//                           SizedBox(width: w * 0.05),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Add New Student',
//                                 style: TextStyle(fontSize: 12.sp),
//                               ),
//                               SizedBox(height: w * 0.01),
//                               Text(
//                                 'Lorem Ipsum is simply dummy text',
//                                 style: TextStyle(fontSize: 9.sp),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: w * 0.03),
//               Text(
//                 "Student list",
//                 style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: w * 0.03),
//               Container(
//                 width: w,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: w * 0.003,
//                     color: theColors.tabbarclr,
//                   ),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(w * 0.09),
//                 ),
//                 child: TextFormField(
//                   // controller: _searchController,

//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Search My Student",
//                     hintStyle: TextStyle(
//                       fontSize: 10.sp,
//                       color: theColors.textgrey,
//                     ),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       size: 29,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: w * 0.02),
//               BlocBuilder<DemoRequestBloc, DemoRequestState>(
//                 builder: (context, state) {
//                   if (state is DemoRequestedfilesLoaded &&
//                       state.files.isNotEmpty) {
//                     return ListView.builder(
//                       itemCount: state.files.length,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         final file = state.files[index];

//                         return Container(
//                           margin: EdgeInsets.only(top: w * 0.02),
//                           width: w,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: theColors.tabbarclr,
//                               width: w * 0.003,
//                             ),
//                             borderRadius: BorderRadius.circular(w * 0.04),
//                             color: theColors.white,
//                           ),
//                           child: Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Democlassrequirment(
//                                         details: file,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: ListTile(
//                                   title: Text(
//                                     "${file.firstName}",
//                                     style: TextStyle(fontSize: 11.sp),
//                                   ),
//                                   subtitle: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           context
//                                               .read<StudentCountBloc>()
//                                               .add(FetchStudentCount());
//                                           showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return Container(
//                                                 width: double.infinity,
//                                                 child: SimpleDialog(
//                                                   backgroundColor: Colors.white,
//                                                   title: Text(
//                                                     'Select Status',
//                                                     style: TextStyle(
//                                                         fontSize: 13.sp,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   children: <Widget>[
//                                                     SimpleDialogOption(
//                                                       onPressed: () {
//                                                         _updateStatus(context,
//                                                             file, 'Active');
//                                                       },
//                                                       child: Text(
//                                                         'Active',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.green),
//                                                       ),
//                                                     ),
//                                                     SimpleDialogOption(
//                                                       onPressed: () {
//                                                         _updateStatus(context,
//                                                             file, 'Inactive');
//                                                       },
//                                                       child: Text(
//                                                         'Inactive',
//                                                         style: TextStyle(
//                                                             color: Colors.red),
//                                                       ),
//                                                     ),
//                                                     SimpleDialogOption(
//                                                       onPressed: () {
//                                                         _updateStatus(context,
//                                                             file, 'Onleave');
//                                                       },
//                                                       child: Text(
//                                                         'Onleave',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.orange),
//                                                       ),
//                                                     ),
//                                                     SimpleDialogOption(
//                                                       onPressed: () {
//                                                         _updateStatus(context,
//                                                             file, 'Holiday');
//                                                       },
//                                                       child: Text(
//                                                         'Holiday',
//                                                         style: TextStyle(
//                                                             color: Colors.blue),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         },
//                                         child: Container(
//                                           height: w * 0.06,
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 7.0),
//                                           decoration: BoxDecoration(
//                                             color: theColors.white,
//                                             border: Border.all(
//                                                 color: theColors.lighttextgrey,
//                                                 width: w * 0.001),
//                                             borderRadius:
//                                                 BorderRadius.circular(w * 0.06),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 file.activeChoices, // Displays the current selected status
//                                                 style: TextStyle(
//                                                   fontSize: 10.sp,
//                                                   color: file.activeChoices ==
//                                                           'Active'
//                                                       ? Colors.green
//                                                       : theColors.textgrey,
//                                                 ),
//                                               ),
//                                               Icon(
//                                                 Icons
//                                                     .keyboard_arrow_down_rounded,
//                                                 size: w * 0.05,
//                                                 color: Color(0xff707070),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   leading: CircleAvatar(
//                                     radius: w * 0.07,
//                                     backgroundImage:
//                                         NetworkImage(file.studentPhoto),
//                                     backgroundColor: Colors.grey[200],
//                                   ),
//                                   trailing:
//                                       Icon(Icons.keyboard_arrow_right_outlined),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   } else if (state is DemoRequestedLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: theColors.primaryColor,
//                       ),
//                     );
//                   } else if (state is DemoRequestedfilesError) {
//                     return Center(
//                       child: Text('Error: ${state.error}'),
//                     );
//                   } else {
//                     return Center(child: Text(''));
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// // Helper function to update status
//   void _updateStatus(
//       BuildContext context, StudentListModel file, String newValue) {
//     // Call the BLoC to update the status
//     BlocProvider.of<IsActiveBloc>(context).add(
//       IsActiveRequested(
//         studentId: file.id.toString(),
//         status: newValue,
//       ),
//     );

//     // Update the displayed status in the dropdown
//     setState(() {
//       file.activeChoices = newValue;
//     });

//     // Close the dialog
//     Navigator.of(context).pop();
//   }
// }
import 'package:wisefox/client/features/bloc/isactive/is_active_bloc.dart';
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/client/features/bloc/studentcount/studentcount_bloc.dart';
import 'package:wisefox/client/features/model/sentedfile_model.dart';
import 'package:wisefox/client/features/screens/democlassrequirment.dart';
import 'package:wisefox/client/features/screens/studentadmission.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DemoRequest extends StatefulWidget {
  @override
  _DemoRequestState createState() => _DemoRequestState();
}

class _DemoRequestState extends State<DemoRequest> {
  String? _selectedStatus; // Variable to hold the selected status
  TextEditingController _searchController =
      TextEditingController(); // Search controller
  List<StudentListModel> _filteredStudents = []; // Filtered list of students

  @override
  void initState() {
    super.initState();
    context.read<DemoRequestBloc>().add(FetchSentedfiles());

    // Listen to search field input and update the filtered student list
    _searchController.addListener(() {
      _filterStudents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStudents = context.read<DemoRequestBloc>().state
              is DemoRequestedfilesLoaded
          ? (context.read<DemoRequestBloc>().state as DemoRequestedfilesLoaded)
              .files
              .where((file) => file.firstName.toLowerCase().contains(query))
              .toList()
          : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theColors.primaryColor,
        title: Text(
          "Demo Request",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                        builder: (context) => StudentAdmission(),
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
                            child: Icon(
                              Icons.person_add_alt,
                              color: theColors.white,
                            ),
                          ),
                          SizedBox(width: w * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add New Student',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              SizedBox(height: w * 0.01),
                              Text(
                                'Lorem Ipsum is simply dummy text',
                                style: TextStyle(fontSize: 9.sp),
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
                "Student list",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: w * 0.03),
              Container(
                width: w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: w * 0.003,
                    color: theColors.tabbarclr,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.09),
                ),
                child: TextFormField(
                  controller: _searchController, // Attach search controller
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search My Student",
                    hintStyle: TextStyle(
                      fontSize: 10.sp,
                      color: theColors.textgrey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 29,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: w * 0.02),
              BlocBuilder<DemoRequestBloc, DemoRequestState>(
                builder: (context, state) {
                  if (state is DemoRequestedfilesLoaded) {
                    // Use the filtered list for display
                    final studentsToDisplay = _filteredStudents.isEmpty
                        ? state.files
                        : _filteredStudents;

                    return ListView.builder(
                      itemCount: studentsToDisplay.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final file = studentsToDisplay[index];

                        return Container(
                          margin: EdgeInsets.only(top: w * 0.02),
                          width: w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theColors.tabbarclr,
                              width: w * 0.003,
                            ),
                            borderRadius: BorderRadius.circular(w * 0.04),
                            color: theColors.white,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Democlassrequirment(details: file),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    "${file.firstName}",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  subtitle: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<StudentCountBloc>()
                                              .add(FetchStudentCount());
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: double.infinity,
                                                child: SimpleDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text(
                                                    'Select Status',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  children: <Widget>[
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        _updateStatus(context,
                                                            file, 'Active');
                                                      },
                                                      child: Text(
                                                        'Active',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        _updateStatus(context,
                                                            file, 'Inactive');
                                                      },
                                                      child: Text(
                                                        'Inactive',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        _updateStatus(context,
                                                            file, 'Onleave');
                                                      },
                                                      child: Text(
                                                        'Onleave',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange),
                                                      ),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        _updateStatus(context,
                                                            file, 'Holiday');
                                                      },
                                                      child: Text(
                                                        'Holiday',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: w * 0.06,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.0),
                                          decoration: BoxDecoration(
                                            color: theColors.white,
                                            border: Border.all(
                                                color: theColors.lighttextgrey,
                                                width: w * 0.001),
                                            borderRadius:
                                                BorderRadius.circular(w * 0.06),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                file.activeChoices, // Displays the current selected status
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: file.activeChoices ==
                                                          'Active'
                                                      ? Colors.green
                                                      : theColors.textgrey,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: w * 0.05,
                                                color: Color(0xff707070),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    radius: w * 0.07,
                                    backgroundImage:
                                        NetworkImage(file.studentPhoto),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  trailing:
                                      Icon(Icons.keyboard_arrow_right_outlined),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is DemoRequestedLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: theColors.primaryColor,
                      ),
                    );
                  } else if (state is DemoRequestedfilesError) {
                    return Center(
                      // child: Text('Error: ${state.error}'),
                      child: Text('Coming Soon'),
                    );
                  } else {
                    return Center(child: Text('Coming Soon'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to update status
  void _updateStatus(
      BuildContext context, StudentListModel file, String newValue) {
    BlocProvider.of<IsActiveBloc>(context).add(
      IsActiveRequested(
        studentId: file.id.toString(),
        status: newValue,
      ),
    );
    Navigator.pop(context);
    setState(() {
      file.activeChoices = newValue;
    });
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
        Radius.circular(10),
      ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
