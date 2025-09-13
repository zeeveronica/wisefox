import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  List<bool> _expandedStates = List.generate(10, (index) => false);
  List<bool> _expandedState =
      List.generate(10, (index) => false); // Initial states

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff00008B),
          centerTitle: true,
          title: const Text(
            "Security",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        body: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/affiliate/images/baground2.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.6), BlendMode.colorDodge),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      const Text(
                        "Payouts",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10), // Add space between widgets
                      TextField(
                        decoration: InputDecoration(
                          isDense: true, // Reduces the overall padding
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Adjust the padding here
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                              size:
                                  24, // Reduce the size of the icon to match padding
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Adjust padding for the suffix icon
                            child: CircleAvatar(
                              backgroundColor: const Color(0xffE7ECF8),
                              child: SvgPicture.asset(
                                  "assets/affiliate/images/buttonalign.svg"),
                            ),
                          ),
                          hintText: 'Search Here...',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: AppColors.divider,
                          ),
                          contentPadding:
                              EdgeInsets.all(14), // Adjust content padding
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.tabbarclr2,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: w * 0.03),
                      const Text(
                        "May ,2024",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: w * 0.03),
                      Column(children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors
                                        .transparent, // Removes the top and bottom border lines
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(
                                        milliseconds:
                                            300), // Smooth expansion/collapse animation
                                    curve: Curves.easeInOut, // Animation curve
                                    // height: _expandedStates[index]
                                    //     ? 204
                                    //     : 66, // Adjust height based on expansion
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        color: _expandedState[index]
                                            ? Colors.grey.withOpacity(0.1)
                                            : Colors.transparent),
                                    child: Column(
                                      children: [
                                        // Title section with bottom border
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _expandedState[index] =
                                                  !_expandedState[
                                                      index]; // Toggle the expansion state
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.white.withOpacity(
                                                      0.0), // Color for the bottom border
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: _expandedState[index]
                                                        ? Colors.white.withOpacity(
                                                            0.2) // Apply border when expanded
                                                        : Color(
                                                            0xffF4F4F4), // Border around title and trailing icon
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15)
                                                  // Adjust the radius as needed
                                                  ),
                                              padding: const EdgeInsets.all(
                                                  8.0), // Padding for the title section
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: w * 0.04,
                                                          ),
                                                          const Text(
                                                            "Bill ID: 2978",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            width: w * 0.03,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5.0,
                                                                    vertical:
                                                                        4.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xffDBF6CD),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Text(
                                                              "Paid",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff005D2B),
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: w * 0.04,
                                                          ),
                                                          Text(
                                                            "Amount:£ 70.00",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                            Icons.more_horiz),
                                                      ),
                                                      Icon(
                                                        _expandedState[index]
                                                            ? Icons
                                                                .keyboard_arrow_up_outlined
                                                            : Icons
                                                                .keyboard_arrow_down_outlined,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Expanded content section
                                        AnimatedCrossFade(
                                          duration: Duration(
                                              milliseconds:
                                                  300), // Smooth transition for content appearance/disappearance
                                          firstChild: SizedBox
                                              .shrink(), // Placeholder for collapsed state
                                          secondChild: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.0),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ), // Apply border radius only to the bottom corners
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Client Payment Mode",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                            height: w * 0.01),
                                                        const Text(
                                                          "GoCardless",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                            height: w * 0.02),
                                                        const Text(
                                                          "Unattended Lesson",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                        const Text(
                                                          "0",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Completed Lessons",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                            height: w * 0.01),
                                                        const Text(
                                                          "7",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                            height: w * 0.02),
                                                        const Text(
                                                          "Download Invoice",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                            height: w * 0.01),
                                                        SvgPicture.asset(
                                                          height: w * 0.04,
                                                          "assets/affiliate/images/filedownload.svg",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          crossFadeState: _expandedState[index]
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: w * 0.03),
                              ],
                            );
                          },
                        ),
                      ]),
                      const Text(
                        "June,2024",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: w * 0.03),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors
                                      .transparent, // Removes the top and bottom border lines
                                ),
                                child: AnimatedContainer(
                                  duration: Duration(
                                      milliseconds:
                                          300), // Smooth expansion/collapse animation
                                  curve: Curves.easeInOut, // Animation curve
                                  // height: _expandedStates[index]
                                  //     ? 204
                                  //     : 66, // Adjust height based on expansion
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      color: _expandedStates[index]
                                          ? Colors.grey.withOpacity(0.1)
                                          : Colors.transparent),
                                  child: Column(
                                    children: [
                                      // Title section with bottom border
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _expandedStates[index] =
                                                !_expandedStates[
                                                    index]; // Toggle the expansion state
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.white.withOpacity(
                                                    0.0), // Color for the bottom border
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: _expandedStates[index]
                                                      ? Colors.white.withOpacity(
                                                          0.2) // Apply border when expanded
                                                      : Color(
                                                          0xffF4F4F4), // Border around title and trailing icon
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15)
                                                // Adjust the radius as needed
                                                ),
                                            padding: const EdgeInsets.all(
                                                8.0), // Padding for the title section
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: w * 0.04,
                                                        ),
                                                        const Text(
                                                          "Bill ID: 2978",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: w * 0.03,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5.0,
                                                                  vertical:
                                                                      4.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .green[100],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: const Text(
                                                            "Paid",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: w * 0.04,
                                                        ),
                                                        Text(
                                                          "Amount:£ 70.00",
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons.more_horiz),
                                                    ),
                                                    Icon(
                                                      _expandedStates[index]
                                                          ? Icons
                                                              .keyboard_arrow_up_outlined
                                                          : Icons
                                                              .keyboard_arrow_down_outlined,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Expanded content section
                                      AnimatedCrossFade(
                                        duration: Duration(
                                            milliseconds:
                                                300), // Smooth transition for content appearance/disappearance
                                        firstChild: SizedBox
                                            .shrink(), // Placeholder for collapsed state
                                        secondChild: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.0),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ), // Apply border radius only to the bottom corners
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Client Payment Mode",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                          height: w * 0.01),
                                                      const Text(
                                                        "GoCardless",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                          height: w * 0.02),
                                                      const Text(
                                                        "Unattended Lesson",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      const Text(
                                                        "0",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Completed Lessons",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                          height: w * 0.01),
                                                      const Text(
                                                        "7",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                          height: w * 0.02),
                                                      const Text(
                                                        "Download Invoice",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                          height: w * 0.01),
                                                      SvgPicture.asset(
                                                        height: w * 0.04,
                                                        "assets/affiliate/images/filedownload.svg",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        crossFadeState: _expandedStates[index]
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: w * 0.03),
                            ],
                          );
                        },
                      )
//new one
                    ])))));
  }
}
