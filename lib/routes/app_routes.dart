import 'package:get/get.dart';
import 'package:ssipl_billing/views/screens/homepage/IAM.dart';
import '../home.dart';
import 'route_names.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RouteNames.login, page: () => const IAM()),
    GetPage(name: RouteNames.home, page: () => const MyHomePage()),
  ];
}
