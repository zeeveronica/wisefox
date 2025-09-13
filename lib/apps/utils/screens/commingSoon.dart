import 'package:flutter/material.dart';
import 'dart:async';

import '../../../main.dart';

class ComingSoonPage extends StatefulWidget {
  final String message;
  final bool leadingIcon;
  const ComingSoonPage({Key? key, required this.message, required this.leadingIcon}) : super(key: key);

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _emailController = TextEditingController();
  bool _isSubscribed = false;

  // Countdown timer
  late Timer _timer;
  Duration _timeLeft = const Duration(days: 30, hours: 12, minutes: 45, seconds: 30);

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Setup animations
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();

    // Start countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _emailController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _subscribe() {
    if (_emailController.text.isNotEmpty && _emailController.text.contains('@')) {
      setState(() {
        _isSubscribed = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Thank you for subscribing! We\'ll notify you when we launch.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid email address.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.leadingIcon?true:false,
backgroundColor:   Color(0xff00008B),
        centerTitle: true,
        title: Text(widget.message,style: TextStyle(color: Colors.white),),
        // flexibleSpace: Container(
        //   color: Colors.white,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color(0xFF667eea), // Indigo/Blue
          //   Color(0xff00008B)
          //       // Color(0xFF764ba2), // Purple
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          // ),
      //  ),
      ),
      body: Container(
        height: h,
        decoration: const BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomRight,
          //   colors: [
          //
          //     Color(0xff00008B),
          //     Color(0xFF667eea),
          //     Color(0xFF667eea),
          //
          //   //  Color(0xFF764ba2),
          //
          //     Color(0xff00008B),
          //     Color(0xff1E90FF),
          //   //  Color(0xFF6B73FF),
          //   ],
          // ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated rocket icon

                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFF667eea),
                              Color(0xff080557),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.rocket_launch,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // ScaleTransition(
                    //   scale: _pulseAnimation,
                    //   child: Container(
                    //     width: 120,
                    //     height: 120,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.white.withOpacity(0.2),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.white.withOpacity(0.3),
                    //           blurRadius: 30,
                    //           spreadRadius: 5,
                    //         ),
                    //       ],
                    //     ),
                    //     child: const Icon(
                    //       Icons.rocket_launch,
                    //       size: 60,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 40),

                    // Main title
                    const Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xff00008B),
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Something amazing is on its way!\nWe\'re working hard to bring you the best experience.',
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white.withOpacity(0.9),
                        color:  Color(0xff00008B),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    //
                    // // Countdown timer
                    // Container(
                    //   padding: const EdgeInsets.all(20),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.1),
                    //     borderRadius: BorderRadius.circular(20),
                    //     border: Border.all(
                    //       color: Colors.white.withOpacity(0.2),
                    //       width: 1,
                    //     ),
                    //
                    //     // boxShadow: [
                    //     //   BoxShadow(
                    //     //     color: Colors.black.withOpacity(0.3),
                    //     //     blurRadius: 10,
                    //     //     spreadRadius: 2,
                    //     //   ),
                    //     // ],
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         'Launch Countdown',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.white.withOpacity(0.8),
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 16),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           _buildTimeCard(_timeLeft.inDays.toString().padLeft(2, '0'), 'Days'),
                    //           _buildTimeCard((_timeLeft.inHours % 24).toString().padLeft(2, '0'), 'Hours'),
                    //           _buildTimeCard((_timeLeft.inMinutes % 60).toString().padLeft(2, '0'), 'Min'),
                    //           _buildTimeCard((_timeLeft.inSeconds % 60).toString().padLeft(2, '0'), 'Sec'),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 40),
                    //
                    // // Email subscription
                    // if (!_isSubscribed) ...[
                    //   Container(
                    //     padding: const EdgeInsets.all(20),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white.withOpacity(0.1),
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         color: Colors.white.withOpacity(0.2),
                    //         width: 1,
                    //       ),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           'Get Notified When We Launch',
                    //           style: TextStyle(
                    //             fontSize: 18,
                    //             color: Colors.white.withOpacity(0.9),
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 16),
                    //         Row(
                    //           children: [
                    //             Expanded(
                    //               child: TextFormField(
                    //                 controller: _emailController,
                    //                 decoration: InputDecoration(
                    //                   hintText: 'Enter your email',
                    //                   hintStyle: TextStyle(
                    //                     color: Colors.white.withOpacity(0.6),
                    //                   ),
                    //                   border: OutlineInputBorder(
                    //                     borderRadius: BorderRadius.circular(12),
                    //                     borderSide: BorderSide.none,
                    //                   ),
                    //                   fillColor: Colors.white.withOpacity(0.2),
                    //                   filled: true,
                    //                   prefixIcon: Icon(
                    //                     Icons.email_outlined,
                    //                     color: Colors.white.withOpacity(0.7),
                    //                   ),
                    //                 ),
                    //                 style: const TextStyle(color: Colors.white),
                    //               ),
                    //             ),
                    //             const SizedBox(width: 12),
                    //             ElevatedButton(
                    //               onPressed: _subscribe,
                    //               style: ElevatedButton.styleFrom(
                    //                 backgroundColor: Colors.white,
                    //                 foregroundColor: const Color(0xFF667eea),
                    //                 padding: const EdgeInsets.symmetric(
                    //                   horizontal: 24,
                    //                   vertical: 16,
                    //                 ),
                    //                 shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(12),
                    //                 ),
                    //               ),
                    //               child: const Text(
                    //                 'Notify Me',
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w600,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ] else ...[
                    //   Container(
                    //     padding: const EdgeInsets.all(20),
                    //     decoration: BoxDecoration(
                    //       color: Colors.green.withOpacity(0.2),
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         color: Colors.green.withOpacity(0.3),
                    //         width: 1,
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         const Icon(
                    //           Icons.check_circle_outline,
                    //           color: Colors.white,
                    //           size: 24,
                    //         ),
                    //         const SizedBox(width: 12),
                    //         Text(
                    //           'Thank you! You\'ll be notified soon.',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.white.withOpacity(0.9),
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ],
                    // const SizedBox(height: 40),
                    //
                    // // Social media links
                    // Text(
                    //   'Follow us for updates',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white.withOpacity(0.8),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     _buildSocialButton(Icons.facebook, 'Facebook'),
                    //     const SizedBox(width: 16),
                    //     _buildSocialButton(Icons.alternate_email, 'Twitter'),
                    //     const SizedBox(width: 16),
                    //     _buildSocialButton(Icons.camera_alt, 'Instagram'),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String platform) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $platform...'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),

    );

  }

}
