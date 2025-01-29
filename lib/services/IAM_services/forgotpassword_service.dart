import 'package:get/get.dart';

import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../routes/route_names.dart';

import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

mixin ForgotpasswordService {
  final ForgotpasswordController forgotpasswordController = Get.put(ForgotpasswordController());
  final Invoker apiController = Get.put(Invoker());
  void Forgotpassword(context) async {
    try {
      Map<String, dynamic>? response = await apiController.IAM({
        "username": forgotpasswordController.forgotpasswordModel.emailController.value.text,
      }, API.forgotpassword_API);

      if (response?['statusCode'] == 200) {
        Forgotpassword_Response data = Forgotpassword_Response.fromJson(response!);
        if (data.code) {
          forgotpasswordController.toggleIndicator(false);
          Get.toNamed(RouteNames.home);
        } else {
          forgotpasswordController.toggleIndicator(false);
          await Basic_dialog(context: context, title: 'Forgotpassword Failed', content: data.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
