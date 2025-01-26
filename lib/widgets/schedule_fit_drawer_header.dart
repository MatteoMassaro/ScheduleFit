import 'package:flutter/material.dart';

import '../enums/schedule_fit_colors.dart';
import '../enums/schedule_fit_images.dart';
import '../providers/theme_provider.dart';

class ScheduleFitDrawerHeader extends StatelessWidget {
  const ScheduleFitDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration:
          BoxDecoration(color: ThemeProvider.getColor(AppColors.primaryColor)),
      child: Row(
        children: [
          Image.asset(
            getImage(Images.icon),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "FIT",
              style: TextStyle(
                fontSize: 25,
                color: ThemeProvider.getColor(AppColors.secondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
