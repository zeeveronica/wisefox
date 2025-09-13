import 'dart:io';
import 'package:wisefox/affiliate/utils/utils.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _imageFile;

  

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff00008B),
        centerTitle: true,
        title: const Text(
          "Personal Info",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
           
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/affiliate/images/baground3.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.lighten),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: w * 0.49,
                                width: w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: SvgPicture.asset(
                                        'assets/affiliate/images/diamond3.svg',
                                        colorFilter: ColorFilter.mode(
                                            Colors.grey.shade500
                                                .withOpacity(0.1),
                                            BlendMode.multiply),
                                        fit: BoxFit.cover,
                                        height: w,
                                        width: w,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Center(
                                                child: CircleAvatar(
                                                  radius: 39,
                                                  backgroundImage: _imageFile !=
                                                          null
                                                      ? FileImage(_imageFile!)
                                                      : const AssetImage(
                                                              "assets/affiliate/images/photo2.png")
                                                          as ImageProvider,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: w * 0.41,
                                                child: GestureDetector(
                                                 
                                                  child: CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor:
                                                        const Color(0xff00008B),
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 18,
                                                      color: const Color(
                                                          0xfffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Richard ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "richard@gmail.com",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Stack(
                              children: [
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: 'Richard',
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.divider
                                              .withOpacity(0.2),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.divider
                                              .withOpacity(0.2),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                "Email Id",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'reshmanair@gmail..com',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.6),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.divider.withOpacity(0.2),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.divider.withOpacity(0.2),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                "Phone Number",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'username',
                                contentPadding: const EdgeInsets.all(10),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.6),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.divider.withOpacity(0.2),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.divider.withOpacity(0.2),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ]),
                    ),
           )])) );
            //     } else if (state is ClassesError) {
            //       return Center(child: Text('Error: ${state.message}'));
            //     }
            //     return Center(child: Text('No user data'));
              }
           
  }

