// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:prepstudents/features/utils/thecolors.dart';
// import 'package:prepstudents/features/utils/theimage.dart';
// import 'package:prepstudents/main.dart';

// class Inbox extends StatelessWidget {
//   Inbox({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: theColors.white,
//       appBar: AppBar(
//         backgroundColor: theColors.primaryColor,
//         title: Text(
//           "Messeges",
//           style: TextStyle(color: theColors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             height: h * 0.08,
//             width: w,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.grey.shade100,
//                   Colors.white,
//                   Color.fromARGB(255, 203, 213, 228),
//                 ],
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(25)),
//               child: Padding(
//                 padding: EdgeInsets.all(w * 0.02),
//                 child: Row(
//                   children: [
//                     Icon(Icons.search, size: 29, color: Colors.grey),
//                     SizedBox(width: 5),
//                     Text("Search...."),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: h * 0.01,
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 5,
//               itemBuilder: (BuildContext context, int index) {
//                 return Dismissible(
//                   key: Key(index.toString()),
//                   direction: DismissDirection.horizontal,
//                   onDismissed: (direction) {
//                     if (direction == DismissDirection.endToStart) {
//                       // Handle delete action
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Deleted item $index')),
//                       );
//                     } else if (direction == DismissDirection.startToEnd) {
//                       // Handle star action
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Starred item $index')),
//                       );
//                     }
//                   },
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Icon(
//                       Icons.delete,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   secondaryBackground: Container(
//                     color: Colors.yellow[600],
//                     alignment: Alignment.center,
//                     child: Icon(
//                       Icons.star,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => Messagedetails()));
//                         },
//                         child: Container(
//                           color: theColors.white,
//                           child: ListTile(
//                             title: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Michael Scott",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: const Center(
//                                       child: Text(
//                                     "Admin",
//                                     style: TextStyle(
//                                         fontSize: 8, color: Color(0xff00008B)),
//                                   )),
//                                   height: h * 0.02,
//                                   width: w * 0.13,
//                                 ),
//                               ],
//                             ),
//                             subtitle: const Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                             fontSize: 11,
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.bold),
//                                         "As a web designer your role is crucial in creating.......",
//                                       ),
//                                       Text(
//                                           style: TextStyle(
//                                               fontSize: 11, color: Colors.grey),
//                                           "13 oct 20022,?Mon|6:00 am."),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             leading: const CircleAvatar(
//                               radius: 23,
//                               backgroundImage: AssetImage(theimage.profilepc),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Divider(),
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
// }
// import 'package:flutter/material.dart';

// class NavButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final double position;
//   final int length;
//   final int index;
//   final Widget child;

//   const NavButton({
//     Key? key,
//     required this.onTap,
//     required this.position,
//     required this.length,
//     required this.index,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double buttonWidth = MediaQuery.of(context).size.width / length;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: buttonWidth,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: Colors.transparent,
//             child: Center(child: child),
//           ),
//         ),
//       ),
//     );
//   }
// }




