import 'package:get/get.dart';
import '../../../controllers/SALEScontrollers/ClientReq_actions.dart';
import '../../../views/components/Basic_DialogBox.dart';

mixin ClientreqdetailsService {
  final ClientreqController clientreqController = Get.find<ClientreqController>();
  void add_details(context) {
    if (clientreqController.clientReqModel.detailsformKey.value.currentState?.validate() ?? false) {
      if (clientreqController.clientReqModel.pickedFile.value != null) {
        clientreqController.nextTab();
      } else {
        Basic_dialog(
          context: context,
          title: 'Please add a MOR referene',
          content: "",
          onOk: () {},
        );
      }
    }
  }
}
