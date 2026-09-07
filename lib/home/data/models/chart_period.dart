import 'package:flutter/widgets.dart';

import '../../../generated/l10n.dart';

enum ChartPeriod {
  day(days: 1),
  week(days: 7),
  year(days: 365);

  const ChartPeriod({required this.days});

  final int days;

  String label(BuildContext context) {
    switch (this) {
      case ChartPeriod.day:
        return S.of(context).Hour;
      case ChartPeriod.week:
        return S.of(context).week;
      case ChartPeriod.year:
        return S.of(context).year;
    }
  }
}
