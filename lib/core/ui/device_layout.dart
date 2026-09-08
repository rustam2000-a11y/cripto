enum DeviceLayout { mobile, tablet }

extension DeviceLayoutExtension on DeviceLayout {
  bool get isTabletMode => this == DeviceLayout.tablet;

  bool get isMobileMode => this == DeviceLayout.mobile;
}
