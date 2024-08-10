import 'package:flutter/material.dart';

enum ScreenMode {
  mobile,
  tablet,
  desktop;
}

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.desktopScreenWidth = 800,
    this.mobileScreenWidth = 450,
    this.useMobileUiAsDefault = true,
    this.onScreenChanged,
  }) : super(key: key);

  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final double desktopScreenWidth;
  final double mobileScreenWidth;
  final bool useMobileUiAsDefault;
  final ValueChanged<ScreenMode>? onScreenChanged;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileScreenWidth;
  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < desktopScreenWidth && width >= mobileScreenWidth;
  }

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopScreenWidth;

  Widget ui(String platform) => Scaffold(
        body: Center(
          child: Text(
            platform,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // print("MAX WIDTH ${constraints.maxWidth}");
      if (useMobileUiAsDefault) {
        if (constraints.maxWidth >= desktopScreenWidth) {
          onScreenChanged?.call(ScreenMode.desktop);
          return desktop ?? (tablet ?? (mobile ?? ui("Desktop UI")));
        } else if (constraints.maxWidth >= mobileScreenWidth) {
          onScreenChanged?.call(ScreenMode.tablet);
          return tablet ?? (mobile ?? ui("Tablet ui"));
        } else {
          onScreenChanged?.call(ScreenMode.mobile);
          return mobile ?? ui("Mobile UI");
        }
      } else {
        if (constraints.maxWidth >= desktopScreenWidth) {
          onScreenChanged?.call(ScreenMode.desktop);
          return desktop ?? (tablet ?? ui("Desktop UI"));
        } else if (constraints.maxWidth >= mobileScreenWidth) {
          onScreenChanged?.call(ScreenMode.tablet);
          return tablet ?? ui("Tablet UI");
        } else {
          onScreenChanged?.call(ScreenMode.mobile);
          return mobile ?? ui("Mobile UI");
        }
      }
    });
  }
}

mixin ResponsiveWidgetMixin {
  ScreenMode screenMode = ScreenMode.mobile;

  VoidCallback onScreenChanged = () {};

  void setScreenMode(ScreenMode value) {
    if (screenMode == value) {
      return;
    }
    screenMode = value;
    onScreenChanged();
  }

  bool get isMobile => screenMode == ScreenMode.mobile;
  bool get isDesktop => screenMode == ScreenMode.desktop;
  bool get isTablet => screenMode == ScreenMode.tablet;
}

class MobileUi extends StatelessWidget {
  const MobileUi({Key? key, this.ios, this.android}) : super(key: key);

  final Widget? ios;
  final Widget? android;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
