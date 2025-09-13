import 'dart:developer';
import 'dart:ui';

import 'package:wisefox/main.dart';
import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Addnewlead extends StatefulWidget {
  const Addnewlead({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SentFilePageState createState() => _SentFilePageState();
}

class _SentFilePageState extends State<Addnewlead> {
  String? selectedCountry;
  bool check1 = false;

  bool hide = true;
  List<String> numberOfChildrenOptions = ['0', '1', '2', '3', '4', '5+'];
  String? selectedNumber;
  void _selectCountry() {
    showCountryPicker(
      context: context,
      onSelect: (country) {
        setState(() {
          selectedCountry = country.name;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.bluedark,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text("Add a new Lead",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Container(
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/affiliate/images/baground2.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5), BlendMode.lighten),
        )),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Basic Details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(
                height: w * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "First Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a First Name',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.6),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Last Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a Last Name',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.6),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 1.0),
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
                      fontWeight: FontWeight.w400),
                ),
              ),
              IntlPhoneField(
                dropdownIconPosition: IconPosition.trailing,
                showCountryFlag: false,
                decoration: InputDecoration(
                  hintText: 'phone number',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.6),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialCountryCode: 'IN',
                // Default country code
                onChanged: (phone) {
                  print(phone
                      .completeNumber); // Handle the phone number with country code
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Email id",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a Email id',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.6),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Number of Children",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedNumber,
                hint: Text(
                  '--Select--',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedNumber = newValue;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.6),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.divider.withOpacity(0.2),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.divider.withOpacity(0.2),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: numberOfChildrenOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Country",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                onTap: _selectCountry,
                decoration: InputDecoration(
                  hintText: selectedCountry ?? "Select a Country",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.6),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.divider.withOpacity(0.2), width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Subjects For Tuition",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                width: w,
                height: w * 0.49,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff363636).withOpacity(0.06)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("First Allocation"),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: w * 0.09,
                              width: w * 0.36,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Second Allocation"),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: w * 0.09,
                              width: w * 0.36,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Third Allocation"),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: w * 0.09,
                              width: w * 0.36,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: check1,
                    activeColor: AppColors.bluedark,
                    onChanged: (value) {
                      setState(() {
                        check1 = value!;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.010)),
                    side:
                        BorderSide(width: w * 0.003, color: Color(0xffDCE4F2)),
                  ),
                  Text(
                    "send welcome email to affiliate",
                    style:
                        TextStyle(fontSize: w * 0.03, color: AppColors.divider),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
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
                Text('Create Account', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
