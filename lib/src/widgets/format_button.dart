// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared/utils.dart' show CalendarFormat;

class FormatButton extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final ValueChanged<CalendarFormat> onTap;
  final TextStyle textStyle;
  final BoxDecoration decoration;
  final EdgeInsets padding;
  final bool showsNextFormat;
  final Map<CalendarFormat, Widget> availableCalendarFormats;

  const FormatButton({
    Key? key,
    required this.calendarFormat,
    required this.onTap,
    required this.textStyle,
    required this.decoration,
    required this.padding,
    required this.showsNextFormat,
    required this.availableCalendarFormats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = showsNextFormat
        ? availableCalendarFormats[_nextFormat()]
        : availableCalendarFormats[calendarFormat];

    final platform = Theme.of(context).platform;

    return !kIsWeb &&
            (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS)
        ? CupertinoButton(
            onPressed: () => onTap(_nextFormat()),
            padding: EdgeInsets.zero,
            minSize: 0,
            child: child ?? SizedBox(),
          )
        : InkWell(
            borderRadius:
                decoration.borderRadius?.resolve(Directionality.of(context)),
            onTap: () => onTap(_nextFormat()),
            child: child,
          );
  }

  CalendarFormat _nextFormat() {
    final formats = availableCalendarFormats.keys.toList();
    int id = formats.indexOf(calendarFormat);
    id = (id + 1) % formats.length;

    return formats[id];
  }
}
