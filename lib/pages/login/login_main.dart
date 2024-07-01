import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/home/home_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key, required this.name, required this.studentId});

  final String name;
  final String studentId;

  static const String routeName = '/login';

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  void initState() {
    super.initState();
  }

  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: Center(
        child: Container(
          width: 600,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20),
              const ReusableText(
                'Log In',
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              const Gap(50),
              Container(
                width: 500,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextFormField(
                  controller: _email,
                  decoration: _inputDecoration(
                    'Email',
                  ),
                  // initialValue:
                  //     _selectedStudent!
                  //         .email,
                  // readOnly: true,
                ),
              ),
              const Gap(35),
              Container(
                width: 500,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextFormField(
                  obscureText: true,
                  controller: _password,
                  decoration: _inputDecoration(
                    'Password',
                  ),
                  // initialValue:
                  //     _selectedStudent!
                  //         .email,
                  // readOnly: true,
                ),
              ),
              const Gap(45),
              MaterialButton(
                onPressed: _login,
                color: Colors.blue,
                height: 65,
                minWidth: 500,
                child: _isLoading
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 32,
                        ),
                      )
                    : const ReusableText(
                        'Log In',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
              ),
              const Gap(25),
            ],
          ),
        ),
      ),
    );
  }

  void _errorDialogue(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            width: 400.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  msg,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
      );

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          const uuid = Uuid();
          final id = uuid.v1();

          FirebaseFirestore.instance.collection('users').doc(user.email).set({
            'profilePictureUrl':
                "https://firebasestorage.googleapis.com/v0/b/bauet-alumni-3504f.appspot.com/o/profile_pictures%2F6769264_60111.jpg?alt=media&token=53736915-f636-4f0c-8ca7-2ef400cf67f8",
            'coverPictureUrl':
                "https://firebasestorage.googleapis.com/v0/b/bauet-alumni-3504f.appspot.com/o/cover_pictures%2F4547.jpg?alt=media&token=026d1e5c-ec90-4c29-aeab-9d6fd33ae8a3",
            'id': id,
            'firstName': widget.name,
            'lastName': '',
            'phoneNumber': '',
            'email': user.email,
            'studentId': widget.studentId,
            'password': _password.text,
            'role': 'user',
            'sscInstitution': '',
            'sscDuration': '',
            'hscInstitution': '',
            'hscDuration': '',
            'bscInstitution': '',
            'bscDuration': '',
            'bscDegree': '',
            'mscInstitution': '',
            'mscDuration': '',
            'mscDegree': '',
            'phdInstitution': '',
            'phdDuration': '',
            'phdSubject': '',
            'currentStatus': '',
            'experiencePosition': '',
            'institute': '',
            'dob': '',
            'bloodGroup': '',
            'hometown': '',
            'whatsappNumber': '',
            'wantToMentor': "No",
            'mentorOfferings': [],
          }, SetOptions(merge: true));

          Get.offAllNamed(HomeMain.routeName);
        } else {
          _errorDialogue(context, 'Please verify your email before logging.');
          await FirebaseAuth.instance
              .signOut(); // Sign out the user if email is not verified
        }
      }
    } catch (e) {
      _errorDialogue(context, 'Failed to login: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
