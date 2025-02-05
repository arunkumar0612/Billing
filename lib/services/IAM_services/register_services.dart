import 'package:get/get.dart';

import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../models/entities/Response_entities.dart';
import '../../routes/route_names.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

class RegisterServices {
  final RegisterController registerController = Get.find<RegisterController>();
  final Invoker apiController = Get.find<Invoker>();

  void Register(context) async {
    try {
      Register_Request requestData = Register_Request(
        name: registerController.registerModel.nameController.value.text,
        emailid: registerController.registerModel.emailController.value.text,
        phoneno: registerController.registerModel.phoneController.value.text,
        password: registerController.registerModel.passwordController.value.text,
      );

      Map<String, dynamic>? response = await apiController.IAM(requestData.toJson(), API.Register_API);

      if (response?['statusCode'] == 200) {
        CMResponse data = CMResponse.fromJson(response!);
        if (data.code) {
          registerController.toggleIndicator(false);
          await Basic_dialog(
            context: context,
            title: 'Please click the link to verify on your Mail',
            content: data.message ?? "",
            onOk: () {
              registerController.registerModel.nameController.value.clear();
              registerController.registerModel.emailController.value.clear();
              registerController.registerModel.phoneController.value.clear();
              registerController.registerModel.passwordController.value.clear();
              registerController.registerModel.confirmController.value.clear();
            },
          );
          registerController.toggleIndicator(true);
          Get.toNamed(RouteNames.login);
        } else {
          registerController.toggleIndicator(false);
          await Basic_dialog(context: context, title: 'Register Failed', content: data.message ?? "", onOk: () {});
        }
      } else {
        registerController.toggleIndicator(false);
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      registerController.toggleIndicator(false);
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
