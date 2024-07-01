import 'package:alumni2/pages/home/home_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

import '../../common/custom_text_field.dart';
import '../../common/reusable_text.dart';

class EventAdd extends StatefulWidget {
  const EventAdd({super.key});

  static const String routeName = '/addEvent';

  @override
  State<EventAdd> createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _location = TextEditingController();
  final _regMembers = TextEditingController();
  final _regNonMembers = TextEditingController();
  final _guest = TextEditingController();

  var _isImageFetched = false;
  var _isImageFetched2 = false;
  FilePickerResult? _picked;
  FilePickerResult? _picked2;

  String _selectedDate = "Select a date";
  String _startTime = "Select a time";
  String _endTime = "Select a time";

  bool _isFileUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 800,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _eventDetailsTitle(),
                  _theFormPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///****************** Widgets ****************///
  ///
  Container _eventDetailsTitle() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          color: CupertinoColors.activeBlue.withOpacity(.2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ReusableText(
              'Event Details',
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const ReusableText(
                'Close',
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  Container _theFormPart() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 25,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(40),
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      _picked2 = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        // allowCom/pression: false,
                      );
                      if (_picked2 != null) {
                        setState(() {
                          _isImageFetched2 = true;
                        });
                      }
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      elevation: 2,
                      child: _isImageFetched2
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                _picked2!.files.first.bytes!,
                                height: 250,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 250,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blueGrey.shade200,
                              ),
                              alignment: Alignment.center,
                              child: const ReusableText(
                                'Select cover photo',
                              ),
                            ),
                    ),
                  ),

                  ///**************** Profile Picture Select section *************/
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () async {
                        _picked = await FilePicker.platform.pickFiles(
                            type: FileType.image, compressionQuality: 100);
                        if (_picked != null) {
                          setState(() {
                            _isImageFetched = true;
                          });
                        }
                      },
                      child: _isImageFetched
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.memory(
                                _picked!.files.first.bytes!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.amber.shade100,
                              ),
                              alignment: Alignment.center,
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 32,
                                  ),
                                  ReusableText(
                                    'Profile',
                                    fontSize: 12,
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(50),
            const Row(
              children: [
                Icon(
                  Icons.title,
                  size: 18,
                ),
                Gap(12),
                ReusableText(
                  'Title',
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: CustomTextField(
                controller: _title,
                hintText: 'e.g., BAUETAA Annual Iftar Get Together 2023',
              ),
            ),
            const Gap(50),
            const Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 18,
                ),
                Gap(12),
                ReusableText(
                  'Date',
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: CupertinoColors.systemGrey5,
                  ),
                  child: ReusableText(
                    _selectedDate,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Gap(50),
            const Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 18,
                ),
                Gap(12),
                ReusableText(
                  'Location',
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: CustomTextField(
                controller: _location,
                hintText:
                    "e.g., Cricketer's Kitchen & Cafe, Club Road, Dhaka, Bangladesh",
              ),
            ),
            const Gap(50),
            const Row(
              children: [
                Icon(
                  CupertinoIcons.clock_fill,
                  size: 18,
                ),
                Gap(12),
                ReusableText(
                  'Time',
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                const Gap(18),
                GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: CupertinoColors.systemGrey5,
                    ),
                    child: ReusableText(
                      _startTime,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: CupertinoColors.systemGrey5,
                    ),
                    child: ReusableText(
                      _endTime,
                      fontSize: 14,
                    ),
                  ),
                ),

                ///
              ],
            ),
            const Gap(50),
            const Row(
              children: [
                Icon(
                  Icons.description,
                  size: 18,
                ),
                Gap(12),
                ReusableText(
                  'Description',
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: CustomTextField(
                controller: _desc,
                hintText: 'Enter description here',
                maxLines: 10,
                minLines: 1,
              ),
            ),
            const Gap(50),
            const Row(
              children: [
                Icon(
                  Icons.app_registration_rounded,
                  size: 18,
                ),
                Gap(12),
                ReusableText(
                  'Registration Fees',
                  fontSize: 14,
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ReusableText(
                        'Members',
                        fontSize: 12,
                      ),
                      const Gap(10),
                      CustomTextField(
                        controller: _regMembers,
                        hintText: '1000 Taka',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ReusableText(
                        'Non-members',
                        fontSize: 12,
                      ),
                      const Gap(10),
                      CustomTextField(
                        controller: _regNonMembers,
                        hintText: '1500 Taka',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ReusableText(
                        'Guest',
                        fontSize: 12,
                      ),
                      const Gap(10),
                      CustomTextField(
                        controller: _guest,
                        hintText: '1500 Taka',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(50),
            MaterialButton(
              onPressed: () {
                debugPrint(DateFormat("MMMM d, yyyy", "en_US")
                    .parse(_selectedDate)
                    .day
                    .toString());
                debugPrint(
                  DateFormat("MMM", "en_US").format(
                    DateFormat("MMMM d, yyyy", "en_US").parse(_selectedDate),
                  ),
                );
                _uploadFile();
              },
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 65,
              minWidth: 800,
              child: _isFileUploading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 28,
                    )
                  : const ReusableText(
                      'Save',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
            ),
            const Gap(17),
          ],
        ),
      );

  ///
  ///
  ///
  ///
  ///
  ///
  ///****************** Operations ****************///
  ///
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('MMMM d, yyyy').format(picked);
      });
    }
  }

  void _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();
      final dt =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      setState(() {
        if (isStartTime) {
          _startTime = DateFormat('h:mm a').format(dt);
        } else {
          _endTime = DateFormat('h:mm a').format(dt);
        }
      });
    }
  }

  void _uploadFile() async {
    if (_desc.text == '' ||
        _title.text == '' ||
        _location.text == '' ||
        _startTime == 'Select a time' ||
        _endTime == 'Select a time' ||
        _selectedDate == "Select a date" ||
        _regNonMembers.text == '' ||
        _regMembers.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: ReusableText(
            "There are missing fields in your form. Please review and complete them before saving.",
            color: Colors.white,
            fontSize: 16,
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
      return;
    }
    if (_picked == null || _picked2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: ReusableText(
            "You haven't select the photos. Please review and complete them before saving.",
            color: Colors.white,
            fontSize: 16,
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          width: 800,
        ),
      );
      return;
    } else {
      debugPrint(_title.text);
      debugPrint(_location.text);
      debugPrint(_desc.text);

      setState(() {
        _isFileUploading = true;
      });

      Reference ref = FirebaseStorage.instance
          .ref()
          .child('event_profile')
          .child('${_title.text}_profile_picture');
      UploadTask uploadTask = ref.putData(_picked!.files.first.bytes!);
      TaskSnapshot snapshot = await uploadTask;
      String profilePictureUrl = await snapshot.ref.getDownloadURL();

      Reference ref2 = FirebaseStorage.instance
          .ref()
          .child('event_cover')
          .child('${_title.text}_cover_picture');
      UploadTask uploadTask2 = ref2.putData(_picked2!.files.first.bytes!);
      TaskSnapshot snapshot2 = await uploadTask2;
      String coverPictureUrl = await snapshot2.ref.getDownloadURL();

      String id = const Uuid().v4();
      await FirebaseFirestore.instance.collection('events').doc(id).set({
        'title': _title.text,
        'location': _location.text,
        'date': _selectedDate,
        'time': "$_startTime to $_endTime",
        "desc": _desc.text,
        "day": DateFormat("MMMM d, yyyy", "en_US")
            .parse(_selectedDate)
            .day
            .toString(),
        "month": DateFormat("MMM", "en_US").format(
          DateFormat("MMMM d, yyyy", "en_US").parse(_selectedDate),
        ),
        "regMembers": _regMembers.text,
        "regNonMembers": _regNonMembers.text,
        "guest": _guest.text,
        'profilePictureUrl': profilePictureUrl,
        'coverPictureUrl': coverPictureUrl,
        "timestamp": Timestamp.now(),
      }).then((_) {
        setState(() {
          _isFileUploading = false;
        });
        Get.offAllNamed(HomeMain.routeName);
      });
    }
  }
}
