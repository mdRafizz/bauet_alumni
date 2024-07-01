import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SharePostController extends GetxController{
  var textEditingController = TextEditingController().obs;
  var isThereText = false.obs;

  showSendIcon(String text){
    if(text != ''){
      isThereText.value = true;
      update();
    }else{
      isThereText.value = false;
      update();
    }
  }
  @override
  void onInit() {
    textEditingController.value.text = '';
    super.onInit();
  }
}