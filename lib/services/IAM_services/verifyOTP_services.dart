import 'package:get/get.dart';

import 'package:ssipl_billing/controllers/IAM_actions.dart';
import 'package:ssipl_billing/models/entities/IAM_entities.dart';
import 'package:ssipl_billing/views/screens/IAM/IAM.dart';

import '../../models/constants/api.dart';

import '../../views/components/Basic_DialogBox.dart';
import '../APIservices/invoker.dart';

mixin VerifyotpServices {
  final ForgotpasswordController forgotpasswordController = Get.put(ForgotpasswordController());
  final VerifyOTPControllers VerifyOTPController = Get.put(VerifyOTPControllers());
  final Invoker apiController = Get.put(Invoker());

  void Verify_OTP(context) async {
    try {
      Map<String, dynamic>? response = await apiController.IAM({
        "username": forgotpasswordController.forgotpasswordModel.emailController.value.text,
        "OTP": VerifyOTPController.verifyOTPModel.otpControllers.map((controller) => controller.text).join(),
      }, API.verifyOTP_API);

      if (response?['statusCode'] == 200) {
        VerifyOTP_Response data = VerifyOTP_Response.fromJson(response!);
        if (data.code) {
          VerifyOTPController.toggleIndicator(false);
          IAM.Page_name = 'Setnewpassword';
          IAM.update();
        } else {
          VerifyOTPController.toggleIndicator(false);
          await Basic_dialog(context: context, title: 'VerifyOTP Failed', content: data.message ?? "", onOk: () {});
        }
      } else {
        Basic_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
