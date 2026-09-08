import 'package:flutter/widgets.dart';

import 'device_layout.dart';

class UiProvider extends ChangeNotifier {
  static const _tabletBreakpoint = 600.0;

  DeviceLayout _deviceLayout = DeviceLayout.mobile;

  DeviceLayout get deviceLayout => _deviceLayout;

  void updateLayout(BuildContext context) {
    final shortestSide = MediaQuery.sizeOf(context).shortestSide;
    final layout = shortestSide >= _tabletBreakpoint
        ? DeviceLayout.tablet
        : DeviceLayout.mobile;

    if (layout == _deviceLayout) return;
    _deviceLayout = layout;
    notifyListeners();
  }
}
