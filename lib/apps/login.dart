import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisefox/apps/features/bloc/auth_bloc.dart';
import 'package:wisefox/apps/features/repos/auth_repos.dart';
import 'package:wisefox/apps/features/screens/chat/chat.dart';
import 'package:wisefox/apps/features/screens/iframe/web_page.dart';
import 'package:wisefox/apps/model/user.dart';
import 'package:wisefox/apps/signup.dart';
import 'package:wisefox/apps/utils/urls.dart';
import 'package:wisefox/apps/utils/utils.dart';
import 'package:wisefox/main.dart';

import 'package:wisefox/student/features/screens/bottom_nav.dart' as StudentBottomNav;
import 'package:wisefox/client/features/screens/bottom_nav.dart' as ClientBottomNav;
import 'package:wisefox/tutor/features/screens/bottom_nav.dart' as TutorBottomNav;
    // 'wisefox/client/features/bloc/bloc/studentlessondetails_bloc.dart' as ClientStuentLessonDetails;


class UnifiedLoginWrapper extends StatelessWidget {
  const UnifiedLoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: UnifiedLoginPage(),
    );
  }
}


class UnifiedLoginPage extends StatefulWidget {
  const UnifiedLoginPage({super.key});

  @override
  State<UnifiedLoginPage> createState() => _UnifiedLoginPageState();
}

