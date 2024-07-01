import 'package:alumni2/pages/home/home_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common/reusable_text.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  static const routeName = '/monitoringScreen';

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  String interestedInMonitoring = 'No'; // Default option
  var _isFileUploading = false;

  List<String> monitoringOption = [];

  void handleCheckboxChanged(String value) {
    setState(() {
      if (monitoringOption.contains(value)) {
        monitoringOption.remove(value);
      } else {
        monitoringOption.add(value);
      }
    });
  }

  var argumentData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ReusableText(
                'Interested in monitoring?',
              ),
              const SizedBox(height: 20.0),
              Container(
                // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(12),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  value: interestedInMonitoring,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  underline: const SizedBox(),
                  dropdownColor: Colors.white,
                  items: <String>['Yes', 'No'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      interestedInMonitoring = value!;
                    });
                  },
                ),
              ),
              if (interestedInMonitoring == 'Yes') ...[
                const Gap(30),
                _monitoringCard(),
              ],
              const Gap(35),
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
                        'Save',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ],
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

  Future<void> _uploadData() async {
    try {
      if (interestedInMonitoring == 'Yes' && monitoringOption.isEmpty) {
        _errorDialogue(context, 'Select what you are offering.');
      }
      setState(() {
        _isFileUploading = true;
      });

      Map<String, dynamic> userData = {
        'wantToMentor': interestedInMonitoring,
        'mentorOfferings': monitoringOption,
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(argumentData['email'])
          .update(userData)
          .then((_) {
        setState(() {
          _isFileUploading = false;
        });
        Get.offAllNamed(HomeMain.routeName);
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
}
