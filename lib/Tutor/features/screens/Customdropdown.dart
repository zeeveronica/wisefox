import 'package:wisefox/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isVisible;
  final Function onToggle;
  final List<String> items;
  final Function(String) onSelect;

  CustomDropdown({
    required this.controller,
    required this.focusNode,
    required this.isVisible,
    required this.onToggle,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onToggle(),
          child: AbsorbPointer(
            child: Container(
              height: w * 0.12,
              decoration: BoxDecoration(
                border: Border.all(width: w * 0.002, color: Color(0xffF4F4F4)),
                borderRadius: BorderRadius.circular(w * 0.03),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: w * 0.006, left: w * 0.03),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 10.sp),
                  decoration: InputDecoration(
                    hintText: "Select",
                    hintStyle: TextStyle(fontSize: 10.sp),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(w * 0.03),
                      child: Icon(Icons.keyboard_arrow_down, size: w * 0.05),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isVisible)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffF4F4F4)),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item, style: TextStyle(fontSize: 10.sp)),
                  onTap: () => onSelect(item),
                );
              },
            ),
          ),
      ],
    );
  }
}
