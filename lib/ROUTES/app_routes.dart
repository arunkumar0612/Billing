import 'package:get/get.dart';
import 'package:ssipl_billing/IAM/views/IAM.dart';

// import 'package:ssipl_billing/IAM/views/IAM.dart';

import '../home.dart';
import 'route_names.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RouteNames.IAM, page: () => const IAM()),
    GetPage(name: RouteNames.home, page: () => const MyHomePage()),
  ];
}
