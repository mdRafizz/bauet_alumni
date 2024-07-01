import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/error/error_main.dart';
import 'package:alumni2/pages/login/login_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../data/model/student_model.dart';

class SignUpNew extends StatefulWidget {
  const SignUpNew({super.key});

  static const routeName = '/signUp';

  @override
  createState() => _SignUpNewState();
}

class _SignUpNewState extends State<SignUpNew> {
  List<Student> students = [];
  List<String> batches = [];
  List<String> departments = [];
  String? selectedDept;
  String? selectedBatch;
  String? isEmailCorrect;
  bool _loadingDept = false;
  bool _loadingBatch = false;
  bool _loadingStudent = false;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _id, _name;
  Student? _selectedStudent;

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingDept
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.black,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  width: 800,
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(38),
                      Center(
                        child: Image.asset(
                          'assets/icons/bauet_logo.png',
                          height: 55,
                        ),
                      ),
                      const Gap(28),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 23,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF0D0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              // text: 'Hello ',
                              style: TextStyle(
                                fontSize: 17,
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
                                      ' members and eligible people are entitled to create an account or sign up here',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 25.0,
                          top: 40,
                        ),
                        child: ReusableText(
                          'Select Department',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45.0,
                          vertical: 16,
                        ),
                        child: SizedBox(
                          width: 400,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Select Department',
                            ),
                            items: departments.map((String dept) {
                              return DropdownMenuItem<String>(
                                value: dept,
                                child: Text(
                                  dept.toUpperCase(),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDept = value;
                                selectedBatch = null;
                                batches = [];
                                students = [];
                                fetchBatches();
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a department'
                                : null,
                          ),
                        ),
                      ),
                      _loadingBatch
                          ? Center(
                              child: LoadingAnimationWidget.inkDrop(
                                color: Colors.black,
                                size: 30,
                              ),
                            )
                          : batches.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 25.0,
                                        top: 40,
                                      ),
                                      child: ReusableText(
                                        'Select Department',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 45.0,
                                        vertical: 16,
                                      ),
                                      child: SizedBox(
                                        width: 400,
                                        child: DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            labelText: 'Select Batch',
                                          ),
                                          items: batches.map((String batch) {
                                            return DropdownMenuItem<String>(
                                              value: batch,
                                              child: Text(batch),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedBatch = value;
                                              fetchStudents();
                                            });
                                          },
                                          validator: (value) => value == null
                                              ? 'Please select a batch'
                                              : null,
                                          value: selectedBatch,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                      if (selectedDept == null || selectedBatch == null)
                        const SizedBox(
                          height: 400,
                          child: Center(
                            child: ReusableText(
                              'Please select a department and batch',
                              fontSize: 14,
                            ),
                          ),
                        )
                      else
                        _loadingStudent
                            ? SizedBox(
                                height: 400,
                                child: Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              )
                            : students.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  CupertinoColors.systemGrey5,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            width: 500,
                                            child: TextFormField(
                                              controller: _idController,
                                              decoration: _inputDecoration(
                                                'Student ID',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter ID';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _id = value;
                                              },
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
                                              color:
                                                  CupertinoColors.systemGrey5,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: TextFormField(
                                              controller: _nameController,
                                              decoration: _inputDecoration(
                                                'Full Name',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Name';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _name = value;
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          MaterialButton(
                                            color: Colors.blue,
                                            height: 60,
                                            minWidth: 500,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            onPressed: _validateAndProceed,
                                            child: const ReusableText(
                                              'Validate',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (_selectedStudent != null)
                                            _selectedStudent!.email.isNotEmpty
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Gap(35),
                                                      const ReusableText(
                                                        'Please confirm your email:',
                                                        fontSize: 17,
                                                      ),
                                                      const Gap(20),
                                                      ReusableText(
                                                        _obfuscatedEmail(
                                                          _selectedStudent!
                                                              .email,
                                                        ),
                                                        fontSize: 17,
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                      Container(
                                                        width: 500,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 2,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: CupertinoColors
                                                              .systemGrey5,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                        child: TextFormField(
                                                          controller: _email,
                                                          decoration:
                                                              _inputDecoration(
                                                            'Email',
                                                          ),
                                                          // initialValue:
                                                          //     _selectedStudent!
                                                          //         .email,
                                                          // readOnly: true,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      MaterialButton(
                                                        color: Colors.blue,
                                                        height: 60,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            9,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (_email
                                                              .text.isEmpty) {
                                                            setState(() {
                                                              isEmailCorrect =
                                                                  'Please enter your email';
                                                            });
                                                          }
                                                          if (_email.text !=
                                                              _selectedStudent!
                                                                  .email) {
                                                            Get.offAll(
                                                              () =>
                                                                  const ErrorMain(
                                                                errorMsg:
                                                                    'There appears to be a discrepancy between the email address you provided and the one associated with the uploaded. If you have recently changed your email address, please contact our administrator, Ohiduzaman Pranto, at ohid.pranto2016@gmail.com, to update your information.',
                                                              ),
                                                            );
                                                          }
                                                          if (_email.text ==
                                                              _selectedStudent!
                                                                  .email) {
                                                            setState(
                                                              () {
                                                                isEmailCorrect =
                                                                    'yes';
                                                              },
                                                            );
                                                          }
                                                        },
                                                        minWidth: 500,
                                                        child:
                                                            const ReusableText(
                                                          'Proceed',
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const Gap(45),
                                                      if (isEmailCorrect !=
                                                          null)
                                                        if (isEmailCorrect ==
                                                            'yes') ...[
                                                          Container(
                                                            width: 500,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                              vertical: 2,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: CupertinoColors
                                                                  .systemGrey5,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                3,
                                                              ),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _password,
                                                              obscureText: true,
                                                              decoration:
                                                                  _inputDecoration(
                                                                'Password',
                                                              ),
                                                            ),
                                                          ),
                                                          const Gap(50),
                                                          MaterialButton(
                                                            onPressed: _signUp,
                                                            color: Colors.blue,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                9,
                                                              ),
                                                            ),
                                                            minWidth: 500,
                                                            height: 70,
                                                            child: _isLoading
                                                                ? LoadingAnimationWidget
                                                                    .staggeredDotsWave(
                                                                    color: Colors
                                                                        .white,
                                                                    size: 35,
                                                                  )
                                                                : const ReusableText(
                                                                    'Sign Up',
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          ),
                                                          const Gap(35),
                                                        ] else ...[
                                                          const Gap(20),
                                                          ReusableText(
                                                            isEmailCorrect!,
                                                            fontSize: 17,
                                                          ),
                                                          const Gap(35),
                                                        ]
                                                    ],
                                                  )
                                                : const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 20,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ReusableText(
                                                          'You email is not available in the system. Please contact admin.',
                                                          fontSize: 17,
                                                        ),
                                                        Gap(12),
                                                        ReusableText(
                                                          'ohid.pranto2016@gmail.com',
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 400,
                                    child: Center(
                                      child: ReusableText(
                                          'No student data available.'),
                                    ),
                                  ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> fetchDepartments() async {
    setState(() {
      _loadingDept = true;
    });

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot =
          await firestore.collection('studentss').get();
      List<String> fetchedDepartments =
          querySnapshot.docs.map((doc) => doc.id).toList();

      setState(() {
        departments = fetchedDepartments;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching departments: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
    } finally {
      setState(() {
        _loadingDept = false;
      });
    }
  }

  Future<void> fetchBatches() async {
    if (selectedDept == null) return;

    setState(() {
      _loadingBatch = true;
      batches = [];
    });

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot doc =
          await firestore.collection('studentss').doc(selectedDept).get();
      List<String> fetchedBatches = List<String>.from(doc['availableBatches']);

      setState(() {
        batches = fetchedBatches;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching batches: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
    } finally {
      setState(() {
        _loadingBatch = false;
      });
    }
  }

  Future<void> fetchStudents() async {
    if (selectedDept == null || selectedBatch == null) return;

    setState(() {
      _loadingStudent = true;
      students = [];
    });

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('studentss')
          .doc(selectedDept)
          .collection(selectedBatch!)
          .get();
      List<Student> fetchedStudents = querySnapshot.docs.map((doc) {
        return Student.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      setState(() {
        students = fetchedStudents;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching students: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
    } finally {
      setState(() {
        _loadingStudent = false;
      });
    }
  }

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      for (Student student in students) {
        if (student.id == _id && student.name == _name) {
          setState(() {
            _selectedStudent = student;
          });
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student not found'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
    }
  }

  String _obfuscatedEmail(String email) => email.replaceRange(
        2,
        email.indexOf('@'),
        '*' * (email.indexOf('@') - 2),
      );

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

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: ReusableText(
              'Verification email sent to ${user.email}',
              color: Colors.white,
            ),
            width: 800,
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // Navigate to login page after successful signup
        Get.offAll(
          () => LoginMain(
            name: _nameController.text,
            studentId: _idController.text,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ReusableText(
            'Failed to sign up: $e',
            color: Colors.white,
          ),
          width: 800,
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
