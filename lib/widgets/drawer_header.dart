import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color(0xFF556EAA)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/icon.png',
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "SCHEDULE",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "FIT",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFfbc24c),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
