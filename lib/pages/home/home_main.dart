import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/controller/user_controller.dart';
import 'package:alumni2/controller/web_menu_controller.dart';
import 'package:alumni2/pages/root/root_main.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../data/menu_data.dart';
import '../../data/model/menu_model.dart';
import '../../data/model/user_model.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();

  static const String routeName = '/home';
}

class _HomeMainState extends State<HomeMain> {
  final _sideMenuController = Get.put<WebMenuController>(WebMenuController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _userController = Get.put<UserController>(UserController());

  UserModel? _user;
  bool _isLoading = true;

  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String email = currentUser.email!;
      UserModel? user = await getUserData(email);

      setState(() {
        _user = user;
        _isLoading = false;
        _userController.user.value = _user;
        _userController.isLoading.value = _isLoading;
      });
    }
  }

  Future<UserModel?> getUserData(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot doc = await users.doc(email).get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        debugPrint('User does not exist');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    // debugPrint(w);
    if (!_isLoading) {
      return SelectionArea(
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: _myProfileSectionM(context),
            body: Column(
              children: [
                _topBar(context),
                Expanded(
                  child: LayoutBuilder(builder: (context, __) {
                    if (MediaQuery.of(context).size.width >= 980) {
                      return Row(
                        children: [
                          Gap(w * .07),
                          _myProfileSection(context),
                          Obx(
                            () => Expanded(
                                child: _sideMenuController.getScreen()),
                          ),
                          Gap(w * .1),
                        ],
                      );
                    } else {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: _sideMenuController.getScreen(),
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }

  Widget _myProfileSection(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: 280,
      height: double.maxFinite,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.only(right: 30),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 1,
                child: Container(
                  width: 250,
                  height: 200,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      /******** Cover Photo **********/
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        // bottom: 30,
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: LoadingAnimationWidget.flickr(
                                leftDotColor: Colors.blue,
                                rightDotColor: Colors.green,
                                size: 16,
                              ),
                              // width: double.maxFinite,
                            ),
                            if (!_isLoading)
                              Image.network(
                                '${_user?.coverPictureUrl}',
                                height: 90,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 93.5,
                        child: Container(
                          // alignment: Alignment.center,
                          // height: 30,
                          // width: double.maxFinite,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(26),
                              _isLoading
                                  ? LoadingAnimationWidget.prograssiveDots(
                                      color: Colors.black, size: 14)
                                  : ReusableText(
                                      '${_user?.firstName} ${_user?.lastName}' ??
                                          'N/A',
                                      textAlign: TextAlign.center,
                                      fontSize: 14,
                                    ),
                              const Spacer(),
                              Obx(
                                () => TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        _sideMenuController.currentPage.value ==
                                                MenuData.viewProfile
                                            ? Colors.grey.shade200
                                            : null,
                                  ),
                                  onPressed: () {
                                    _sideMenuController.currentPage.value =
                                        MenuData.viewProfile;
                                    // Navigator.of(context).pop();
                                  },
                                  child: ReusableText(
                                    'View Profile',
                                    fontSize: 12,
                                    color:
                                        _sideMenuController.currentPage.value ==
                                                MenuData.viewProfile
                                            ? Colors.blue
                                            : Colors.black,
                                  ),
                                ),
                              ),
                              const Gap(5),
                            ],
                          ),
                        ),
                      ),

                      /************** Profile Pic *******************/
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 90,
                        child: CupertinoActivityIndicator(),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!_isLoading)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  height: 61,
                                  width: 61,
                                  child: Image.network(
                                    '${_user!.profilePictureUrl}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(20),
            Obx(
              () => Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 1,
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: MenuData.all.map(buildItem).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myProfileSectionM(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: double.maxFinite,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          // padding: const EdgeInsets.only(right: 30),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Gap(20),
            Container(
              width: 350,
              height: 230,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  /******** Cover Photo **********/
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    // bottom: 30,
                    child: Container(
                      height: 100,
                      // width: double.maxFinite,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/cover.jpg'),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 105.5,
                    child: Container(
                      // alignment: Alignment.center,
                      // height: 30,
                      // width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        // color: Colors.sy,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(26),
                          ReusableText(
                            '${_user?.firstName} ${_user?.lastName}',
                            textAlign: TextAlign.center,
                            fontSize: 14,
                          ),
                          const Gap(5),
                          Obx(
                            () => TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    _sideMenuController.currentPage.value ==
                                            MenuData.viewProfile
                                        ? Colors.white
                                        : null,
                              ),
                              onPressed: () {
                                _sideMenuController.currentPage.value =
                                    MenuData.viewProfile;
                                Navigator.of(context).pop();
                              },
                              child: ReusableText(
                                'View Profile',
                                fontSize: 12,
                                color: _sideMenuController.currentPage.value ==
                                        MenuData.viewProfile
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ),
                          const Gap(5),
                        ],
                      ),
                    ),
                  ),

                  /************** Profile Pic *******************/
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AvatarView(
                          imagePath: 'assets/images/me.jpg',
                          // backgroundImage: AssetImage('assets/images/me.jpg'),
                          radius: 40,
                          borderWidth: 1.5,
                          borderColor: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Gap(20),
            Obx(
              () => Container(
                width: 320,
                padding: const EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: MenuData.all.map(buildItem).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Material(
      elevation: .5,
      child: Container(
        color: CupertinoColors.white,
        // height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LayoutBuilder(builder: (context, __) {
              if (MediaQuery.of(context).size.width >= 980) {
                return Row(
                  children: [
                    const Gap(30),
                    Image.asset(
                      'assets/icons/bauet_logo.png',
                      height: 28,
                      width: 28,
                    ),
                    const Gap(16),
                    const ReusableText(
                      'BAUET\nAlumni Association',
                      fontSize: 12,
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu_rounded,
                        size: 27,
                      ),
                    ),
                    const Gap(20),
                    Image.asset(
                      'assets/icons/bauet_logo.png',
                      height: 28,
                    ),
                    const Gap(16),
                    const ReusableText(
                      'BAUET\nAlumni Association',
                      fontSize: 12,
                    ),
                  ],
                );
              }
            }),
            const Spacer(),
            const Icon(
              Icons.home_rounded,
              size: 22,
            ),
            const Gap(14),
            GestureDetector(
              onTapDown: (details) {
                _showPopupMenu(context, details.globalPosition);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Container(
                  color: Colors.white,
                  height: 30,
                  width: 30,
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(),
                      ),
                      if (!_isLoading)
                        Image.network(
                          _user!.profilePictureUrl!,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, left + 1, top + 1),
      items: [
        PopupMenuItem(
          value: "logout",
          child: Text("Logout"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == "logout") {
        // Perform logout action
        _signOut();
        // Add your logout logic here
      }
    });
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut().then(
          (_) => Get.offAllNamed(RootMain.routeName),
        );
  }

  Widget buildItem(MenuModel item) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _sideMenuController.currentPage.value == item
            ? Colors.grey.shade100
            : Colors.white,
      ),
      child: ListTile(
        selected: _sideMenuController.currentPage.value == item,
        minLeadingWidth: 22,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            item.iconData,
            size: 16,
            color: _sideMenuController.currentPage.value == item
                ? Colors.blue
                : Colors.black,
          ),
        ),
        title: ReusableText(
          item.name,
          fontSize: 13,
          color: _sideMenuController.currentPage.value == item
              ? Colors.blue
              : Colors.black,
        ),
        onTap: () {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
          }
          _sideMenuController.currentPage.value = item;
          // _sideMenuController.toggleDrawer();
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
