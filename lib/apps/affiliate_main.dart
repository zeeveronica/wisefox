// Affiliate App
import 'package:wisefox/affiliate/Screens/Bottomnav.dart';
import 'package:wisefox/affiliate/Screens/LoginPage.dart';
import 'package:wisefox/affiliate/bloc/auth_bloc.dart';
import 'package:wisefox/affiliate/repository/Authrepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisefox/main.dart';

// void main() async {
//   // Initialize SharedPreferences
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//
//   // Check if the token exists
//   final token = prefs.getString('loginData');
//   final bool isLoggedIn = token != null;
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(
//       MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => LoginBloc(AuthRepository())),
//         ],
//         child: Affiliation(isLoggedIn: isLoggedIn),
//       ),
//     );
//   });
// }

class AffiliateApp  extends StatelessWidget {
  final bool isLoggedIn;
  AffiliateApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // Define your design size here
      minTextAdapt: true,
      builder: (context, child) {
        return Builder(
          builder: (context) {
            // Set h and w globally
            h = MediaQuery.of(context).size.height;
            w = MediaQuery.of(context).size.width;

            return MaterialApp(
                routes: {
                  '/login': (context) => LoginPage(),
                },
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme.apply(
                        bodyColor: Colors.black, displayColor: Colors.black),
                  ),
                ),
                home: isLoggedIn ? Bottomnav() : LoginPage());
          },
        );
      },
    );
  }
}