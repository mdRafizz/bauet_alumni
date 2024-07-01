import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import '../../../../controller/user_controller.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({
    super.key,
  });

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  final _user = Get.put<UserController>(UserController());

  @override
  Widget build(BuildContext context) {
    // print(Get.width);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          const Gap(25),
          _profileEditSection(),
          const Gap(17),
          if (_user.user.value!.experiencePosition != '') ...[
            _experiencePart(),
            const Gap(17),
          ],
          _educationPart(),
          const Gap(30),
        ],
      ),
    );
  }

  Material _educationPart() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 1.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
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
                  'Education',
                  fontSize: 19,
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_user.user.value!.sscInstitution != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                          'Secondary School Certificate',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        const Gap(10),
                        ReusableText(
                          '${_user.user.value!.sscInstitution}',
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        if (_user.user.value!.sscDuration != '') ...[
                          const Gap(10),
                          ReusableText(
                            '${_user.user.value!.sscDuration}',
                            fontSize: 12,
                          ),
                        ],
                        // const Gap(8),
                        // ReusableText(
                        //   'Shariatpur Sadar, Shariatpur',
                        //   fontSize: 12,
                        // ),
                        const Gap(30),
                      ],
                    ),
                  if (_user.user.value!.hscInstitution != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                          'Higher Secondary Certificate',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        const Gap(10),
                        ReusableText(
                          '${_user.user.value!.hscInstitution}',
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        if (_user.user.value!.sscInstitution != '') ...[
                          const Gap(10),
                          ReusableText(
                            '${_user.user.value!.hscDuration}',
                            fontSize: 12,
                          ),
                          // const Gap(8),
                          // ReusableText(
                          //   'Dhanuka, Shariatpur',
                          //   fontSize: 12,
                          // ),
                          const Gap(30),
                        ],
                      ],
                    ),
                  if (_user.user.value!.bscDegree != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          '${_user.user.value!.bscDegree}',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        const Gap(10),
                        const ReusableText(
                          'Bangladesh Army University of Engineering & Technology',
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        const Gap(10),
                        if (_user.user.value!.bscDuration != '')
                          ReusableText(
                            '${_user.user.value!.bscDuration}',
                            fontSize: 12,
                          ),
                        // const Gap(8),
                        // ReusableText(
                        //   'Qadirabad Cantonment, Dayarampur, Natore',
                        //   fontSize: 12,
                        // ),
                        const Gap(30),
                      ],
                    ),
                  if (_user.user.value!.mscDegree != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          '${_user.user.value!.mscDegree}',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        const Gap(10),
                        ReusableText(
                          '${_user.user.value!.mscInstitution}',
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        const Gap(10),
                        if (_user.user.value!.mscDuration != '')
                          ReusableText(
                            '${_user.user.value!.mscDuration}',
                            fontSize: 12,
                          ),
                        // const Gap(8),
                        // ReusableText(
                        //   'Qadirabad Cantonment, Dayarampur, Natore',
                        //   fontSize: 12,
                        // ),
                        const Gap(30),
                      ],
                    ),
                  if (_user.user.value!.phdSubject != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          '${_user.user.value!.phdSubject}',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        const Gap(10),
                        ReusableText(
                          '${_user.user.value!.phdInstitution}',
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        const Gap(10),
                        if (_user.user.value!.phdDuration != '')
                          ReusableText(
                            '${_user.user.value!.phdDuration}',
                            fontSize: 12,
                          ),
                        // const Gap(8),
                        // ReusableText(
                        //   'Qadirabad Cantonment, Dayarampur, Natore',
                        //   fontSize: 12,
                        // ),
                        const Gap(30),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material _experiencePart() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 1.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
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
                  'Experience',
                  fontSize: 19,
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        '${_user.user.value!.experiencePosition}',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      if (_user.user.value!.institute != '') ...[
                        const Gap(10),
                        ReusableText(
                          '${_user.user.value!.institute}',
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ],
                      // const Gap(10),
                      // ReusableText(
                      //   'January 2012 - March 2017',
                      //   fontSize: 12,
                      // ),
                      // const Gap(8),
                      // ReusableText(
                      //   'Shariatpur Sadar, Shariatpur',
                      //   fontSize: 12,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material _profileEditSection() {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Get.width >= 1324
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Container(
                                height: 80,
                                width: 80,
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    const Align(
                                      alignment: Alignment.center,
                                      child: CupertinoActivityIndicator(),
                                    ),
                                    Image.network(
                                      '${_user.user.value!.profilePictureUrl}',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    '${_user.user.value!.firstName} ${_user.user.value!.lastName}'),
                                const Gap(5),
                                if (_user.user.value!.currentStatus != '')
                                  ReusableText(
                                    '${_user.user.value!.currentStatus}',
                                    fontSize: 13,
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            ReusableText(
                              'Contact with me',
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                            const Gap(10),
                            Icon(
                              FontAwesomeIcons.whatsapp,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                        const Gap(20),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(EditProfile.routeName);
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.edit_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                                Gap(7),
                                ReusableText(
                                  'Edit Profile',
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.drop_fill,
                              size: 18,
                            ),
                            const Gap(20),
                            ReusableText(
                              '${_user.user.value!.bloodGroup}',
                              fontSize: 14,
                            ),
                          ],
                        ),
                        const Gap(17),
                        Row(
                          children: [
                            const Icon(
                              IcoFontIcons.birthdayCake,
                              size: 18,
                            ),
                            const Gap(20),
                            ReusableText(
                              '${_user.user.value!.dob}',
                              fontSize: 14,
                            ),
                          ],
                        ),
                        const Gap(17),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.phone_solid,
                              size: 18,
                            ),
                            const Gap(20),
                            ReusableText(
                              '${_user.user.value!.phoneNumber}',
                              fontSize: 14,
                            ),
                          ],
                        ),
                        const Gap(17),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.mail_solid,
                              size: 18,
                            ),
                            const Gap(20),
                            ReusableText(
                              '${_user.user.value!.email}',
                              fontSize: 14,
                            ),
                          ],
                        ),
                        const Gap(17),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.location_solid,
                              size: 18,
                            ),
                            const Gap(20),
                            ReusableText(
                              '${_user.user.value!.hometown}',
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Container(
                              height: 80,
                              width: 80,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  const Align(
                                    alignment: Alignment.center,
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  Image.network(
                                    '${_user.user.value!.profilePictureUrl}',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  '${_user.user.value!.firstName} ${_user.user.value!.lastName}'),
                              const Gap(5),
                              if (_user.user.value!.currentStatus != '')
                                ReusableText(
                                  '${_user.user.value!.currentStatus}',
                                  fontSize: 13,
                                ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.drop_fill,
                            size: 18,
                          ),
                          const Gap(20),
                          ReusableText(
                            '${_user.user.value!.bloodGroup}',
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(17),
                      Row(
                        children: [
                          const Icon(
                            IcoFontIcons.birthdayCake,
                            size: 18,
                          ),
                          const Gap(20),
                          ReusableText(
                            '${_user.user.value!.dob}',
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(17),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.phone_solid,
                            size: 18,
                          ),
                          const Gap(20),
                          ReusableText(
                            '${_user.user.value!.phoneNumber}',
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(17),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.mail_solid,
                            size: 18,
                          ),
                          const Gap(20),
                          ReusableText(
                            '${_user.user.value!.email}',
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(17),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.location_solid,
                            size: 18,
                          ),
                          const Gap(20),
                          ReusableText(
                            '${_user.user.value!.hometown}',
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          ReusableText(
                            'Contact with me',
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                          const Gap(10),
                          Icon(
                            FontAwesomeIcons.whatsapp,
                            size: 18,
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                      const Gap(20),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(EditProfile.routeName);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                color: Colors.black,
                                size: 16,
                              ),
                              Gap(7),
                              ReusableText(
                                'Edit Profile',
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
