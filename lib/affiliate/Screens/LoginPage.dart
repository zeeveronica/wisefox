import 'package:wisefox/affiliate/Screens/Bottomnav.dart';
import 'package:wisefox/affiliate/bloc/auth_bloc.dart';
import 'package:wisefox/affiliate/bloc/auth_event.dart';
import 'package:wisefox/affiliate/bloc/auth_state.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/affiliate/repository/Authrepo.dart';
import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final passwordValidation = RegExp(r'.*');
  final emailValidation = RegExp(r'.*');

  // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
  bool check1 = false;

  bool hide = true;
  @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(
  //     duration: const Duration(seconds: 2),
  //     vsync: this,
  //   )..repeat(reverse: true);

  //   _animation = Tween<double>(begin: 0.0, end: 10.0).animate(
  //     CurvedAnimation(
  //       parent: _controller,
  //       curve: Curves.elasticOut,
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepository()),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bottomnav()),
                    // Ensure all previous routes are removed
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Container(
                    // height: h * 1,
                    width: w * 1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/affiliate/images/baground2.png"),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.05),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/affiliate/images/question-circle.svg",
                                  color: AppColors.bluedark,
                                ),
                                SizedBox(
                                  width: w * 0.02,
                                ),
                              ],
                            ),
                            Container(
                              height: w * 0.12,
                              width: w * 0.4,
                              child: Image.asset(
                                "assets/affiliate/images/logo.png",
                              ),
                            ),
                            Container(
                              child: Stack(children: [
                                Positioned(
                                  top: w * 0.12,
                                  left: w * 0.028,
                                  child: Center(
                                    child: Image.asset(
                                      "assets/affiliate/images/Group1.png",
                                      height: w * 0.8,
                                    ),
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
                                          height: w * 0.08,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            "Log in To your Affiliation Account",
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
                                    SizedBox(
                                      height: w * 0.10,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
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
                                      value: check1,
                                      activeColor: AppColors.bluedark,
                                      onChanged: (value) {
                                        setState(() {
                                          check1 = value!;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.010)),
                                      side: BorderSide(
                                          width: w * 0.003,
                                          color: Color(0xffDCE4F2)),
                                    ),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                          fontSize: w * 0.03,
                                          color: AppColors.divider),
                                    )
                                  ],
                                ),
                                Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      fontSize: w * 0.03,
                                      color: Color(0xff2222AE)),
                                )
                              ],
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoginLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                            LoginRequested(email: emailController.text, password: passwordController.text)
                                          );
                                    }
                                  },
                                  child: Container(
                                    height: w * 0.15,
                                    width: w * 1,
                                    decoration: BoxDecoration(
                                        color: AppColors.bluedark,
                                        borderRadius:
                                            BorderRadius.circular(w * 0.03)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: w * 0.04,
                                          ),
                                          Text(
                                            "Login Now  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SvgPicture.asset(
                                              "assets/affiliate/images/grouparrow.svg")
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                                      color: AppColors.textgrey,
                                      fontSize: w * 0.03),
                                ),
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: w * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.bluedark),
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
                                        color: AppColors.textgrey,
                                        fontSize: 8.sp),
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
                                        color: AppColors.bluedark),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    " & ",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.textgrey,
                                        fontSize: 8.sp),
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
                                        color: AppColors.bluedark),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
