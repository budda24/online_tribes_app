import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../app/helpers/theme/app_colors.dart';
import '../../app/helpers/theme/text_styles.dart';

class TimeCovertingServices {
  /* convertTimeToTimeZone(String timeZone) {
    return formatTime(time:currantTime);
  } */
  static int CountOffsetHour({required int hour, required int offset}) {
    var tmp = hour + offset;
    if (tmp <= 0) {
      return 24 + tmp;
    } else if (tmp != 24) {
      return tmp % 24;
    }
    return 24;
  }

  Future<dynamic> getCustomTimeRangePicker(BuildContext context) async {
    return await showTimeRangePicker(
        interval: const Duration(hours: 1),
        minDuration: const Duration(hours: 1),
        use24HourFormat: true,
        maxDuration: const Duration(hours: 6),
        padding: 30,
        strokeWidth: 20,
        handlerRadius: 14,
        strokeColor: AppColors.actionColor,
        handlerColor: AppColors.actionColor.withOpacity(0.7),
        selectedColor: AppColors.actionColor,
        backgroundColor: AppColors.primaryColor,
        ticks: 24,
        ticksColor: AppColors.actionColor,
        snap: true,
        context: context,
        timeTextStyle: tribalFontLable,
        activeTimeTextStyle: tribalFontLableWhite);
  }
}
