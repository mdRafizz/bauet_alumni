import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/root/root_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ErrorMain extends StatelessWidget {
  const ErrorMain({
    super.key,
    required this.errorMsg,
  });

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: Center(
        child: Container(
          width: 800,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(vertical: 30),
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error.jpg',
                  height: 200,
                ),
                ReusableText(
                  errorMsg,
                  fontSize: 17,
                  textAlign: TextAlign.center,
                ),
                const Gap(50),
                OutlinedButton(
                  onPressed: () => Get.offAllNamed(
                    RootMain.routeName,
                  ),
                  child: const ReusableText(
                    'Home',
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
