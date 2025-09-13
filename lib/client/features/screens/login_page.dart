import 'package:wisefox/client/features/bloc/auth_bloc.dart';
import 'package:wisefox/client/features/repos/auth_repos.dart';
import 'package:wisefox/client/features/screens/bottom_nav.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:wisefox/client/features/utils/theicons.dart';
import 'package:wisefox/client/features/utils/theimage.dart';
import 'package:wisefox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool check1 = false;
  bool hide = true;

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(httpClient: http.Client()),
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is PrepSuccess) {
                final accessToken = state.accessToken;
                print('Access Token: $accessToken');

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Bottomnav(),
                  ),
                );
              } else if (state is PrepFailure) {
                print('Failure: ${state.error}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Container(
                width: w * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(theimage.backgroundimg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(w * 0.05),
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      Container(
                        child: Stack(
                          children: [
                            Positioned(
                              top: w * 0.38,
                              left: w * 0.028,
                              child: Center(
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(0, -_animation.value),
                                      child: child,
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/client/images/path.png",
                                    height: w * 0.8,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(theicons.questionmark),
                                    SizedBox(
                                      width: w * 0.05,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: w * 0.12,
                                  width: w * 0.4,
                                  child: Image.asset(
                                    theimage.logo,
                                  ),
                                ),
                                SizedBox(
                                  height: w * 0.06,
                                ),
                                Image.asset(
                                  "assets/client/images/Group 7942.png",
                                  width: w * 0.7,
                                  height: w * 0.66,
                                  fit: BoxFit.fill,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: w * 0.08,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Log in To your Student Account",
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
                                        color: theColors.textgrey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: w * 0.10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: Color(0xffFAFBFD),
                          filled: true,
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: theColors.lighttextgrey,
                            fontSize: w * 0.032,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            borderSide: BorderSide(
                              width: w * 0.002,
                              color: theColors.classbrdrclr,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            borderSide: BorderSide(
                              width: w * 0.002,
                              color: theColors.classbrdrclr,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            borderSide: BorderSide(
                              width: w * 0.002,
                              color: theColors.classbrdrclr,
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
                        obscureText: hide,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: Color(0xffFAFBFD),
                          filled: true,
                          suffixIcon: Container(
                            width: w * 0.02,
                            height: w * 0.02,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hide = !hide;
                                });
                              },
                              child: Icon(
                                hide ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: theColors.lighttextgrey,
                            fontSize: w * 0.03,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            borderSide: BorderSide(
                              width: w * 0.002,
                              color: theColors.classbrdrclr,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            borderSide: BorderSide(
                              width: w * 0.002,
                              color: theColors.classbrdrclr,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            borderSide: BorderSide(
                              width: w * 0.002,
                              color: theColors.classbrdrclr,
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
                                value: check1,
                                activeColor: theColors.primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    check1 = value!;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(w * 0.010),
                                ),
                                side: BorderSide(
                                  width: w * 0.003,
                                  color: theColors.classbrdrclr,
                                ),
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  color: theColors.lighttextgrey,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: w * 0.03,
                              color: Color(0xff2222AE),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final email = emailController.text;
                            final password = passwordController.text;
                            context.read<AuthBloc>().add(
                                  LoginButtonPressed(
                                    email: email,
                                    password: password,
                                  ),
                                );
                          }
                        },
                        child: Container(
                          height: w * 0.15,
                          width: w * 1,
                          decoration: BoxDecoration(
                              color: theColors.primaryColor,
                              borderRadius: BorderRadius.circular(w * 0.03)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: w * 0.04,
                                ),
                                Text(
                                  "Login Now  ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SvgPicture.asset("assets/client/icons/rightarrow.svg")
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: w * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                color: theColors.textgrey, fontSize: w * 0.03),
                          ),
                          Text(
                            "Register",
                            style: TextStyle(
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w500,
                                color: theColors.primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: w * 0.02,
                      ),
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
                                  color: theColors.textgrey, fontSize: 8.sp),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Text(
                              "Terms of services",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 8.sp,
                                  color: theColors.primaryColor),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              " & ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: theColors.textgrey, fontSize: 8.sp),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Text(
                              "Privacy policy",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 8.sp,
                                  overflow: TextOverflow.ellipsis,
                                  color: theColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
