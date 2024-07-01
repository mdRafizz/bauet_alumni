import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/controller/web_menu_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../controller/user_controller.dart';
import '../../../../../data/model/user_model.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  final _userController = Get.put<UserController>(UserController());

  final _webMenuController = Get.put<WebMenuController>(WebMenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: [
            const Gap(25),
            _totalMembers(_userController.users.length),
            const Gap(30),
            AlignedGridView.count(
              crossAxisCount: MediaQuery.of(context).size.width >= 1230
                  ? 2
                  : MediaQuery.of(context).size.width < 980 &&
                          MediaQuery.of(context).size.width >= 800
                      ? 2
                      : 1,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 5.0,
              itemBuilder: (_, i) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _singleMembersSection(i),
                    const Gap(17),
                  ],
                );
              },
              itemCount: _userController.users.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  Material _singleMembersSection(int i) {
    UserModel user = _userController.users[i];
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
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
                        user.profilePictureUrl.toString(),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: ReusableText(
                      '${user.firstName} ${user.lastName}',
                      fontSize: 15,
                    ),
                  ),
                  // const Gap(5),
                  // const Gap(5),
                  IconButton(
                    onPressed: () {
                      copyToClipboard(user.email!);
                    },
                    // height: 40,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    icon: const Icon(
                      Icons.mail_outline,
                      color: Colors.blue,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }

  Material _totalMembers(int totalMembers) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ReusableText(
              'Members',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const Gap(10),
            const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 3,
            ),
            const Gap(10),
            ReusableText(
              totalMembers.toString(),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        width: 600,
        content: ReusableText(
          'Email copied to clipboard',
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
