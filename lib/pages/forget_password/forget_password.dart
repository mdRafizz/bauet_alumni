import 'package:alumni2/common/custom_text_field.dart';
import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/root/root_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  static const String routeName = '/forgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _email = TextEditingController();

  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: ReusableText(
            'Password reset email sent. Please check your inbox.',
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
      Get.offAllNamed(RootMain.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ReusableText(
            'Failed to send password reset email: $e',
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: Center(
        child: Container(
          width: 800,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ReusableText(
                    'Restore Password',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const ReusableText(
                      'Close',
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const Gap(50),
              CustomTextField(
                controller: _email,
                labelText: 'Email',
              ),
              const Gap(70),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: _sendPasswordResetEmail,
                  child: _isLoading
                      ? LoadingAnimationWidget.threeRotatingDots(
                          color: Colors.black,
                          size: 32,
                        )
                      : const ReusableText(
                          'Send Reset Email',
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
