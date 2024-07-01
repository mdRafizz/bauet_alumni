import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/reusable_text.dart';
import '../../../../../controller/user_controller.dart';
import '../../../../../data/model/user_model.dart';

class Mentors extends StatefulWidget {
  const Mentors({super.key});

  @override
  State<Mentors> createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {
  final _userController = Get.put<UserController>(UserController());

  @override
  void initState() {
    _users.addAll(_userController.users);
    _mentors = _users
        .where(
          (user) => user.wantToMentor == 'Yes',
        )
        .toList();

    super.initState();
  }

  final List<UserModel> _users = [];
  late List<UserModel> _mentors;

  int currentState = 0;

  void updateCurrentState(int state) {
    setState(() {
      currentState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: [
            const Gap(25),
            _totalMonitors(),
            const Gap(25),
            ListView.builder(
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    _singleMentorSection(i),
                    const Gap(17),
                  ],
                );
              },
              itemCount: _mentors.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Material _totalMonitors() {
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
                  const ReusableText(
                    'Monitoring',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      updateCurrentState(0);
                    },
                    color: currentState == 0 ? Colors.blue : null,
                    hoverColor: currentState == 1 ? Colors.blue.shade100 : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ReusableText(
                      'Mentor',
                      fontSize: 14,
                      color: currentState == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  const Gap(25),
                  MaterialButton(
                    onPressed: () {
                      updateCurrentState(1);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: currentState == 1 ? Colors.blue : null,
                    hoverColor: currentState == 0 ? Colors.blue.shade100 : null,
                    child: ReusableText(
                      'Request',
                      fontSize: 14,
                      color: currentState == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  const Gap(30),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ReusableText(
                    'Monitoring',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          updateCurrentState(0);
                        },
                        color: currentState == 0 ? Colors.blue : null,
                        hoverColor:
                            currentState == 1 ? Colors.blue.shade100 : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ReusableText(
                          'Mentor',
                          fontSize: 14,
                          color:
                              currentState == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                      const Gap(25),
                      MaterialButton(
                        onPressed: () {
                          updateCurrentState(1);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: currentState == 1 ? Colors.blue : null,
                        hoverColor:
                            currentState == 0 ? Colors.blue.shade100 : null,
                        child: ReusableText(
                          'Request',
                          fontSize: 14,
                          color:
                              currentState == 1 ? Colors.white : Colors.black,
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

  Material _singleMentorSection(int i) {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: LayoutBuilder(
          builder: (_, __) {
            if (MediaQuery.of(context).size.width >= 840) {
              if (MediaQuery.of(context).size.width >= 1340) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 70,
                        width: 70,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: CupertinoActivityIndicator(),
                            ),
                            if (_userController.isLoading2.isFalse)
                              Image.network(
                                _mentors[i].profilePictureUrl.toString(),
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
                              )
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: ReusableText(
                              '${_mentors[i].firstName} ${_mentors[i].lastName}',
                              fontSize: 15,
                            ),
                          ),
                          if (_mentors[i].currentStatus != '')
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: ReusableText(
                                '${_mentors[i].currentStatus}',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 8, bottom: 8),
                            child: MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    // List<String?> offerings = _mentors[i].map((mentor) => mentor.mentorOfferings).toList();
                                    return AlertDialog(
                                      title: const ReusableText(
                                        "Offerings",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const ReusableText(
                                            'Close',
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                      content: SizedBox(
                                        // height: 300,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              _mentors[i].mentorOfferings!.map(
                                            (offering) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                ),
                                                child: ReusableText(
                                                  offering,
                                                  fontSize: 16,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: CupertinoColors.systemGrey6,
                              child: const ReusableText(
                                'View Offerings',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        sendEmail(_mentors[i].email!);
                      },
                      child: const ReusableText(
                        'Request Mentor',
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                    const Gap(30),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 70,
                        width: 70,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: CupertinoActivityIndicator(),
                            ),
                            if (_userController.isLoading2.isFalse)
                              Image.network(
                                _mentors[i].profilePictureUrl.toString(),
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
                              )
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: ReusableText(
                              '${_mentors[i].firstName} ${_mentors[i].lastName}',
                              fontSize: 15,
                            ),
                          ),
                          if (_mentors[i].currentStatus != '')
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 13.0, top: 4),
                              child: ReusableText(
                                '${_mentors[i].currentStatus}',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          const Gap(4),
                          TextButton(
                            onPressed: () {},
                            child: const ReusableText(
                              'Request Mentor',
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 4, bottom: 8),
                            child: MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    // List<String?> offerings = _mentors[i].map((mentor) => mentor.mentorOfferings).toList();
                                    return AlertDialog(
                                      title: const ReusableText(
                                        "Offerings",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const ReusableText(
                                            'Close',
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                      content: SizedBox(
                                        // height: 300,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              _mentors[i].mentorOfferings!.map(
                                            (offering) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                ),
                                                child: ReusableText(
                                                  offering,
                                                  fontSize: 16,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: CupertinoColors.systemGrey6,
                              child: const ReusableText(
                                'View Offerings',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 70,
                      width: 70,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: CupertinoActivityIndicator(),
                          ),
                          if (_userController.isLoading2.isFalse)
                            Image.network(
                              _mentors[i].profilePictureUrl.toString(),
                              fit: BoxFit.cover,
                              height: 70,
                              width: 70,
                            )
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: ReusableText(
                            '${_mentors[i].firstName} ${_mentors[i].lastName}',
                            fontSize: 15,
                          ),
                        ),
                        if (_mentors[i].currentStatus != '')
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0, top: 4),
                            child: ReusableText(
                              '${_mentors[i].currentStatus}',
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        const Gap(4),
                        TextButton(
                          onPressed: () {},
                          child: const ReusableText(
                            'Request Mentor',
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 4, bottom: 8),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  // List<String?> offerings = _mentors[i].map((mentor) => mentor.mentorOfferings).toList();
                                  return AlertDialog(
                                    title: const ReusableText(
                                      "Offerings",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const ReusableText(
                                          'Close',
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                    content: SizedBox(
                                      // height: 300,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            _mentors[i].mentorOfferings!.map(
                                          (offering) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12,
                                              ),
                                              child: ReusableText(
                                                offering,
                                                fontSize: 16,
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: CupertinoColors.systemGrey6,
                            child: const ReusableText(
                              'View Offerings',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
