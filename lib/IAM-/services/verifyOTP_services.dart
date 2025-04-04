import 'package:get/get.dart';
import 'package:ssipl_billing/IAM-/models/entities/IAM_entities.dart';

import '../../API-/api.dart';
import '../../API-/invoker.dart';
import '../../COMPONENTS-/Basic_DialogBox.dart';
import '../../COMPONENTS-/Response_entities.dart';
import '../controllers/IAM_actions.dart';

mixin VerifyotpServices {
  final IAMController IamController = Get.find<IAMController>();
  final ForgotpasswordController forgotpasswordController = Get.find<ForgotpasswordController>();
  final VerifyOTPControllers VerifyOTPController = Get.find<VerifyOTPControllers>();
  final Invoker apiController = Get.find<Invoker>();

  void Verify_OTP(context) async {
    try {
      VerifyOTP_Request requestData = VerifyOTP_Request(
        username: forgotpasswordController.forgotpasswordModel.emailController.value.text,
        otp: VerifyOTPController.verifyOTPModel.otpControllers.map((controller) => controller.text).join(),
      );

      Map<String, dynamic>? response = await apiController.IAM(requestData.toJson(), API.verifyOTP_API);

      if (response?['statusCode'] == 200) {
        CMResponse data = CMResponse.fromJson(response!);
        if (data.code) {
          VerifyOTPController.toggleIndicator(false);
          IamController.IAMModel.pagename.value = 'Setnewpassword';
        } else {
          VerifyOTPController.toggleIndicator(false);
          await Basic_dialog(
            context: context,
            showCancel: false,
            title: 'Verify OTP Failed',
            content: data.message ?? "",
            onOk: () {},
          );
        }
      } else {
        Basic_dialog(context: context, showCancel: false, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      Basic_dialog(context: context, showCancel: false, title: "ERROR", content: "$e");
    }
  }
}
