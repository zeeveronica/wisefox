import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../../apps/utils/thecolors.dart';
import '../../../apps/utils/theimage.dart';

class FullDigitalClock extends StatefulWidget {
  const FullDigitalClock({Key? key}) : super(key: key);

  @override
  State<FullDigitalClock> createState() => _FullDigitalClockState();
}

class _FullDigitalClockState extends State<FullDigitalClock> {
  late String _timeString;
  late String _dateString;
  late String _dayString;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    setState(() {
      //_timeString = DateFormat("HH:mm:ss").format(now); // 24-hour format
      _timeString =  DateFormat("hh:mm:ss").format(now);  // 12-hour format
      _dateString = DateFormat("dd MMM yyyy").format(now); // e.g. 11 Sep 2025
      _dayString = DateFormat("EEEE").format(now); // e.g. Thursday
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/student/icons/clock_new.png',height: 40,width: 40,),
        SizedBox(
          //width: 100,
          child: Container(
          //  height: 40,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: theColors.primaryColor.withOpacity(0.23),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                _timeString,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:Colors.black,
                  letterSpacing: 3,
                  //fontFamily: "Courier", // Digital style font
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



// Example of how to integrate into your existing dashboard
class DashboardWithTime extends StatefulWidget {
  @override
  _DashboardWithTimeState createState() => _DashboardWithTimeState();
}

class _DashboardWithTimeState extends State<DashboardWithTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              Color(0xFF1A4B3A).withOpacity(0.3),
              Color(0xFF0A0E27),
              Color(0xFF000814),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Your existing dashboard content
              Column(
                children: [
                  // Header
                  Container(
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Your other dashboard content here
                  Expanded(
                    child: Center(
                      child: Text(
                        'Your Dashboard Content',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),

              // Time Widget in top right corner
              Positioned(
                top: 20,
                right: 20,
                child: TimeWidget1(), // Change this to try different designs
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Design 1: Glassmorphic Time Widget
class TimeWidget1 extends StatefulWidget {
  @override
  _TimeWidget1State createState() => _TimeWidget1State();
}

class _TimeWidget1State extends State<TimeWidget1> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            // Colors.white.withOpacity(0.15),
            // Colors.white.withOpacity(0.05),
            Color(0xFF1A4B3A).withOpacity(0.3),
            Color(0xFF0A0E27),
            Color(0xFF000814),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${_getDayName(_currentTime.weekday)}, ${_getMonthName(_currentTime.month)} ${_currentTime.day}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

// Design 2: Neon Glow Time Widget
class TimeWidget2 extends StatefulWidget {
  @override
  _TimeWidget2State createState() => _TimeWidget2State();
}

class _TimeWidget2State extends State<TimeWidget2> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xff00008B),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00F5A0).withOpacity(0.3),
            blurRadius: 30,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF00F5A0), Color(0xFF00D9F5)],
            ).createShader(bounds),
            child: Text(
              '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: Color(0xFF00F5A0).withOpacity(0.8),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${_getDayName(_currentTime.weekday)}, ${_getMonthName(_currentTime.month)} ${_currentTime.day}',
            style: TextStyle(
              color: Color(0xFF00F5A0).withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

// Design 3: Gradient Card Time Widget
class TimeWidget3 extends StatefulWidget {
  @override
  _TimeWidget3State createState() => _TimeWidget3State();
}

class _TimeWidget3State extends State<TimeWidget3> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C5CE7),
            Color(0xFF74B9FF),
            Color(0xFF00CEC9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6C5CE7).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${_getDayName(_currentTime.weekday)}, ${_getMonthName(_currentTime.month)} ${_currentTime.day}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

// Design 4: Minimalist Digital Clock
class TimeWidget4 extends StatefulWidget {
  @override
  _TimeWidget4State createState() => _TimeWidget4State();
}

class _TimeWidget4State extends State<TimeWidget4> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 2),
          Text(
            _currentTime.second.toString().padLeft(2, '0'),
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 1,
            width: 40,
            color: Colors.white.withOpacity(0.3),
          ),
          SizedBox(height: 6),
          Text(
            '${_getDayName(_currentTime.weekday).toUpperCase()} ${_currentTime.day}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}

// Design 5: Animated Circular Time Widget
class TimeWidget5 extends StatefulWidget {
  @override
  _TimeWidget5State createState() => _TimeWidget5State();
}

class _TimeWidget5State extends State<TimeWidget5> with TickerProviderStateMixin {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  // Color(0xFF00F5A0).withOpacity(0.8),
                  // Color(0xFF00D9F5).withOpacity(0.6),

                  Color(0xFF00F5A0).withOpacity(0.8),
                Color(0xff080557).withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00F5A0).withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '${_getDayName(_currentTime.weekday)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getDayName(int weekday) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[weekday - 1];
  }
}

// Main demo app


