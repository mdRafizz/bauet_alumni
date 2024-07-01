import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../../../common/reusable_text.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _company = TextEditingController();
  final _applicationLink = TextEditingController();
  final _jobLocation = TextEditingController();
  final _experienceLevel = TextEditingController();
  final _designation = TextEditingController();
  final _submissionDeadline = TextEditingController();
  final _workDays = TextEditingController();
  final _workHours = TextEditingController();
  final _minSalary = TextEditingController();
  final _maxSalary = TextEditingController();

  // List<String> jobOffers = [
  //   'Recruitment at Meghna Petroleum Limited',
  //   'Software Engineer at Tech Innovations Inc.',
  //   'Marketing Manager at Skyline Enterprises',
  //   'Financial Analyst at Quantum Finance Solutions',
  //   'Data Scientist at Alpha Analytics',
  //   'Human Resources Specialist at Horizon Group',
  //   'Graphic Designer at Creative Minds Agency',
  //   'Sales Representative at Global Trading Corporation',
  //   'Customer Support Specialist at Stellar Solutions',
  //   'Project Manager at Nexus Technologies',
  // ];
  //
  // List<String> companyNames = [
  //   'Meghna Petroleum Limited',
  //   'Tech Innovations Inc.',
  //   'Skyline Enterprises',
  //   'Quantum Finance Solutions',
  //   'Alpha Analytics',
  //   'Horizon Group',
  //   'Creative Minds Agency',
  //   'Global Trading Corporation',
  //   'Stellar Solutions',
  //   'Nexus Technologies',
  // ];
  //
  // List<String> postTimes = [
  //   '28 Feb 2024 11:10 AM',
  //   '15 Mar 2024 03:45 PM',
  //   '02 Apr 2024 09:30 AM',
  //   '20 May 2024 01:20 PM',
  //   '10 Jun 2024 08:55 AM',
  //   '05 Jul 2024 12:15 PM',
  //   '17 Aug 2024 05:40 PM',
  //   '22 Sep 2024 10:00 AM',
  //   '11 Oct 2024 02:35 PM',
  //   '29 Nov 2024 04:50 PM',
  // ];

  Future<void> uploadJobData() async {
    // const uid = Uuid();
    // final id = uid.v4();
    try {
      await FirebaseFirestore.instance.collection('jobs').add({
        // 'id': id,
        'title': _title.text,
        'description': _description.text,
        'company': _company.text,
        'applicationLink': _applicationLink.text,
        'jobLocation': _jobLocation.text,
        'experienceLevel': _experienceLevel.text,
        'designation': _designation.text,
        'submissionDeadline': _submissionDeadline.text,
        'workDays': _workDays.text,
        'workHours': _workHours.text,
        'minSalary': _minSalary.text,
        'maxSalary': _maxSalary.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Job data uploaded successfully");
    } catch (e) {
      print("Failed to upload job data: $e");
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _company.dispose();
    _applicationLink.dispose();
    _jobLocation.dispose();
    _experienceLevel.dispose();
    _workHours.dispose();
    _submissionDeadline.dispose();
    _designation.dispose();
    _maxSalary.dispose();
    _minSalary.dispose();
    _workDays.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          const Gap(25),
          _jobTopBar(),
          const Gap(30),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No jobs found'));
              }

              final jobs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (_, i) {
                  final job = jobs[i];
                  _keyList.add(GlobalKey<ExpansionTileCardState>());
                  return Column(
                    children: [
                      _jobCard(job, _keyList[i]),
                      const Gap(17),
                    ],
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            },
          ),
        ],
      ),
    );
  }

  Material _jobTopBar() {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 35,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: LayoutBuilder(
          builder: (_, __) {
            if (MediaQuery.of(context).size.width >= 535) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  const ReusableText(
                    'Jobs',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  // const CircleAvatar(
                  //   backgroundColor: Colors.black,
                  //   radius: 3,
                  // ),
                  // const Gap(10),
                  // const ReusableText(
                  //   '2',
                  //   color: Colors.blue,
                  // ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _postAJob();
                    },
                    child: const ReusableText(
                      'Post a job',
                      fontSize: 13,
                    ),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const ReusableText(
                      'Manage',
                      fontSize: 13,
                    ),
                  ),
                  const Gap(20),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ReusableText(
                    'Jobs',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // _addNewBusiness();
                        },
                        child: const ReusableText(
                          'Post a job',
                          fontSize: 13,
                        ),
                      ),
                      const Gap(25),
                      ElevatedButton(
                        onPressed: () {},
                        child: const ReusableText(
                          'Manage',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _postAJob() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        if (MediaQuery.of(context).size.width >= 765) {
          return AlertDialog(
            surfaceTintColor: CupertinoColors.systemGrey6,
            title: Row(
              children: [
                const ReusableText(
                  'Post a job',
                  fontSize: 22,
                ),
                const Spacer(),
                TextButton(
                  child: ReusableText(
                    'Close',
                    fontSize: 12.5,
                    color: Colors.blue[500],
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            content: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .55,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Material(
                      elevation: .8,
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 25,
                              bottom: 25,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: Colors.green.shade50,
                            ),
                            width: double.maxFinite,
                            child: const ReusableText(
                              'General information',
                              fontSize: 20,
                            ),
                          ),
                          // Gap(12),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 25,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  _commonTextField('Title', '', _title),
                                  const Gap(17),
                                  _commonTextField('Company', '', _company),
                                  const Gap(17),
                                  _commonTextField(
                                      'Description', '', _description),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Material(
                      elevation: .8,
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 25,
                              bottom: 25,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: Colors.green.shade50,
                            ),
                            width: double.maxFinite,
                            child: const ReusableText(
                              'Other Information',
                              fontSize: 20,
                            ),
                          ),
                          // Gap(12),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 25),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  _commonTextField('Apply link', 'Optional',
                                      _applicationLink),
                                  const Gap(22),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _commonTextField('Job location',
                                            'Optional', _jobLocation),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: _commonTextField(
                                            'Experience Level',
                                            'Optional',
                                            _experienceLevel),
                                      ),
                                    ],
                                  ),
                                  const Gap(22),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _commonTextField('Designation',
                                            'Optional', _designation),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: _commonTextField(
                                            'Submission deadline',
                                            'Optional',
                                            _submissionDeadline),
                                      ),
                                    ],
                                  ),
                                  const Gap(22),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _commonTextField(
                                            'Work days', 'Optional', _workDays),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: _commonTextField('Work hours',
                                            'Optional', _workHours),
                                      ),
                                    ],
                                  ),
                                  const Gap(22),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _commonTextField('Salary min',
                                            'Optional', _minSalary),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: _commonTextField('Salary max',
                                            'Optional', _maxSalary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: ReusableText(
                          'Make Job Live',
                          fontSize: 14.5,
                          color: Colors.purple[300],
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const Gap(9),
                    ],
                  ),
                  const Gap(40),
                ],
              ),
            ),
            // actions: <Widget>[
            //   TextButton(
            //     child: ReusableText(
            //       'Make Job Live',
            //       fontSize: 14.5,
            //       color: Colors.purple[300],
            //       fontWeight: FontWeight.w600,
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            //   TextButton(
            //     child: ReusableText(
            //       'Cancel',
            //       fontSize: 14.5,
            //       color: Colors.red[500],
            //       fontWeight: FontWeight.w600,
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          );
        } else {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            title: const ReusableText('Sorry!'),
            content: const ReusableText(
              'This feature is not available for smaller screen.',
              fontSize: 14,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.red,
                textColor: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Close'),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  // Material _jobTitle(int i) {
  //   return Material(
  //     elevation: 1.5,
  //     borderRadius: BorderRadius.circular(10),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: 10,
  //         vertical: 13,
  //       ),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: Colors.white,
  //       ),
  //       child: Row(
  //         children: [
  //           const Gap(20),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 ReusableText(jobOffers[i]),
  //                 const Gap(10),
  //                 ReusableText(
  //                   '${companyNames[i]} • ${postTimes[i]}',
  //                   fontSize: 12,
  //                   color: Colors.grey,
  //                 ),
  //                 const Gap(10),
  //                 const Card(
  //                   child: Padding(
  //                     padding: EdgeInsets.all(8),
  //                     child: ReusableText(
  //                       'Full-time',
  //                       fontSize: 10,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Gap(14),
  //           TextButton(
  //             onPressed: () {},
  //             child: const ReusableText(
  //               'Apply',
  //               color: Colors.blue,
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const Gap(20),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  final List<GlobalKey<ExpansionTileCardState>> _keyList = [];

  _jobCard(QueryDocumentSnapshot job, GlobalKey<ExpansionTileCardState> key) {
    return ExpansionTileCard(
      key: key,
      baseColor: Colors.white,
      expandedColor: Colors.white,
      initialElevation: 1,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      title: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: ReusableText(job['title']),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: ReusableText(
          job['company'],
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      children: [
        // const Gap(20),
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        const Gap(20),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ReusableText(
                  'Description',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['description'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Job location',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['jobLocation'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Experience Level',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['experienceLevel'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Designation',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['designation'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Work days',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['workDays'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Work hours',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['workHours'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Minimum Salary',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['minSalary'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Maximum Salary',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['maxSalary'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Submission Deadline',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['submissionDeadline'],
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Apply Link',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    job['applicationLink'],
                    fontSize: 15.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    copyToClipboard(job['applicationLink']);
                  },
                  child: const ReusableText(
                    'Apply',
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                TextButton(
                  onPressed: key.currentState?.collapse,
                  child: const ReusableText(
                    'Close',
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  Padding _commonTextField(
      String title, String optionalTxt, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(title),
              const Gap(8),
              ReusableText(
                optionalTxt,
                fontSize: 8,
              ),
            ],
          ),
          const Gap(12),
          TextField(
            controller: controller,
            maxLines: 10,
            minLines: 1,
            decoration: InputDecoration(
              fillColor: CupertinoColors.systemGrey6,
              filled: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 0, color: Colors.transparent),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 0, color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 0, color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        width: 600,
        content: ReusableText(
          'Link copied to clipboard',
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
