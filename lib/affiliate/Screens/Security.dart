import 'package:wisefox/affiliate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
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
                image: AssetImage("assets/affiliate/images/baground3.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.6), BlendMode.colorDodge))),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Account login activity",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "You're currently logged in on these devices",
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 10),
                _buildDeviceTile(
                  context,
                  image: SvgPicture.asset(
                    'assets/affiliate/images/iphone.svg',
                  ),
                  deviceName: "iPhone 12 Pro",
                  lastActive: "Last active: 1 hour ago",
                  onLogout: () {},
                ),
                const SizedBox(height: 20),
                const Text(
                  "Logins on other devices",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        _buildDeviceTile(
                          context,
                          image: SvgPicture.asset('assets/affiliate/images/ipad.svg'),
                          deviceName: "Apple iPad Pro",
                          lastActive: "Last active: 1 hour ago",
                          onLogout: () {},
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffF90000)),
            borderRadius: BorderRadius.circular(30),
          ),
          height: 49,
          child: Center(
            child: const Text(
              "Logout All",
              style: TextStyle(color: Color(0xffF90000)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceTile(BuildContext context,
      {required Widget image,
      required String deviceName,
      required String lastActive,
      required VoidCallback onLogout}) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.divider.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      width: w,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: w * 0.12,
          width: w * 0.11,
          child: ClipRRect(
            child: image,
          ),
        ),
        title: Text(
          deviceName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          lastActive,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        trailing: TextButton(
          onPressed: onLogout,
          child: const Text(
            "Logout",
            style: TextStyle(color: Color(0xff00008B), fontSize: 11),
          ),
        ),
      ),
    );
  }
}
