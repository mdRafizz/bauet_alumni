import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../../../../common/reusable_text.dart';

class Business extends StatefulWidget {
  const Business({super.key});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  final companyName = <String>['Byte Capsule Ltd', 'Fabrilife'];

  final companyDesc = <String>[
    'Cyber Security training institute',
    'Matching style and class with luxury and comfort',
  ];

  final imgAssets = <String>[
    'assets/images/byteCapsule.png',
    'assets/images/fabrilife.png',
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          const Gap(25),
          _totalBusiness(),
          const Gap(30),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  _businessCard(i),
                  const Gap(17),
                ],
              );
            },
            itemCount: companyName.length,
          ),
        ],
      ),
    );
  }

  Material _totalBusiness() {
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
                    'Business directory',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 3,
                  ),
                  const Gap(10),
                  const ReusableText(
                    '2',
                    color: Colors.blue,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _addNewBusiness();
                    },
                    child: const ReusableText(
                      '+ New',
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
                  const Row(
                    children: [
                      ReusableText(
                        'Business directory',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Gap(10),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 3,
                      ),
                      Gap(10),
                      ReusableText(
                        '2',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _addNewBusiness,
                        child: const ReusableText(
                          '+ New',
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

  void _addNewBusiness() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (MediaQuery.of(context).size.width >= 765) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 0,
              top: 10,
            ),
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
            content: const AddBusinessDialogue(),
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

  _businessCard(int i) {
    return ExpansionTileCard(
      baseColor: Colors.white,
      expandedColor: Colors.white,
      initialElevation: 1,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      title: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: ReusableText(
          companyName[i],
          fontSize: 15,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: ReusableText(
          companyDesc[i],
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      leading: AvatarView(
        radius: 30,
        imagePath: imgAssets[i],
        avatarType: AvatarType.RECTANGLE,
      ),
      children: [
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
                    loremIpsum(words: 30),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Category',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 3),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Offers',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 30),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Email',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 3),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Mobile Number',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 30),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Address',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 3),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Google Map Url',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 30),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Website',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 3),
                    fontSize: 15.5,
                  ),
                ),
                const Gap(20),
                const ReusableText(
                  'Facebook',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12,
                  ),
                  child: ReusableText(
                    loremIpsum(words: 3),
                    fontSize: 15.5,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

///------------New Class------------///
class AddBusinessDialogue extends StatefulWidget {
  const AddBusinessDialogue({super.key});

  @override
  State<AddBusinessDialogue> createState() => _AddBusinessDialogueState();
}

class _AddBusinessDialogueState extends State<AddBusinessDialogue> {
  var isImageFetched = false;
  FilePickerResult? picked;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  final _businessName = TextEditingController();
  final _businessTagline = TextEditingController();
  final _category = TextEditingController();
  final _description = TextEditingController();
  final _note = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();
  final _mapUrl = TextEditingController();
  final _websiteUrl = TextEditingController();
  final _facebookUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: 800,
      child: ListView(
        children: [
          const Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                picked = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (picked != null) {
                  setState(() {
                    isImageFetched = true;
                  });
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /********** Profile Pic avatar ************************************/
                    CircleAvatar(
                      radius: isImageFetched ? 50 : 42,
                      backgroundImage: isImageFetched
                          ? Image.memory(picked!.files.first.bytes!).image
                          : Image.asset(
                              'assets/images/user_img.png',
                              fit: BoxFit.cover,
                            ).image,
                    ),
                    if (!isImageFetched) ...[
                      const Gap(20),
                      const ReusableText(
                        'Pick your business icon',
                        // fontSize: 14,
                      ),
                    ],
                  ],
                ),
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
                          _commonTextField(
                            'Name of your business',
                            '',
                            _businessName,
                          ),
                          const Gap(17),
                          _commonTextField(
                              'Business tagline', '', _businessTagline),
                          const Gap(17),
                          _commonTextField(
                            'Categories',
                            '',
                            _category,
                          ),
                          const Gap(17),
                          _commonTextField(
                            'Description',
                            '',
                            _description,
                          ),
                          const Gap(17),
                          _commonTextField('Offers note', 'Optional', _note),
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
                          Row(
                            children: [
                              Expanded(
                                child: _commonTextField(
                                  'Email address',
                                  'Optional',
                                  _email,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: _commonTextField(
                                  'Mobile number',
                                  'Optional',
                                  _mobile,
                                ),
                              ),
                            ],
                          ),
                          const Gap(22),
                          Row(
                            children: [
                              Expanded(
                                child: _commonTextField(
                                  'Address',
                                  'Optional',
                                  _address,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: _commonTextField(
                                  'Google map URL',
                                  'Optional',
                                  _mapUrl,
                                ),
                              ),
                            ],
                          ),
                          const Gap(22),
                          Row(
                            children: [
                              Expanded(
                                child: _commonTextField(
                                  'Website URL',
                                  'Optional',
                                  _websiteUrl,
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: _commonTextField(
                                  'Facebook URL',
                                  'Optional',
                                  _facebookUrl,
                                ),
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
                  if (_businessName.text.isEmpty ||
                      _businessTagline.text.isEmpty ||
                      _category.text.isEmpty ||
                      _description.text.isEmpty) {
                    Get.snackbar(
                      'Empty fields!',
                      'Fill the required field',
                      maxWidth: 400,
                      margin: const EdgeInsets.only(top: 20),
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                    );
                  }
                },
              ),
              const Gap(9),
            ],
          ),
          const Gap(40),
        ],
      ),
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
}
