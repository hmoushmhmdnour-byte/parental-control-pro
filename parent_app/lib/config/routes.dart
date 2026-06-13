import 'package:get/get.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String childDetail = '/child-detail';
  static const String location = '/location';
  static const String apps = '/apps';
  static const String screenTime = '/screen-time';
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String settings = '/settings';
  static const String addChild = '/add-child';
  static const String editChild = '/edit-child';
  static const String profile = '/profile';

  // Routes pages
  static List<GetPage> pages = [
    // Splash
    GetPage(
      name: splash,
      page: () => Container(), // سيتم استبداله بـ SplashScreen
    ),
    // Auth Routes
    GetPage(
      name: login,
      page: () => Container(), // سيتم استبداله بـ LoginScreen
    ),
    GetPage(
      name: register,
      page: () => Container(), // سيتم استبداله بـ RegisterScreen
    ),
    GetPage(
      name: forgotPassword,
      page: () => Container(), // سيتم استبداله بـ ForgotPasswordScreen
    ),
    // Main Routes
    GetPage(
      name: dashboard,
      page: () => Container(), // سيتم استبداله بـ ParentDashboard
    ),
    GetPage(
      name: childDetail,
      page: () => Container(), // سيتم استبداله بـ ChildDetailScreen
    ),
    GetPage(
      name: location,
      page: () => Container(), // سيتم استبداله بـ LocationScreen
    ),
    GetPage(
      name: apps,
      page: () => Container(), // سيتم استبداله بـ AppsScreen
    ),
    GetPage(
      name: screenTime,
      page: () => Container(), // سيتم استبداله بـ ScreenTimeScreen
    ),
    GetPage(
      name: notifications,
      page: () => Container(), // سيتم استبداله بـ NotificationsScreen
    ),
    GetPage(
      name: messages,
      page: () => Container(), // سيتم استبداله بـ MessagesScreen
    ),
    GetPage(
      name: settings,
      page: () => Container(), // سيتم استبداله بـ SettingsScreen
    ),
    GetPage(
      name: addChild,
      page: () => Container(), // سيتم استبداله بـ AddChildScreen
    ),
    GetPage(
      name: editChild,
      page: () => Container(), // سيتم استبداله بـ EditChildScreen
    ),
    GetPage(
      name: profile,
      page: () => Container(), // سيتم استبداله بـ ProfileScreen
    ),
  ];
}
