import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisefox/student/features/bloc/sendfiles/send_files_bloc.dart';
import 'package:wisefox/student/features/bloc/filesharing/filesharing_bloc.dart';
import 'package:wisefox/student/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/student/features/bloc/tutorlist/tutorlist_bloc.dart';
import 'package:wisefox/student/features/screens/bottom_nav.dart';
import 'package:wisefox/student/features/screens/file_sharing_page.dart';

import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:wisefox/main.dart';

class ShareFilePage extends StatefulWidget {
  const ShareFilePage({super.key});

  @override
  State<ShareFilePage> createState() => _ShareFilePageState();
}

class _ShareFilePageState extends State<ShareFilePage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _fileScrollController = ScrollController();
  final ScrollController _notesScrollController = ScrollController();
  final TextEditingController _notesController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  List<String> _attachments = [];
  List<String> _selectedNames = [];
  List<int> _selectedTutorIds = [];
  String? _base64FileString;
  bool _isDropdownVisible = false;
  List<String> _tutorNames = [];
  List<String> _encodedFiles = [];
  List<String> _fileNames = [];
  List<Map<String, String>> _selectedStudents = [];
  int count = 1;

  @override
  void initState() {
    super.initState();
    context.read<TutorlistBloc>().add(FetchTutorList());
    context.read<FilesharingBloc>().add(FetchFilesharingEvent());
    context.read<SentedfilesBloc>().add(FetchSentedfiles());

    // context.read<SendFilesBloc>().add()
    context.read<SendFilesBloc>().emit(SendFilesInitial());

    // _textController.addListener(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _notesScrollController
    //         .jumpTo(_notesScrollController.position.maxScrollExtent);
    //   });
    // });
    _textController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_notesScrollController.hasClients) {
          _notesScrollController
              .jumpTo(_notesScrollController.position.maxScrollExtent);
        }
      });
    });

  }

  Future<void> _selectFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _fileNames = result.files.map((file) => file.name).toList();
          _attachments.addAll(_fileNames);

          _encodedFiles = result.files.map((file) {
            final bytes = File(file.path!).readAsBytesSync();
            final mimeType = _getMimeType(file.name);
            final base64String = base64Encode(bytes);
            return 'data:$mimeType;base64,$base64String';
          }).toList();
        });

        print("Selected Files: $_fileNames");
        print("Encoded Files: $_encodedFiles");
      } else {
        print("No file selected.");
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

  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  void _selectTutor(String label, int userId) {
    setState(() {
      // Toggle tutor selection
      if (_selectedNames.contains(label)) {
        _selectedNames.remove(label);
        _selectedTutorIds.remove(userId);
      } else {
        _selectedNames.add(label);
        _selectedTutorIds.add(userId);
      }

      // Update the text controller with the selected tutors
      _textController.text = _selectedNames.join(", ");

      // Hide the dropdown after each selection
      _isDropdownVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BlocBuilder<SendFilesBloc, SendFilesState>(
        builder: (context, state) {
          if (state is SendFileLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: theColors.primaryColor,
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: GestureDetector(
              onTap: () {
                _shareFile();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Bottomnav(
                //       initialIndex: 1,
                //     ),
                //   ),
                // );
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theColors.bottomnavColor,
                  borderRadius: BorderRadius.circular(w * 0.07),
                ),
                child: Center(
                  child: Text(
                    "Share File",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: theColors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: theColors.white,
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
          "Share a File",
          style: TextStyle(color: theColors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SendFilesBloc, SendFilesState>(
        builder: (context, state) {
          if (state is SendFileLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: theColors.primaryColor,
                ),
              ),
            );
          }
          return SafeArea(
            child: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(theimage.pagebackground),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.7),
                    BlendMode.lighten,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _fileScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: w * 0.02),
                          Text(
                            "Send to",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            width: w * 1,
                            child: GestureDetector(
                              onTap: _toggleDropdown,
                              child: AbsorbPointer(
                                child: Container(
                                  height: w * 0.13,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: w * 0.002,
                                        color: Color(0xffF4F4F4)),
                                    borderRadius:
                                        BorderRadius.circular(w * 0.03),
                                    color: theColors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: w * 0.006,
                                      left: w * 0.03,
                                    ),
                                    child: TextField(
                                      controller: _textController,
                                      focusNode: _focusNode,
                                      decoration: InputDecoration(
                                          hintText: "Select Tutors",
                                          hintStyle: TextStyle(
                                            fontSize: 12.sp,
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.all(w * 0.03),
                                            child: Container(
                                                height: w * 0.08,
                                                width: w * 0.08,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffEFF1F6)),
                                                child: Icon(
                                                    Icons.keyboard_arrow_down)),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          if (_isDropdownVisible)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF4F4F4)),
                                borderRadius: BorderRadius.circular(8.0),
                                color: theColors.white,
                              ),
                              child: BlocBuilder<TutorlistBloc, TutorListState>(
                                builder: (context, state) {
                                  if (state is TutorListLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else
                                  if (state is TutorListLoaded) {
                                    // filter tutors by search
                                    final filteredTutors = state.tutorList.where((tutor) {
                                      return tutor.label.toLowerCase().contains(_searchQuery.toLowerCase());
                                    }).toList();

                                    return Container(
                                      height: 280,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey[300]!),
                                      ),
                                      child: Column(
                                        children: [
                                          // Enhanced search field
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: TextField(
                                              controller: _searchController,
                                              decoration: InputDecoration(
                                                hintText: "Search tutors...",
                                                hintStyle: TextStyle(color: Colors.grey[500]),
                                                prefixIcon: Icon(Icons.search, color: theColors.primaryColor),
                                                suffixIcon: _searchQuery.isNotEmpty
                                                    ? IconButton(
                                                  icon: Icon(Icons.clear, color: Colors.grey[400]),
                                                  onPressed: () {
                                                    _searchController.clear();
                                                    setState(() {
                                                      _searchQuery = '';
                                                    });
                                                  },
                                                )
                                                    : null,
                                                filled: true,
                                                fillColor: Colors.grey[50],
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: theColors.primaryColor, width: 2),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                                ),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  _searchQuery = value;
                                                });
                                              },
                                            ),
                                          ),

                                          // Selection counter
                                          if (filteredTutors.isNotEmpty)
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.grey[200]!),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '${filteredTutors.length} tutor${filteredTutors.length == 1 ? '' : 's'} found',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  if (_selectedNames.isNotEmpty)
                                                    Text(
                                                      '${_selectedNames.length} selected',
                                                      style: TextStyle(
                                                        color: theColors.primaryColor,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),

                                          // Enhanced tutors list
                                          Expanded(
                                            child: filteredTutors.isEmpty
                                                ? Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.search_off,
                                                    size: 48,
                                                    color: Colors.grey[400],
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    _searchQuery.isEmpty ? 'No tutors available' : 'No tutors found',
                                                    style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  if (_searchQuery.isNotEmpty) ...[
                                                    SizedBox(height: 4),
                                                    Text(
                                                      'Try adjusting your search',
                                                      style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            )
                                                : ListView.separated(
                                              padding: EdgeInsets.symmetric(vertical: 4),
                                              itemCount: filteredTutors.length,
                                              separatorBuilder: (context, index) => Divider(
                                                height: 1,
                                                color: Colors.grey[200],
                                                indent: 16,
                                                endIndent: 16,
                                              ),
                                              itemBuilder: (context, index) {
                                                final tutor = filteredTutors[index];
                                                final isSelected = _selectedNames.contains(tutor.label);

                                                return Container(
                                                  color: Colors.white,
                                                  child: ListTile(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                    title: Text(
                                                      tutor.label,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                                        color: isSelected ? theColors.primaryColor : Colors.black87,
                                                      ),
                                                    ),
                                                    trailing: AnimatedContainer(
                                                      duration: Duration(milliseconds: 200),
                                                      child: Icon(
                                                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                                        color: isSelected ? theColors.primaryColor : Colors.grey[400],
                                                        size: 22,
                                                      ),
                                                    ),
                                                    onTap: () => _selectTutor(tutor.label, tutor.userId),
                                                    hoverColor: Colors.grey[100],
                                                    splashColor: theColors.primaryColor.withOpacity(0.1),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  //   if (state is TutorListLoaded) {
                                  //   // filter tutors by search
                                  //   final filteredTutors = state.tutorList.where((tutor) {
                                  //     return tutor.label.toLowerCase().contains(_searchQuery.toLowerCase());
                                  //   }).toList();
                                  //
                                  //   return Container(
                                  //     height: 250, // enough to fit search + list
                                  //     child: Column(
                                  //       children: [
                                  //         // 🔍 search field
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: TextField(
                                  //             controller: _searchController,
                                  //             decoration: InputDecoration(
                                  //               hintText: "Search tutor...",
                                  //               prefixIcon: Icon(Icons.search),
                                  //               border: OutlineInputBorder(
                                  //                 borderRadius: BorderRadius.circular(8.0),
                                  //               ),
                                  //               contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                  //             ),
                                  //             onChanged: (value) {
                                  //               setState(() {
                                  //                 _searchQuery = value;
                                  //               });
                                  //             },
                                  //           ),
                                  //         ),
                                  //
                                  //         // tutors list
                                  //         Expanded(
                                  //           child: ListView.builder(
                                  //             shrinkWrap: true,
                                  //             itemCount: filteredTutors.length,
                                  //             itemBuilder: (context, index) {
                                  //               final tutor = filteredTutors[index];
                                  //               return ListTile(
                                  //                 title: Text(tutor.label),
                                  //                 trailing: Icon(
                                  //                   _selectedNames.contains(tutor.label)
                                  //                       ? Icons.check_box
                                  //                       : Icons.check_box_outline_blank,
                                  //                   color: _selectedNames.contains(tutor.label)
                                  //                       ? theColors.primaryColor
                                  //                       : theColors.classbrdrclr,
                                  //                 ),
                                  //                 onTap: () => _selectTutor(tutor.label, tutor.userId),
                                  //               );
                                  //             },
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   );
                                  // }
                                    else if (state is TutorListError) {
                                    return Center(
                                        child: Text('Error loading tutors'));
                                  } else {
                                    return Center(
                                        child: Text('No tutors available'));
                                  }
                                },
                              ),
                            ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "File",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
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
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: _attachments.isNotEmpty
                                      ? ListView.builder(
                                          controller: _fileScrollController,
                                          scrollDirection: Axis.vertical,
                                          itemCount: _attachments.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(w * 0.01),
                                                child: Text(
                                                  ("${count + index}. ${_attachments[index]}"),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(w * 0.03),
                                          child: Text(
                                            "No file chosen",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: theColors.textgrey,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Text(
                            "Notes",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                          Container(
                            height: w * 0.45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: w * 0.002, color: Color(0xffF4F4F4)),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: theColors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(w * 0.03),
                              child: TextField(
                                controller: _notesController,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Add Notes...",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: w * 0.02),
                        ],
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

  @override
  void dispose() {
    _textController.dispose();
    _notesController.dispose();
    _fileScrollController.dispose();
    _notesScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _shareFile() {
    log("selercted students ${_selectedTutorIds} ${_encodedFiles}");
    if (_selectedTutorIds.isNotEmpty && _encodedFiles.isNotEmpty) {
      try {
        BlocProvider.of<SendFilesBloc>(context).add(
          ShareFileEvent(
            id: 2,
            receiver: _selectedTutorIds,
            filePath: _encodedFiles,
            title: _textController.text,
            notes: _notesController.text,
            isDraft: false,
          ),
        );
        context.read<SentedfilesBloc>().add(FetchSentedfiles());
        Navigator.pop(context);
      } catch (e) {
        print('Error dispatching ShareFileEvent: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share file: ${e.toString()}'),
            backgroundColor: theColors.bottomnavColor,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: theColors.bottomnavColor,
        ),
      );
    }
  }
}