class _UnifiedLoginPageState extends State<UnifiedLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool hide = true;
  bool isLoading = false;

  // final passwordValidation = RegExp(r'.*');
  final emailValidation = RegExp(r'.*');

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  Color get textGrey => const Color(0xFF6B7280);
  Color get lightTextGrey => const Color(0xFF9CA3AF);
  Color get borderColor => const Color(0xFFDCE4F2);

  // void _handleLogin() {
  //   if (formKey.currentState!.validate()) {
  //     final username = emailController.text.trim();
  //     final password = passwordController.text.trim();
  //
  //     BlocProvider.of<AuthBloc>(context).add(
  //       LoginButtonPressed(username: username, password: password),
  //     );
  //   }
  // }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      final username = emailController.text.trim();
      final password = passwordController.text.trim();

      BlocProvider.of<AuthBloc>(context).add(
        LoginButtonPressed(username: username, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          final prefs = await SharedPreferences.getInstance();
          final loginDataStr = prefs.getString("loginData");

          if (loginDataStr != null) {
            final loginData = jsonDecode(loginDataStr);

            final user = User.fromJson(
              loginData["user"] as Map<String, dynamic>,
              tokenData: {
                "token": loginData["token"],
                "refresh": loginData["refresh"],
              },
            );

            final type = user.userTypes?.trim().toLowerCase();

            AppUtils().requestAllPermissions();

            if (type == "student") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => StudentBottomNav.Bottomnav()),
              );
            } else if (type == "client") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ClientBottomNav.Bottomnav()),
              );
            } else if (type == "tutor") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => TutorBottomNav.Bottomnav()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'You don`t have permission to login. Please contact Admin',
                    style: TextStyle(color: Colors.white), // keep text visible on red
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.error,
                style: const TextStyle(color: Colors.white), // keep text visible on red
              ),
              backgroundColor: Colors.red,
            ),
          );

        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              width: w * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/common/images/background1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(w * 0.05),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildLoginForm(),
                      _buildLoginButton(),
                      _buildFooterLinks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       backgroundColor: Colors.white,
  //       body: SingleChildScrollView(
  //         child: Container(
  //           width: w * 1,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: AssetImage('assets/common/images/background1.png'),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           child: Padding(
  //             padding: EdgeInsets.all(w * 0.05),
  //             child: Form(
  //               key: formKey,
  //               child: Column(
  //                 children: [
  //                   _buildHeader(),
  //                   _buildLoginForm(),
  //                   _buildLoginButton(),
  //                   _buildFooterLinks(),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(w * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/common/icons/question-circle.svg',
                // color: primaryC,
              ),
              SizedBox(width: w * 0.02),
            ],
          ),
          Container(
            height: w * 0.12,
            width: w * 0.4,
            child: Image.asset('assets/common/images/logo.png'),
          ),
          Container(
            child: Stack(children: [
              Positioned(
                top: w * 0.12,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/common/images/Group1.png",
                  height: w * 0.75,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: w * 0.55,
                  ),
                  SizedBox(
                    height: w * 0.10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: w * 0.3,
                      ),
                      FittedBox(
                        child: Text(
                          "Log in To your Account",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 17.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: w * 0.02,
                      ),
                      Text(
                        "Welcome back! please enter your details",
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: AppColors.textgrey),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: w * 0.3,
                  // ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  static const primaryColor = Color(0xFF2222AE);

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: EdgeInsets.all(w * 0.05),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            maxLines: null,
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (!emailValidation.hasMatch(value!)) {
                return "Enter valid Username";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              fillColor: Color(0xffFAFBFD),
              filled: true,
              labelText: "Username",
              labelStyle: TextStyle(
                color: AppColors.textgrey,
                fontSize: w * 0.032,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                borderSide: BorderSide(
                    width: w * 0.003,
                    color: Color(
                        0xffDCE4F2) // Default border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                borderSide: BorderSide(
                    width: w * 0.003,
                    color: Color(
                        0xffDCE4F2) // Border color when focused
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                borderSide: BorderSide(
                    width: w * 0.003,
                    color: Color(
                        0xffDCE4F2) // Border color when enabled but not focused
                ),
              ),
            ),
          ),
          SizedBox(
            height: w * 0.03,
          ),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            obscureText: hide == true ? true : false,
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Color(0xffFAFBFD),
              filled: true,
              suffixIcon: Container(
                width: w * 0.02,
                height: w * 0.02,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                  child: Icon(
                    hide == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              labelText: "Password",
              labelStyle: TextStyle(
                color: AppColors.textgrey,
                fontSize: w * 0.03,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                borderSide: BorderSide(
                    width: w * 0.003,
                    color: Color(
                        0xffDCE4F2) // Border color when focused
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                borderSide: BorderSide(
                  width: w * 0.003,
                  color: Color(
                      0xffDCE4F2), // Border color when enabled but not focused
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 0.010),
                    ),
                    side: BorderSide(
                      width: w * 0.003,
                      color: borderColor,
                    ),
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize: w * 0.03,
                      color: lightTextGrey,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Handle forgot password
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: w * 0.03,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Column(
      children: [
        SizedBox(height: w * 0.02),
        GestureDetector(
          onTap: isLoading ? null : _handleLogin,
          child: Container(
            height: w * 0.15,
            width: w,
            decoration: BoxDecoration(
              color: isLoading ? primaryColor.withOpacity(0.6) : primaryColor,
              borderRadius: BorderRadius.circular(w * 0.03),
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: w * 0.04),
                  const Text(
                    "Login Now  ",
                    style: TextStyle(color: Colors.white),
                  ),
                  SvgPicture.asset('assets/common/icons/rightarrow.svg'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: w * 0.02),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                color: textGrey,
                fontSize: w * 0.03,
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => SignupPageBloc(),
            //         ));
            //   },
            //   child: Text(
            //     "Register",
            //     style: TextStyle(
            //       fontSize: w * 0.035,
            //       fontWeight: FontWeight.w500,
            //       color: primaryColor,
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                _openUrl(Url.web); // 👈 replace with Url.web
              },
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: w * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 5,
              child: Text(
                "By continuing you agree to the ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textGrey,
                  fontSize: 8.sp,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  // Handle terms of service
                },
                child: Text(
                  "Terms of services",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 8.sp,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                " & ",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textGrey,
                  fontSize: 8.sp,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  // Handle privacy policy
                },
                child: Text(
                  "Privacy policy",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 8.sp,
                    overflow: TextOverflow.ellipsis,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}