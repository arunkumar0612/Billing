import 'package:get/get.dart';

import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import '../../controllers/IAM_actions.dart';
import '../../models/constants/api.dart';
import '../../models/entities/Response_entities.dart';

import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

mixin ForgotpasswordService {
  final IAMController IamController = Get.find<IAMController>();
  final ForgotpasswordController forgotpasswordController = Get.find<ForgotpasswordController>();
  final Invoker apiController = Get.find<Invoker>();
  void Forgotpassword(context) async {
    try {
      Forgotpassword_Request requestData = Forgotpassword_Request(
        username: forgotpasswordController.forgotpasswordModel.emailController.value.text,
      );

      Map<String, dynamic>? response = await apiController.IAM(requestData.toJson(), API.forgotpassword_API);

      if (response?['statusCode'] == 200) {
        CMResponse data = CMResponse.fromJson(response!);
        if (data.code) {
          forgotpasswordController.toggleIndicator(false);
          IamController.IAMModel.pagename.value = 'OTPverification';
        } else {
          forgotpasswordController.toggleIndicator(false);
          await Basic_dialog(
            context: context,
            showCancel: false,
            title: 'Forgot Password Failed',
            content: data.message ?? "",
            onOk: () {},
          );
        }
      } else {
        forgotpasswordController.toggleIndicator(false);
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      forgotpasswordController.toggleIndicator(false);
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
}
