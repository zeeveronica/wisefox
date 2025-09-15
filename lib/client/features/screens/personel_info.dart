import 'dart:io';
import 'package:wisefox/apps/model/user.dart';
import 'package:wisefox/apps/utils/utils.dart';
import 'package:wisefox/client/features/bloc/clients/client_bloc.dart';
import 'package:wisefox/client/features/model/client_model.dart';
import 'package:wisefox/client/features/model/tutor_model.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // File? _imageFile;

  // Future<void> _pickImage() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(type: FileType.image);
  //   if (result != null) {
  //     setState(() {
  //       _imageFile = File(result.files.single.path!);
  //     });
  //   }
  // }

  User? user;

  @override
  void initState() {
    super.initState();
    // You might want to load student data here if necessary
    _loadUser();
  }

  Future<void> _loadUser() async {
    final result = await AppUtils.getUser();
    setState(() {
      user = result;
      if (user != null) {
        _nameController.text = user!.username ?? '';
        _emailController.text = user!.email ?? '';
        _phoneController.text = user!.phoneNumber ?? '';
      }
    });
    print('user123');
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theColors.white,
      appBar: AppBar(
        backgroundColor: theColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Bottomnav(
                    initialIndex: 4,
                  ),
                ));
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Personal Info",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(theimage.pagebackground),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7), BlendMode.lighten),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: w,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/client/images/triangle.png"),
                //         fit: BoxFit.cover),
                //     borderRadius: BorderRadius.circular(w * 0.03),
                //     color: Color(0xffE7ECF8).withOpacity(0.5),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: BlocBuilder<ClientBloc, ClientState>(
                //       builder: (context, state) {
                //         if (state is ClientLoading) {
                //           return Center(
                //               child: CircularProgressIndicator(
                //             color: theColors.primaryColor,
                //           ));
                //         } else if (state is ClientLoaded) {
                //           final student = state.clients.isNotEmpty
                //               ? state.clients[0]
                //               : null;
                //
                //           if (student != null) {
                //             _updateControllers(student);
                //
                //             return Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 CircleAvatar(
                //                   radius: w * 0.10,
                //                   backgroundImage: NetworkImage(student
                //                       .clientPhoto), // Load image from URL
                //                   backgroundColor: Colors.grey[200],
                //                 ),
                //                 SizedBox(height: w * 0.02),
                //                 Text(
                //                   student.firstName,
                //                   style: TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 14.sp,
                //                     fontWeight: FontWeight.w500,
                //                   ),
                //                 ),
                //                 Text(
                //                   student.email,
                //                   style: TextStyle(
                //                     color: theColors.textgrey,
                //                     fontSize: 12.sp,
                //                     fontWeight: FontWeight.w500,
                //                   ),
                //                 ),
                //               ],
                //             );
                //           } else {
                //             return Center(
                //                 child: Text('No student data available'));
                //           }
                //         } else if (state is ClientError) {
                //           return Center(child: Text('Error: ${state.message}'));
                //         }
                //         return Center(child: Text('No data'));
                //       },
                //     ),
                //   ),
                // ),
                // SizedBox(height: w * 0.04),
                _buildTextField("Name", _nameController),
                SizedBox(height: w * 0.02),
                _buildTextField(
                  "Email Id",
                  _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: w * 0.02),
                _buildTextField(
                  "Phone Number",
                  _phoneController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateControllers(ClientModel student) {
    // _nameController.text = student.firstName;
    // _emailController.text = student.email;
    // _phoneController.text = student.phonenumber ?? '';
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    String? suffixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.0),
        TextField(
          style: TextStyle(fontSize: 11.sp),
          readOnly: true,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Color(0xffF4F4F4),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Color(0xffF4F4F4),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Color(0xffF4F4F4),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: suffixText != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 14),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        suffixText,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff00008B),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
