import 'package:get/get.dart';
import 'package:ssipl_billing/IAM-/models/entities/IAM_entities.dart';

import '../../API-/api.dart';
import '../../API-/invoker.dart';
import '../../COMPONENTS-/Basic_DialogBox.dart';
import '../../COMPONENTS-/Response_entities.dart';
import '../controllers/IAM_actions.dart';

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
          await Error_dialog(
            context: context,
            // showCancel: false,
            title: 'Forgot Password Failed',
            content: data.message ?? "",
            onOk: () {},
          );
        }
      } else {
        forgotpasswordController.toggleIndicator(false);
        Error_dialog(context: context, title: "SERVER DOWN", content: "Please contact administration!");
      }
    } catch (e) {
      forgotpasswordController.toggleIndicator(false);
      Error_dialog(context: context, title: "ERROR", content: "$e");
    }
  }
}
