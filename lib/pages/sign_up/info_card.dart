import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/reusable_text.dart';
import 'monitoring_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  static const routeName = '/personalInfo';

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  var argumentData = Get.arguments;
  var _isFileUploading = false;
  final TextEditingController _sscInstitutionController =
      TextEditingController();
  final TextEditingController _sscDurationController = TextEditingController();
  final TextEditingController _hscInstitutionController =
      TextEditingController();
  final TextEditingController _hscDurationController = TextEditingController();
  final TextEditingController _bscInstitutionController =
      TextEditingController();
  final TextEditingController _bscDurationController = TextEditingController();
  final TextEditingController _bscDegreeController = TextEditingController();
  final TextEditingController _mscInstitutionController =
      TextEditingController();
  final TextEditingController _mscDurationController = TextEditingController();
  final TextEditingController _mscDegreeController = TextEditingController();
  final TextEditingController _phdInstitutionController =
      TextEditingController();
  final TextEditingController _phdDurationController = TextEditingController();
  final TextEditingController _phdSubjectController = TextEditingController();
  final TextEditingController _currentStatusController =
      TextEditingController();
  final TextEditingController _experiencePositionController =
      TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _hometownController = TextEditingController();
  final TextEditingController _whatsappNumberController =
      TextEditingController();

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
      if (_sscInstitutionController.text.isEmpty ||
          _sscDurationController.text.isEmpty ||
          _hscInstitutionController.text.isEmpty ||
          _hscDurationController.text.isEmpty ||
          _bscInstitutionController.text.isEmpty ||
          _bscDurationController.text.isEmpty ||
          _bscDegreeController.text.isEmpty ||
          _dobController.text.isEmpty ||
          _bloodGroupController.text.isEmpty ||
          _hometownController.text.isEmpty) {
        _errorDialogue(context, 'Please fill in all mandatory fields.');
        return;
      }

      // Upload user data to Firestore
      Map<String, dynamic> userData = {
        'sscInstitution': _sscInstitutionController.text,
        'sscDuration': _sscDurationController.text,
        'hscInstitution': _hscInstitutionController.text,
        'hscDuration': _hscDurationController.text,
        'bscInstitution': _bscInstitutionController.text,
        'bscDuration': _bscDurationController.text,
        'bscDegree': _bscDegreeController.text,
        'mscInstitution': _mscInstitutionController.text,
        'mscDuration': _mscDurationController.text,
        'mscDegree': _mscDegreeController.text,
        'phdInstitution': _phdInstitutionController.text,
        'phdDuration': _phdDurationController.text,
        'phdSubject': _phdSubjectController.text,
        'currentStatus': _currentStatusController.text,
        'experiencePosition': _experiencePositionController.text,
        'institute': _instituteController.text,
        'dob': _dobController.text,
        'bloodGroup': _bloodGroupController.text,
        'hometown': _hometownController.text,
        'whatsappNumber': _whatsappNumberController.text,
      };

      setState(() {
        _isFileUploading = true;
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(argumentData['email'])
          .update(userData)
          .then((value) {
        setState(() {
          _isFileUploading = false;
        });
        Get.toNamed(MonitoringScreen.routeName, arguments: {
          'email': argumentData['email'],
        });
      });
    } catch (e) {
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
                  e.toString(),
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

  @override
  void initState() {
    _bscInstitutionController.text =
        'Bangladesh Army University of Engineering & Technology';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _sscDurationController.dispose();
    _sscInstitutionController.dispose();
    _hscDurationController.dispose();
    _hscInstitutionController.dispose();
    _bscDegreeController.dispose();
    _bscDurationController.dispose();
    _bscInstitutionController.dispose();
    _mscDegreeController.dispose();
    _mscDurationController.dispose();
    _mscInstitutionController.dispose();
    _phdSubjectController.dispose();
    _phdDurationController.dispose();
    _phdInstitutionController.dispose();
    _currentStatusController.dispose();
    _experiencePositionController.dispose();
    _instituteController.dispose();
    _dobController.dispose();
    _bloodGroupController.dispose();
    _hometownController.dispose();
    _whatsappNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Gap(25),
                Image.asset(
                  'assets/icons/bauet_logo.png',
                  height: 55,
                ),
                const Gap(25),
                Container(
                  width: 600,
                  // height: 40.sp,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF0D0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      // text: 'Hello ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Welcome to '),
                        TextSpan(
                          text: 'BAUET Alumni Association',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "! We're excited to have you join our community. To ensure the best experience for everyone, ",
                        ),
                        TextSpan(
                          text:
                              'please provide accurate information during signup',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              ". Your privacy and security are important to us, and providing truthful details helps us tailor our services to your needs and keeps our community safe. Thank you for your cooperation!",
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                LayoutBuilder(
                  builder: (context, _) {
                    return Get.width >= 1275
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _academicInfoCard(),
                              const Gap(20),
                              _personalInfoCard(),
                            ],
                          )
                        : Column(
                            children: [
                              _academicInfoCard(),
                              const Gap(20),
                              _personalInfoCard(),
                            ],
                          );
                  },
                ),
                const Gap(22),
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
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 32,
                        )
                      : const ReusableText(
                          'Sign up',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                ),
                const Gap(22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _personalInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: fromCssColor('#f9fbfc'),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: ReusableText(
              'Other Info',
              fontSize: 19,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          width: 600,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(18),

              const ReusableText(
                'Current Status',
                fontWeight: FontWeight.bold,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 18),
                child: TextField(
                  controller: _currentStatusController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Status',
                    hintText: "ex: 4th Year, 1st Semester Student",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.work_history_rounded),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),

              ///************************* SSC Degree *****************///
              const ReusableText(
                'Experiences',
                fontWeight: FontWeight.bold,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  controller: _experiencePositionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Position',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.work_history_rounded),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                child: TextField(
                  controller: _instituteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Institution Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(IcoFontIcons.institution),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),

              ///************************* HSC Degree *****************///

              const ReusableText(
                'Personal info',
                fontWeight: FontWeight.bold,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                'DOB',
                                fontSize: 14,
                              ),
                              ReusableText(
                                '*',
                                fontSize: 10,
                              ),
                            ],
                          ),
                          hintText: 'ex: March 2, 2000',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(IcoFontIcons.birthdayCake),
                          ),
                          // hintText: 'First Name',
                          // hintStyle: TextStyle(
                          //   fontSize: 15,
                          // ),
                        ),
                      ),
                    ),
                    const Gap(18),
                    Expanded(
                      child: TextField(
                        controller: _bloodGroupController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'O+',
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                'Blood Group',
                                fontSize: 14,
                              ),
                              ReusableText(
                                '*',
                                fontSize: 10,
                              ),
                            ],
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(CupertinoIcons.drop_fill),
                          ),
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(18),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _hometownController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                'Home Town',
                                fontSize: 14,
                              ),
                              ReusableText(
                                '*',
                                fontSize: 10,
                              ),
                            ],
                          ),
                          hintText: 'ex: Shailkupa, Jhenaidah',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(CupertinoIcons.location_solid),
                          ),
                          // hintText: 'First Name',
                          // hintStyle: TextStyle(
                          //   fontSize: 15,
                          // ),
                        ),
                      ),
                    ),
                    const Gap(18),
                    Expanded(
                      child: TextField(
                        controller: _whatsappNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'ex: 01722522279',
                          labelText: 'Whatsapp',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(IcoFontIcons.whatsapp),
                          ),
                          // hintStyle: GoogleFonts.poppins(
                          //   fontSize: 12.sp,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(18),
            ],
          ),
        ),
      ],
    );
  }

  Column _academicInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: fromCssColor('#f9fbfc'),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: ReusableText(
              'Academic Info',
              fontSize: 19,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          width: 600,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(18),

              ///************************* SSC Degree *****************///
              const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    'Secondary School Certificate',
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    '*',
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  controller: _sscInstitutionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Institution Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(IcoFontIcons.institution),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                child: TextField(
                  controller: _sscDurationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: January 2010 - March 2015',
                    labelText: 'Duration',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),

              ///************************* HSC Degree *****************///

              const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    'Higher Secondary School Certificate',
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    '*',
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  controller: _hscInstitutionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Institution Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(IcoFontIcons.institution),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                child: TextField(
                  controller: _hscDurationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: January 2010 - March 2015',
                    labelText: 'Duration',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),

              ///************************* Bachelor Degree *****************///

              const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    'Bachelor Degree',
                    fontWeight: FontWeight.bold,
                  ),
                  ReusableText(
                    '*',
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),

              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  controller: _bscInstitutionController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Institution Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(IcoFontIcons.institution),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                child: TextField(
                  controller: _bscDurationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: January 2010 - March 2015',
                    labelText: 'Duration',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 18),
                child: TextField(
                  controller: _bscDegreeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: BSc in Computer Science and Engineering',
                    labelText: 'Degree Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.school_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),

              ///************************* Masters Degree *****************///
              const ReusableText(
                'Masters Degree',
                fontWeight: FontWeight.bold,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  controller: _mscInstitutionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Institution Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(IcoFontIcons.institution),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                child: TextField(
                  controller: _mscDurationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: January 2010 - March 2015',
                    labelText: 'Duration',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 18),
                child: TextField(
                  controller: _mscDegreeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: MSc in Computer Science and Engineering',
                    labelText: 'Degree Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.school_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),

              ///************************* PhD Degree *****************///
              const ReusableText(
                'PhD',
                fontWeight: FontWeight.bold,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  controller: _phdInstitutionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Institution Name',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(IcoFontIcons.institution),
                    ),
                    // hintText: 'First Name',
                    // hintStyle: TextStyle(
                    //   fontSize: 15,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                child: TextField(
                  controller: _phdDurationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'ex: January 2010 - March 2015',
                    labelText: 'Duration',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 18),
                child: TextField(
                  controller: _phdSubjectController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // hintText: 'ex: January 2010 - March 2015',
                    labelText: 'Subject',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month_rounded),
                    ),
                    // hintStyle: GoogleFonts.poppins(
                    //   fontSize: 12.sp,
                    // ),
                  ),
                ),
              ),
              const Gap(18),
            ],
          ),
        ),
      ],
    );
  }
}
