import 'package:get/get.dart';

import 'package:ssipl_billing/models/entities/IAM_entities.dart';

import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../models/entities/Response_entities.dart';
import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

class NewpasswordServices {
  final NewpasswordController newwordController = Get.find<NewpasswordController>();
  final ForgotpasswordController forgotpasswordController = Get.find<ForgotpasswordController>();
  final IAMController IamController = Get.find<IAMController>();
  final Invoker apiController = Get.find<Invoker>();
  void Newpassword(context) async {
    try {
      NewPassword_Request requestData = NewPassword_Request(
        username: forgotpasswordController.forgotpasswordModel.emailController.value.text,
        password: newwordController.newpasswordModel.confirmController.value.text,
      );

      Map<String, dynamic>? response = await apiController.IAM(requestData.toJson(), API.newpassword_API);

      if (response?['statusCode'] == 200) {
        CMResponse data = CMResponse.fromJson(response!);
        if (data.code) {
          forgotpasswordController.toggleIndicator(false);
          IamController.IAMModel.pagename.value = 'Login';
        } else {
          forgotpasswordController.toggleIndicator(false);
          await Basic_dialog(
            context: context,
            title: 'New Password Failed',
            content: data.message ?? "",
            onOk: () {},
          );
        }
      } else {
        forgotpasswordController.toggleIndicator(false);
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      forgotpasswordController.toggleIndicator(false);
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
