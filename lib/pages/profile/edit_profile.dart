import 'package:alumni2/common/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../common/reusable_text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  static const String routeName = '/editProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _presentAddress = TextEditingController();
  final _permanentAddress = TextEditingController();

  var _isFileUploading = false;

  var _isImageFetched = false;
  var _isImageFetched2 = false;
  FilePickerResult? _picked;
  FilePickerResult? _picked2;

  String _birthday = 'Select a date';
  String _bloodGroup = 'Select';
  String _selectedBachelorDegree = 'Select your degree';
  String _bscStarted = 'Start date';
  String _bscEnded = 'End date';

  final _degreeList = <String>[
    'BA (Honours) in English Language and Literature',
    'Bachelor of Business Administration',
    'B.Sc. in Civil Engineering',
    'B.Sc. in Computer Science and Technology',
    'B.Sc. in Electrical and Electronics Engineering',
    'B.Sc. in Information and Communication Engineering',
    'B.Sc. in Mechanical Engineering',
    'B.Sc. in LAW',
  ];

  final _bloodGroupList = <String>[
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
  ];

  final TextEditingController _fullName = TextEditingController();

  String interestedInMonitoring = 'No'; // Default option

  List<String> monitoringOption = [];

  final _hometownController = TextEditingController();

  void handleCheckboxChanged(String value) {
    setState(() {
      if (monitoringOption.contains(value)) {
        monitoringOption.remove(value);
      } else {
        monitoringOption.add(value);
      }
    });
  }

  @override
  void initState() {
    // _bscInstitutionController.text =
    //     'Bangladesh Army University of Engineering & Technology';
    monitoringOption = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(35),
                  const Row(
                    children: [
                      Icon(Icons.edit),
                      Gap(9.4),
                      ReusableText(
                        'Edit Profile',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ],
                  ),
                  const Gap(45),

                  /**************** Profile Picture Select section *************/
                  SizedBox(
                    width: 800,
                    height: 350,
                    child: Stack(
                      children: [
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
                                      height: 290,
                                      width: 800,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 290,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue.shade100,
                                    ),
                                    alignment: Alignment.center,
                                    child: const ReusableText(
                                      'Select cover photo',
                                    ),
                                  ),
                          ),
                        ),
                        /**************** Profile Picture Select section *************/
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              _picked = await FilePicker.platform.pickFiles(
                                type: FileType.image,
                              );
                              if (_picked != null) {
                                setState(
                                  () {
                                    _isImageFetched = true;
                                  },
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: _isImageFetched
                                  ? Image.memory(_picked!.files.first.bytes!)
                                      .image
                                  : Image.asset(
                                      'assets/images/user_img.png',
                                      fit: BoxFit.cover,
                                    ).image,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /**************** Personal info ********************/
                  const Gap(50),
                  const ReusableText(
                    'Personal Details',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                          'Name',
                          fontSize: 15,
                        ),
                        const Gap(8),
                        CustomTextField(
                          height: 60,
                          hintText: 'Your Name',
                          radius: 8,
                          controller: _fullName,
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ReusableText(
                                    'Present Address',
                                    fontSize: 15,
                                  ),
                                  const Gap(8),
                                  CustomTextField(
                                    hintText: 'Toronto, Canada',
                                    radius: 8,
                                    controller: _presentAddress,
                                  ),
                                ],
                              ),
                            ),
                            const Gap(25),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ReusableText(
                                    'Permanent Address',
                                    fontSize: 15,
                                  ),
                                  const Gap(8),
                                  CustomTextField(
                                    hintText: 'Shailkupa, Jhenaidah',
                                    radius: 8,
                                    controller: _permanentAddress,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ReusableText(
                                    'Birthday',
                                    fontSize: 15,
                                  ),
                                  const Gap(8),
                                  GestureDetector(
                                    onTap: () => _birthdaySelect(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 14.5,
                                      ),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        color: CupertinoColors.systemGrey5,
                                      ),
                                      child: ReusableText(
                                        _birthday,
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(30),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ReusableText(
                                    'Blood Group',
                                    fontSize: 15,
                                  ),
                                  const Gap(8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: CupertinoColors.systemGrey5,
                                    ),
                                    child: DropdownMenu<String>(
                                      // width: 600,
                                      inputDecorationTheme:
                                          const InputDecorationTheme(
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      hintText: 'Select',
                                      dropdownMenuEntries: _bloodGroupList
                                          .map<DropdownMenuEntry<String>>(
                                            (item) => DropdownMenuEntry(
                                              value: item,
                                              label: item,
                                            ),
                                          )
                                          .toList(),
                                      onSelected: (String? value) => setState(
                                        () => _bloodGroup = value ?? 'Select',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  //
                  //
                  //
                  /**************** Academic info ********************/
                  const Gap(50),
                  const ReusableText(
                    'Academic Info',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                          'Bachelor Degree',
                          fontSize: 15,
                        ),
                        const Gap(8),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: CupertinoColors.systemGrey5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: DropdownMenu<String>(
                            width: 720,
                            inputDecorationTheme: const InputDecorationTheme(
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hintText: 'Select your degree',
                            dropdownMenuEntries: _degreeList
                                .map<DropdownMenuEntry<String>>(
                                  (item) => DropdownMenuEntry(
                                    value: item,
                                    label: item,
                                  ),
                                )
                                .toList(),
                            onSelected: (String? value) => setState(
                              () => _selectedBachelorDegree =
                                  value ?? 'Select your degree',
                            ),
                          ),
                        ),
                        const Gap(30),
                        const ReusableText(
                          'Duration',
                          fontSize: 15,
                        ),
                        const Gap(12),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _bscStart(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 14.5,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                  child: ReusableText(
                                    _bscStarted,
                                    fontSize: 14,
                                    color: _bscStarted == 'Start date'
                                        ? Colors.black54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(25),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _bscEnd(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 14.5,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                  child: ReusableText(
                                    _bscEnded,
                                    fontSize: 14,
                                    color: _bscEnded == 'End date'
                                        ? Colors.black54
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //
                  //
                  //
                  //
                  //////////////////
                  // const Gap(35),
                  // const ReusableText("SSC Details"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _sscInstitutionController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     // hintText: 'Last Name',
                  //     labelText: 'Institution',
                  //     // hintStyle: GoogleFonts.poppins(
                  //     //   fontSize: 12.sp,
                  //     // ),
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _sscDurationController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     // hintText: 'Last Name',
                  //     labelText: 'Duration',
                  //     // hintStyle: GoogleFonts.poppins(
                  //     //   fontSize: 12.sp,
                  //     // ),
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("HSC Details"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _hscInstitutionController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Institution',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _hscDurationController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Duration',
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("BSc Details"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _bscInstitutionController,
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Institution',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _bscDurationController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Duration',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _bscDegreeController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Degree',
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("MSc Details"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _mscInstitutionController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Institution',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _mscDurationController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Duration',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _mscDegreeController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Degree',
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("PhD Details"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _phdInstitutionController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Institution',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _phdDurationController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Duration',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _phdSubjectController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Subject',
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("Current Status"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _currentStatusController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Status',
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("Experience"),
                  // const Gap(20),
                  // TextField(
                  //   controller: _experiencePositionController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Position',
                  //   ),
                  // ),
                  // const Gap(20),
                  // TextField(
                  //   controller: _instituteController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: 'Institution',
                  //   ),
                  // ),
                  // const Gap(35),
                  // const ReusableText("Experience"),
                  // const Gap(20),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _dobController,
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           labelText: 'Birthday',
                  //           // hintText: 'First Name',
                  //           // hintStyle: TextStyle(
                  //           //   fontSize: 15,
                  //           // ),
                  //         ),
                  //       ),
                  //     ),
                  //     const Gap(20),
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _bloodGroupController,
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           // hintText: 'Last Name',
                  //           labelText: 'Blood Group',
                  //           // hintStyle: GoogleFonts.poppins(
                  //           //   fontSize: 12.sp,
                  //           // ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const Gap(20),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _hometownController,
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           labelText: 'Home Town',
                  //           // hintText: 'First Name',
                  //           // hintStyle: TextStyle(
                  //           //   fontSize: 15,
                  //           // ),
                  //         ),
                  //       ),
                  //     ),
                  //     const Gap(20),
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _whatsappNumberController,
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           // hintText: 'Last Name',
                  //           labelText: 'Whatsapp Number',
                  //           // hintStyle: GoogleFonts.poppins(
                  //           //   fontSize: 12.sp,
                  //           // ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const Gap(35),
                  // const ReusableText(
                  //   'Interested in monitoring?',
                  // ),
                  // const SizedBox(height: 20.0),
                  // Container(
                  //   // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12.0),
                  //     border: Border.all(
                  //       color: Colors.blue,
                  //       width: 2.0,
                  //     ),
                  //   ),
                  //   child: DropdownButton<String>(
                  //     borderRadius: BorderRadius.circular(12),
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     value: interestedInMonitoring,
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 18.0,
                  //     ),
                  //     underline: const SizedBox(),
                  //     dropdownColor: Colors.white,
                  //     items: <String>['Yes', 'No'].map((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         interestedInMonitoring = value!;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // if (interestedInMonitoring == 'Yes') ...[
                  //   const Gap(30),
                  //   _monitoringCard(),
                  // ],
                  // const Gap(50),
                  // MaterialButton(
                  //   onPressed: () {
                  //     _updateProfile();
                  //   },
                  //   height: 70,
                  //   minWidth: 600,
                  //   color: Colors.blue,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: _isFileUploading
                  //       ? Center(
                  //           child: LoadingAnimationWidget.staggeredDotsWave(
                  //             color: Colors.white,
                  //             size: 32,
                  //           ),
                  //         )
                  //       : const ReusableText(
                  //           'Save',
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20,
                  //         ),
                  // ),
                  // const Gap(50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _monitoringCard() {
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
              'Monitoring',
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
              const ReusableText(
                'What are you offering?',
                fontWeight: FontWeight.bold,
              ),
              const Gap(20),
              for (String option in [
                'Engage/Introduce Contacts',
                'Offer Advice',
                'Review Resume',
                'Act as a Mentor',
                'Offer Internship',
                'Higher Study Help',
              ])
                CheckboxListTile(
                  title: Text(option),
                  value: monitoringOption.contains(option),
                  onChanged: (bool? value) {
                    handleCheckboxChanged(option);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  // void _updateProfile() async {
  //   setState(() {
  //     _isFileUploading = true;
  //   });
  //
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.email)
  //       .get();
  //   final userData = userDoc.data() as Map<String, dynamic>;
  //
  //   Map<String, dynamic> updatedData = {};
  //
  //   // Update only the fields that have new data
  //   if (_firstNameController.text.isNotEmpty &&
  //       _firstNameController.text != userData['firstName']) {
  //     updatedData['firstName'] = _firstNameController.text;
  //   }
  //   if (_lastNameController.text.isNotEmpty &&
  //       _lastNameController.text != userData['lastName']) {
  //     updatedData['lastName'] = _lastNameController.text;
  //   }
  //   if (_sscInstitutionController.text.isNotEmpty &&
  //       _sscInstitutionController.text != userData['sscInstitution']) {
  //     updatedData['sscInstitution'] = _sscInstitutionController.text;
  //   }
  //   if (_sscDurationController.text.isNotEmpty &&
  //       _sscDurationController.text != userData['sscDuration']) {
  //     updatedData['sscDuration'] = _sscDurationController.text;
  //   }
  //   if (_hscInstitutionController.text.isNotEmpty &&
  //       _hscInstitutionController.text != userData['hscInstitution']) {
  //     updatedData['hscInstitution'] = _hscInstitutionController.text;
  //   }
  //   if (_hscDurationController.text.isNotEmpty &&
  //       _hscDurationController.text != userData['hscDuration']) {
  //     updatedData['hscDuration'] = _hscDurationController.text;
  //   }
  //   if (_bscInstitutionController.text.isNotEmpty &&
  //       _bscInstitutionController.text != userData['bscInstitution']) {
  //     updatedData['bscInstitution'] = _bscInstitutionController.text;
  //   }
  //   if (_bscDurationController.text.isNotEmpty &&
  //       _bscDurationController.text != userData['bscDuration']) {
  //     updatedData['bscDuration'] = _bscDurationController.text;
  //   }
  //   if (_bscDegreeController.text.isNotEmpty &&
  //       _bscDegreeController.text != userData['bscDegree']) {
  //     updatedData['bscDegree'] = _bscDegreeController.text;
  //   }
  //   if (_mscInstitutionController.text.isNotEmpty &&
  //       _mscInstitutionController.text != userData['mscInstitution']) {
  //     updatedData['mscInstitution'] = _mscInstitutionController.text;
  //   }
  //   if (_mscDurationController.text.isNotEmpty &&
  //       _mscDurationController.text != userData['mscDuration']) {
  //     updatedData['mscDuration'] = _mscDurationController.text;
  //   }
  //   if (_mscDegreeController.text.isNotEmpty &&
  //       _mscDegreeController.text != userData['mscDegree']) {
  //     updatedData['mscDegree'] = _mscDegreeController.text;
  //   }
  //   if (_phdInstitutionController.text.isNotEmpty &&
  //       _phdInstitutionController.text != userData['phdInstitution']) {
  //     updatedData['phdInstitution'] = _phdInstitutionController.text;
  //   }
  //   if (_phdDurationController.text.isNotEmpty &&
  //       _phdDurationController.text != userData['phdDuration']) {
  //     updatedData['phdDuration'] = _phdDurationController.text;
  //   }
  //   if (_phdSubjectController.text.isNotEmpty &&
  //       _phdSubjectController.text != userData['phdSubject']) {
  //     updatedData['phdSubject'] = _phdSubjectController.text;
  //   }
  //   if (_currentStatusController.text.isNotEmpty &&
  //       _currentStatusController.text != userData['currentStatus']) {
  //     updatedData['currentStatus'] = _currentStatusController.text;
  //   }
  //   if (_experiencePositionController.text.isNotEmpty &&
  //       _experiencePositionController.text != userData['experiencePosition']) {
  //     updatedData['experiencePosition'] = _experiencePositionController.text;
  //   }
  //   if (_instituteController.text.isNotEmpty &&
  //       _instituteController.text != userData['institute']) {
  //     updatedData['institute'] = _instituteController.text;
  //   }
  //   if (_dobController.text.isNotEmpty &&
  //       _dobController.text != userData['dob']) {
  //     updatedData['dob'] = _dobController.text;
  //   }
  //   if (_bloodGroupController.text.isNotEmpty &&
  //       _bloodGroupController.text != userData['bloodGroup']) {
  //     updatedData['bloodGroup'] = _bloodGroupController.text;
  //   }
  //   if (_hometownController.text.isNotEmpty &&
  //       _hometownController.text != userData['hometown']) {
  //     updatedData['hometown'] = _hometownController.text;
  //   }
  //   if (_whatsappNumberController.text.isNotEmpty &&
  //       _whatsappNumberController.text != userData['whatsappNumber']) {
  //     updatedData['whatsappNumber'] = _whatsappNumberController.text;
  //   }
  //
  //   if (_picked != null) {
  //     Reference ref = FirebaseStorage.instance
  //         .ref()
  //         .child('profile_pictures')
  //         .child('${user.email}_profile_picture');
  //     UploadTask uploadTask = ref.putData(_picked!.files.first.bytes!);
  //     TaskSnapshot snapshot = await uploadTask;
  //     String profilePictureUrl = await snapshot.ref.getDownloadURL();
  //
  //     updatedData['profilePictureUrl'] = profilePictureUrl;
  //   }
  //   if (_picked2 != null) {
  //     Reference ref2 = FirebaseStorage.instance
  //         .ref()
  //         .child('cover_pictures')
  //         .child('${user.email}_cover_picture');
  //     UploadTask uploadTask2 = ref2.putData(_picked2!.files.first.bytes!);
  //     TaskSnapshot snapshot2 = await uploadTask2;
  //     String coverPictureUrl = await snapshot2.ref.getDownloadURL();
  //
  //     updatedData['coverPictureUrl'] = coverPictureUrl;
  //   }
  //   if (interestedInMonitoring != userData['wantToMentor']) {
  //     updatedData['wantToMentor'] = interestedInMonitoring;
  //     updatedData['mentorOfferings'] = monitoringOption;
  //   }
  //
  //   // Update Firestore with the updated data
  //   if (updatedData.isNotEmpty) {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.email)
  //         .update(updatedData);
  //     debugPrint("Profile updated successfully");
  //     setState(() {
  //       _isFileUploading = false;
  //     });
  //     Get.offAllNamed(HomeMain.routeName);
  //   } else {
  //     debugPrint("No changes detected");
  //     setState(() {
  //       _isFileUploading = false;
  //     });
  //   }
  // }

  void _birthdaySelect(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthday = DateFormat('MMMM d, yyyy').format(picked);
      });
    }
  }

  void _bscStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _bscStarted = DateFormat('MMMM d, yyyy').format(picked);
      });
    }
  }

  void _bscEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _bscEnded = DateFormat('MMMM d, yyyy').format(picked);
      });
    }
  }
}
