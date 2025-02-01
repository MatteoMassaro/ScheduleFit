import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../enums/schedule_fit_images.dart';

class ScheduleFitSwitch extends StatefulWidget {
  final Images imageActive;
  final Images imageNotActive;
  final Color colorActive;
  final Color colorNotActive;
  final bool currentValue;
  final Function(bool) onChanged;

  const ScheduleFitSwitch(
      {super.key,
      required this.imageActive,
      required this.imageNotActive,
      required this.colorActive,
      required this.colorNotActive,
      required this.currentValue,
      required this.onChanged});

  @override
  State<ScheduleFitSwitch> createState() => _ScheduleFitSwitchState();
}

class _ScheduleFitSwitchState extends State<ScheduleFitSwitch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      active: true,
      first: false,
      second: true,
      spacing: 5,
      height: 40,
      indicatorSize: const Size(30, 30),
      iconBuilder: (value) => Image(
        image: value
            ? AssetImage(getImage(widget.imageActive))
            : AssetImage(getImage(widget.imageNotActive)),
        width: 38,
        height: 38,
      ),
      customStyleBuilder: (context, local, global) {
        if (global.position <= 0.0) {
          return ToggleStyle(
              backgroundColor: widget.colorNotActive,
              borderColor: Colors.transparent,
              indicatorColor: Colors.transparent);
        }
        return ToggleStyle(
            backgroundGradient: LinearGradient(
              colors: [widget.colorActive, widget.colorNotActive],
              stops: [
                global.position - (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                global.position + max(0, 2 * (global.position - 0.5)) * 0.7,
              ],
            ),
            borderColor: Colors.transparent,
            indicatorColor: Colors.transparent);
      },
      borderWidth: 6.0,
      onChanged: (value) => setState(() {
        widget.onChanged(value);
      }),
      current: widget.currentValue,
    );
  }
}
