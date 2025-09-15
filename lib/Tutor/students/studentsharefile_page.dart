import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:wisefox/client/features/bloc/studenttutorlist/studenttutorlist_bloc.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_bloc.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_event.dart';
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_state.dart';
import 'package:wisefox/client/features/service/shared_preferences.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';

class StudentShareFilePage extends StatefulWidget {
  @override
  _StudentShareFilePageState createState() => _StudentShareFilePageState();
}

class _StudentShareFilePageState extends State<StudentShareFilePage> {
  List<Map<String, String>> _selectedStudents =
      []; // Store selected student names and IDs
  List<String> _fileNames = []; // Store file names here
  List<String> _encodedFiles = [];
  // Store base64 encoded strings

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<SharefileBloc>(context).add(FileInitial());

    BlocProvider.of<TutorlistBloc>(context).add(FetchTutorList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<StudentShareFileBloc, StudentFilesharingState>(
        builder: (context, state) {
          if (state is StudentFileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return InkWell(
            onTap: _shareFile, // Trigger file sharing on tap
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: w * 0.13,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff080557),
                  borderRadius: BorderRadius.circular(w * 0.07),
                ),
                child: Center(
                  child:
                      // Show CircularProgressIndicator when loading
                      Text('Share File', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff00008B),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Share a File",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<StudentShareFileBloc, StudentFilesharingState>(
        builder: (context, state) {
          if (state is StudentFileLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/client/images/baground3.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6),
                  BlendMode.colorDodge,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: w * 0.02),
                    Text(
                      "Send to",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: w * 0.02),

                    Container(
                      width: w * 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffDCE4F2).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(w * 0.03),
                        color: Colors.white,
                      ),
                      child: BlocBuilder<TutorlistBloc, TutorState>(
                        builder: (context, state) {
                          if (state is TutorLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is TutorLoaded) {
                            return SearchableDropdown.multiple(
                              items: state.results.map((student) {
                                return DropdownMenuItem<String>(
                                  value: student.userId.toString(),
                                  child: Text(student.label),
                                );
                              }).toList(),
                              selectedItems: _selectedStudents.map((student) {
                                return state.results.indexWhere((s) =>
                                    s.userId.toString() == student['id']);
                              }).toList(),
                              searchHint: "Search here",
                              onChanged: (List<int> selectedIndexes) {
                                setState(() {
                                  _selectedStudents =
                                      selectedIndexes.map((index) {
                                    return {
                                      'id': state.results[index].userId
                                          .toString(),
                                      'label': state.results[index].label
                                    };
                                  }).toList();
                                });
                              },
                              isExpanded: true,
                              doneButton: 'Done',
                              closeButton: 'Close',
                              displayClearIcon: true,
                            );
                          } else if (state is TutorError) {
                            return Text(
                                'Failed to load students: ${state.message}');
                          }
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(height: w * 0.02),
                    Text(
                      "Title",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: w * 0.02),
                    Container(
                      height: w * 0.11,
                      width: w * 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffDCE4F2).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(w * 0.03),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.03),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //  labelText: "type..."
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: w * 0.02),
                    Text(
                      "Share File",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: w * 0.02),
                    Container(
                      height: w * 0.11,
                      width: w * 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffDCE4F2).withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(w * 0.03),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _selectFiles,
                            child: Container(
                              width: w * 0.3,
                              decoration: BoxDecoration(
                                color: Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(w * 0.03),
                                  bottomLeft: Radius.circular(w * 0.03),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Choose File",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Expanded(
                            child: Text(
                              _fileNames.isEmpty
                                  ? "No file chosen"
                                  : _fileNames.join(', '),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: w * 0.01),
                    Text(
                      "Maximum file size is 30 MB.",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: theColors.divider,
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: _fileNames.length,
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         title: Text(_fileNames[index]),
                    //       );
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: w * 0.02),
                    Text(
                      "Notes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: w * 0.02),
                    Container(
                      height: w * 0.26,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffDCE4F2).withOpacity(0.5)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.03),
                      ),
                      child: TextField(
                        controller: _notesController,
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _selectFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _fileNames = result.files.map((file) => file.name).toList();
          _encodedFiles = result.files.map((file) {
            final bytes = File(file.path!).readAsBytesSync();
            final mimeType = _getMimeType(file.name);
            final base64String = base64Encode(bytes);
            return 'data:$mimeType;base64,$base64String';
          }).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking files: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getMimeType(String fileName) {
    // Simple MIME type detection based on file extension
    if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
      return 'image/jpeg';
    } else if (fileName.endsWith('.png')) {
      return 'image/png';
    } else if (fileName.endsWith('.gif')) {
      return 'image/gif';
    } else if (fileName.endsWith('.pdf')) {
      return 'application/pdf';
    } else {
      return 'application/octet-stream'; // Fallback MIME type
    }
  }

  void _shareFile() async {
    if (_selectedStudents.isNotEmpty && _encodedFiles.isNotEmpty) {
      final receiverIds =
          _selectedStudents.map((student) => student['id']!).toString();
      String receiverId = _selectedStudents.first['id']!;
      // Optional: Handle receiver names if needed
      final receiverNames =
          _selectedStudents.map((student) => student['label']!).toList();
      log("going to click");
      var logindata = await SharedPreferencesHelper.getData('loginData');
      String sender = logindata["userid"].toString();
      log("${sender}");
      BlocProvider.of<StudentShareFileBloc>(context).add(
        StudentFileshareEvent(
          id: 2, sender: sender,
          receiver: receiverId,
          filePath: _encodedFiles,
          title: _titleController.text,
          notes: _notesController.text,
          isDraft: false,
          // Optional: Add receiver names if needed
          // receiverNames: receiverNames,
        ),
      );
      context.read<StudentSendFileBloc>().add(StudentLoadSendFiles());
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please fill in all fields and select at least one file and one student'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
