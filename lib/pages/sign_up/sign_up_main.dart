import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/sign_up/info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class SignUpMain extends StatefulWidget {
  const SignUpMain({super.key});

  static const routeName = '/signUp';

  @override
  createState() => _SignupFormState();
}

class _SignupFormState extends State<SignUpMain> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> usersData = []; // Corrected type here
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  var _isFileUploading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection('students').get();

    setState(() {
      usersData = querySnapshot.docs
          .map((DocumentSnapshot document) =>
              document.data() as Map<String, dynamic>)
          .toList();
    });
  }

  bool isUserExist(String email, String phone, String id) {
    for (var user in usersData) {
      if (user['email'] == email &&
          user['phone'] == phone &&
          user['id'] == id) {
        return true;
      }
    }
    return false;
  }

  var _isImageFetched = false;
  var _isImageFetched2 = false;
  FilePickerResult? _picked;
  FilePickerResult? _picked2;
  var _obscureText = true;
  bool? _isTermsAndConditionChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(25),
                Image.asset(
                  'assets/icons/bauet_logo.png',
                  height: 55,
                ),
                const Gap(15),
                Container(
                  width: 600,
                  // height: 40.sp,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF0D0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      // text: 'Hello ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Only '),
                        TextSpan(
                          text: 'BAUET Alumni Association',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                ' members and eligible people are entitled to create an account or sign up here'),
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      /************* Sign up        or login *****************************************/
                      Row(
                        children: [
                          const Gap(15),
                          const ReusableText('Sign up', fontSize: 16),
                          const Spacer(),
                          const ReusableText('or',
                              fontSize: 12, color: Colors.grey),
                          const Gap(12),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                            ),
                            onPressed: () {},
                            child: const ReusableText('login',
                                color: Colors.blue, fontSize: 15),
                          ),
                          const Gap(15),
                        ],
                      ),
                      const Gap(18),

                      /// Cover Photo Section
                      InkWell(
                        onTap: () async {
                          _picked2 = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            compressionQuality: 100,
                            // allowCom/pression: false,
                          );
                          if (_picked2 != null) {
                            setState(() {
                              _isImageFetched2 = true;
                            });
                          }
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 2,
                          child: _isImageFetched2
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    _picked2!.files.first.bytes!,
                                    height: 90,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  height: 90,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue.shade100,
                                  ),
                                  alignment: Alignment.center,
                                  child:
                                      const ReusableText('Select cover photo'),
                                ),
                        ),
                      ),
                      const Gap(25),

                      /**************** Profile Picture Select section *************/
                      InkWell(
                        onTap: () async {
                          _picked = await FilePicker.platform.pickFiles(
                              type: FileType.image, compressionQuality: 100);
                          if (_picked != null) {
                            setState(() {
                              _isImageFetched = true;
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /********** Profile Pic avatar ************************************/
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: _isImageFetched
                                  ? Image.memory(_picked!.files.first.bytes!)
                                      .image
                                  : Image.asset(
                                      'assets/images/user_img.png',
                                      fit: BoxFit.cover,
                                    ).image,
                            ),
                            const Gap(15),
                            const ReusableText(
                              'Select a recognizable photo',
                              fontSize: 14,
                            )
                          ],
                        ),
                      ),
                      /**************** Sign up form ********************/
                      const Gap(18),
                      /**************** First name and Last name ********************/
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'First Name',
                                // hintText: 'First Name',
                                // hintStyle: TextStyle(
                                //   fontSize: 15,
                                // ),
                              ),
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: TextField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // hintText: 'Last Name',
                                labelText: 'Last Name',
                                // hintStyle: GoogleFonts.poppins(
                                //   fontSize: 12.sp,
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(18),
                      /**************** Phone number picker ********************/
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: CountryCodePicker(
                      //         initialSelection: '+880',
                      //         // favorite: ['+880',],
                      //         dialogSize: Size(70, 70),
                      //         searchDecoration: InputDecoration(
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //           ), // hintStyle: GoogleFonts.poppins(
                      //           //   fontSize: 11.sp,
                      //           // ),
                      //           hintText: 'Search a country',
                      //         ),
                      //         // textStyle: GoogleFonts.poppins(
                      //         //   fontSize: 12.sp,
                      //         // ),
                      //         // dialogTextStyle: GoogleFonts.poppins(
                      //         //   fontSize: 12.sp,
                      //         // ),
                      //       ),
                      //     ),
                      //     const Gap(18),
                      //     const Expanded(
                      //       flex: 2,
                      //       child: TextField(
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           hintText: 'Phone number',
                      //           // hintStyle: GoogleFonts.poppins(
                      //           //   fontSize: 12.sp,
                      //           // ),
                      //         ),
                      //         keyboardType: TextInputType.number,
                      //       ),
                      //     ),
                      //   ],
                      // ),Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: CountryCodePicker(
                      //         initialSelection: '+880',
                      //         // favorite: ['+880',],
                      //         dialogSize: Size(70, 70),
                      //         searchDecoration: InputDecoration(
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //           ), // hintStyle: GoogleFonts.poppins(
                      //           //   fontSize: 11.sp,
                      //           // ),
                      //           hintText: 'Search a country',
                      //         ),
                      //         // textStyle: GoogleFonts.poppins(
                      //         //   fontSize: 12.sp,
                      //         // ),
                      //         // dialogTextStyle: GoogleFonts.poppins(
                      //         //   fontSize: 12.sp,
                      //         // ),
                      //       ),
                      //     ),
                      //     const Gap(18),
                      //     const Expanded(
                      //       flex: 2,
                      //       child: TextField(
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           hintText: 'Phone number',
                      //           // hintStyle: GoogleFonts.poppins(
                      //           //   fontSize: 12.sp,
                      //           // ),
                      //         ),
                      //         keyboardType: TextInputType.number,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // hintText: 'Phone number',
                          labelText: 'Phone number',
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const Gap(18),
                      /**************** Email address ********************/
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // hintText: 'Email address',
                          labelText: 'Email address',
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(18),
                      TextField(
                        controller: _studentIdController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // hintText: 'Student ID',
                          labelText: 'Student ID',
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const Gap(18),
                      /**************** password ********************/
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // hintText: 'Password',
                          labelText: 'Password',
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  if (_obscureText) {
                                    _obscureText = false;
                                  } else {
                                    _obscureText = true;
                                  }
                                },
                              );
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 18,
                              color: Colors.black,
                            ),
                            style: IconButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                      const Gap(18),
                      /**************** confirm password ********************/
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // hintText: 'Confirm password',
                          labelText: 'Confirm password',
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  if (_obscureText) {
                                    _obscureText = false;
                                  } else {
                                    _obscureText = true;
                                  }
                                },
                              );
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 15,
                              color: Colors.black,
                            ),
                            style: IconButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                      const Gap(18),
                      /**************** accepting Terms and condition ********************/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _isTermsAndConditionChecked,
                            onChanged: (isChecked) {
                              setState(
                                () {
                                  _isTermsAndConditionChecked = isChecked;
                                },
                              );
                            },
                          ),
                          const Gap(15),
                          RichText(
                            text: const TextSpan(
                              // text: 'Hello ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'I accept to the '),
                                TextSpan(
                                  text: 'Terms & conditions',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(18),
                      /**************** Sign up button ********************/
                      MaterialButton(
                        minWidth: 600,
                        onPressed: _uploadData,
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _isFileUploading
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 32,
                                ),
                              )
                            : const ReusableText(
                                'Next',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    ],
                  ),
                ),
                const Gap(35),
              ],
            ),
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

  Future<void> _uploadData() async {
    try {
      if (_picked == null ||
          _picked2 == null ||
          _firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _phoneNumberController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _studentIdController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        // Show an error message if any field is empty
        _errorDialogue(
            context, 'Please fill in all fields and select a profile picture.');
        return;
      } else if (!_emailController.text.contains('@')) {
        _errorDialogue(context, 'Email address not formatted correctly');
        return;
      } else if (!isUserExist(_emailController.text,
          _phoneNumberController.text, _studentIdController.text)) {
        _errorDialogue(
          context,
          'The email address or student id or phone number you entered is not found in our system. Please check and try again.',
        );
        return;
      } else if (_passwordController.text != _confirmPasswordController.text) {
        // Show an error message if passwords do not match
        _errorDialogue(context, 'Passwords do not match.');
        return;
      } else if (_passwordController.text.length < 8) {
        _errorDialogue(context, 'Make sure password length is at least 8.');
        return;
      } else {
        setState(() {
          _isFileUploading = true;
        });
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        Reference ref = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child('${_emailController.text}_profile_picture');
        UploadTask uploadTask = ref.putData(_picked!.files.first.bytes!);
        TaskSnapshot snapshot = await uploadTask;
        String profilePictureUrl = await snapshot.ref.getDownloadURL();

        Reference ref2 = FirebaseStorage.instance
            .ref()
            .child('cover_pictures')
            .child('${_emailController.text}_cover_picture');
        UploadTask uploadTask2 = ref2.putData(_picked2!.files.first.bytes!);
        TaskSnapshot snapshot2 = await uploadTask2;
        String coverPictureUrl = await snapshot2.ref.getDownloadURL();

        const uuid = Uuid();
        final id = uuid.v1();

        // Create user document in Firestore
        Map<String, dynamic> userData = {
          'id': id,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phoneNumber': _phoneNumberController.text,
          'email': _emailController.text,
          'studentId': _studentIdController.text,
          'profilePictureUrl': profilePictureUrl,
          'password': _passwordController.text,
          'coverPictureUrl': coverPictureUrl,
          'role': 'user'
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_emailController.text)
            .set(userData)
            .then((_) {
          setState(() {
            _isFileUploading = false;
          });
          Get.offAllNamed(PersonalInfoScreen.routeName, arguments: {
            'email': _emailController.text,
          });
        });
      }

      // final storage = FirebaseStorage.instance;
      // Upload profile picture to Firebase Storage
    } on FirebaseAuthException catch (e) {
      if (_isFileUploading) {
        setState(() {
          _isFileUploading = false;
        });
      }
      if (mounted) {
        _errorDialogue(context, e.toString());
      } else {
        Get.dialog(
          Container(
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
                  e.message.toString(),
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
      }
    }
  }
}
