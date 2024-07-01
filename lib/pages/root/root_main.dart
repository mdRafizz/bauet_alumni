import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/pages/forget_password/forget_password.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

import '../home/home_main.dart';
import '../sign_up/signup_new.dart';

class RootMain extends StatefulWidget {
  const RootMain({super.key});

  static const String routeName = '/rootPage';

  @override
  State<RootMain> createState() => _RootMainState();
}

class _RootMainState extends State<RootMain> {
  var whyJoinPhone = <Map<String, String>>[
    {
      'img': 'assets/images/reconnect.jpg',
      'title': 'Reconnect',
      'desc':
          'Reconnect with your friends, classmates, seniors and juniors in the secured, ad-free IUT Alumni Network.',
    },
    {
      'img': 'assets/images/giveback.png',
      'title': 'Give Back',
      'desc':
          'Give Back to your alma mater and your fellow alumni by participating in a fundraiser event, mentoring other alumni.',
    },
    {
      'img': 'assets/images/career.jpg',
      'title': 'Advance',
      'desc':
          'Advance your career, post a job and look for open positions in the companies in your own professional network.',
    },
  ];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  var _obscureText = true;

  //
  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SelectionArea(
        child: Scaffold(
          drawer: Drawer(
            child: Container(
              width: 350,
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CupertinoColors.systemGrey6,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/bauet_logo.png',
                          height: 55,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'BAUET',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'Alumni Association',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          height: 70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.info, size: 19.5),
                              Gap(18),
                              ReusableText(
                                'About',
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: 70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Icon(IcoFontIcons.mail, size: 19.5),
                              Gap(18),
                              ReusableText(
                                'Contact',
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: 70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.group, size: 19.5),
                              Gap(18),
                              ReusableText(
                                'Committee',
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: 70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.business, size: 19.5),
                              Gap(18),
                              ReusableText(
                                'Business',
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: 70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.article, size: 19.5),
                              Gap(18),
                              ReusableText(
                                'News',
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              LayoutBuilder(builder: (context, _) {
                if (w >= 980) {
                  return Container(
                    height: 75,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 1),
                          child: Image.asset('assets/icons/bauet_logo.png'),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              'BAUET',
                              fontSize: 12,
                            ),
                            ReusableText(
                              'Alumni Association',
                              fontSize: 8.5,
                            ),
                          ],
                        ),
                        const Gap(45),
                        TextButton(
                          onPressed: () {},
                          child: const ReusableText(
                            'About',
                            color: Color(0xff738d9b),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(37),
                        TextButton(
                          onPressed: () {},
                          child: const ReusableText(
                            'Contact',
                            color: Color(0xff738d9b),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(37),
                        TextButton(
                          onPressed: () {},
                          child: const ReusableText(
                            'Committee',
                            color: Color(0xff738d9b),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(37),
                        TextButton(
                          onPressed: () {},
                          child: const ReusableText(
                            'Business',
                            color: Color(0xff738d9b),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(37),
                        TextButton(
                          onPressed: () {},
                          child: const ReusableText(
                            'News',
                            color: Color(0xff738d9b),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.5,
                    ),
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// SideNav Button
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.menu_rounded,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/bauet_logo.png',
                                  height: 33,
                                ),
                                const Gap(5),
                                const ReusableText(
                                  'BAUET Alumni Association',
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(55),
                      ],
                    ),
                  );
                }
              }),
              _divider(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _loginSection(context, w),
                    // _divider(),
                    LayoutBuilder(builder: (_, __) {
                      if (w >= 1016) {
                        return Container(
                          height: h * .87,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Container(
                                width: w * .50,
                                // padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const ReusableText(
                                      'Our Network\nAround The Globe',
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      wordSpacing: 1,
                                    ),
                                    const Gap(8),
                                    ReusableText(
                                      'Easily Find your Connections Everywhere',
                                      fontSize: 13,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      wordSpacing: 1,
                                    ),
                                    const Gap(15),
                                    /********************************************************************************************************************************************************************************************************************/

                                    /// here is assigned how many members are there business and other things
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          // height: 25,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          // width: w*.05,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                '1774',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color:
                                                    CupertinoColors.systemBlue,
                                              ),
                                              Gap(6),
                                              ReusableText(
                                                'Members',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 38,
                                          width: .5,
                                          color: Colors.grey[400],
                                        ),
                                        const Gap(15),
                                        Container(
                                          // height: 25,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          // width: 34,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                '300',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color:
                                                    CupertinoColors.systemBlue,
                                              ),
                                              Gap(6),
                                              ReusableText(
                                                'Organization',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 38,
                                          width: .5,
                                          color: Colors.grey[400],
                                        ),
                                        const Gap(15),
                                        Container(
                                          // height: 25,
                                          // width: 34,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                '20',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color:
                                                    CupertinoColors.systemBlue,
                                              ),
                                              Gap(6),
                                              ReusableText(
                                                'Initiatives',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: w * .50,
                                height: h * .87,
                                child: Image.asset(
                                    'assets/images/around_global.jpg'),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          height: h * .9,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/around_global.jpg'),
                              fit: BoxFit.cover,
                              // opacity: .6,
                            ),
                          ),
                          child: GlassContainer(
                            height: h * .9,
                            width: double.maxFinite,
                            blur: 5,
                            color: Colors.white.withOpacity(0.3),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.blue.withOpacity(0.3),
                              ],
                            ),
                            shadowStrength: 5,
                            shadowColor: Colors.white.withOpacity(0.24),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ReusableText(
                                  'Our Network\nAround The Globe',
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  wordSpacing: 1,
                                ),
                                Gap(8),
                                ReusableText(
                                  'Easily Find your Connections Everywhere',
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  wordSpacing: 1,
                                ),
                                Gap(30),
                                /********************************************************************************************************************************************************************************************************************/

                                /// here is assigned how many members are there business and other things
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                          '1774',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: CupertinoColors.systemBlue,
                                        ),
                                        Gap(6),
                                        ReusableText(
                                          'Members',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    Gap(30),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                          '300',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: CupertinoColors.systemBlue,
                                        ),
                                        Gap(6),
                                        ReusableText(
                                          'Organization',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    Gap(30),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                          '20',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: CupertinoColors.systemBlue,
                                        ),
                                        Gap(6),
                                        ReusableText(
                                          'Initiatives',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
                    const Gap(80),
                    Container(
                      height: 600,
                      color: Colors.white,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ReusableText(
                            'Still thinking over it?',
                            color: Colors.grey,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.4,
                          ),
                          const Gap(8),
                          const ReusableText(
                            'Here is why you should join us',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          const Gap(35),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, __) {
                                if (w >= 1094.4) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: whyJoinPhone.length,
                                    itemBuilder: (_, i) {
                                      return Row(
                                        children: [
                                          Card(
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              height: h * .55,
                                              width: 320,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 20,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AvatarView(
                                                    imagePath: whyJoinPhone[i]
                                                        ['img']!,
                                                    radius: 35,
                                                  ),
                                                  // const Gap(20),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: CupertinoColors
                                                          .systemBlue
                                                          .withOpacity(.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: ReusableText(
                                                      whyJoinPhone[i]['title']!,
                                                      fontSize: 15,
                                                      color: CupertinoColors
                                                          .systemBlue,
                                                    ),
                                                  ),
                                                  // const Gap(20),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 14),
                                                    child: ReusableText(
                                                      whyJoinPhone[i]['desc']!,
                                                      fontSize: 14.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Gap(50),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return CardSwiper(
                                    cardsCount: whyJoinPhone.length,
                                    cardBuilder: (context, i, percentThresholdX,
                                            percentThresholdY) =>
                                        Center(
                                      child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          // height: 380,
                                          width: 320,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AvatarView(
                                                imagePath: whyJoinPhone[i]
                                                    ['img']!,
                                                radius: 35,
                                              ),
                                              // const Gap(20),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: CupertinoColors
                                                      .systemBlue
                                                      .withOpacity(.1),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: ReusableText(
                                                  whyJoinPhone[i]['title']!,
                                                  fontSize: 15,
                                                  color: CupertinoColors
                                                      .systemBlue,
                                                ),
                                              ),
                                              // const Gap(20),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14),
                                                child: ReusableText(
                                                  whyJoinPhone[i]['desc']!,
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(40),
                    Container(
                      height: h * .80,
                      // color: Colors.white,
                      width: w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bauet_view.jpeg'),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: GlassContainer(
                        height: h * .80,
                        width: double.maxFinite,
                        blur: 3,
                        color: Colors.white.withOpacity(0.1),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3),
                          ],
                        ),
                        shadowStrength: 5,
                        shadowColor: Colors.white.withOpacity(0.24),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Join today BAUET Alumni Association. Build your network, reunite with everyone from your Department. Grow & evolve in your career with us.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  wordSpacing: 1,
                                  fontSize: 25,
                                  fontFamily: 'poppins',
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(10.0, 10.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(10.0, 10.0),
                                      blurRadius: 8.0,
                                      color: CupertinoColors.black,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Gap(h * .1),
                              MaterialButton(
                                minWidth: w * .3,
                                onPressed: () {
                                  // Create account action
                                },
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                color: fromCssColor('#8A8AFF'),
                                child: const ReusableText(
                                  'Sign up now',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: h * .8,
                      width: w,
                      color: Colors.white,
                    ),
                    Container(
                      height: h * .70,
                      width: double.maxFinite,
                      color: const Color(0xff0B1727),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _loginSection(BuildContext context, double w) {
    return Stack(
      children: [
        Opacity(
          opacity: .1,
          child: Image.asset(
            'assets/images/login_bg.jpg',
            height: MediaQuery.of(context).size.height * .95,
            width: double.maxFinite,
          ),
        ),
        Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * .95,
          width: double.maxFinite,
          child: LayoutBuilder(
            builder: (_, __) {
              if (w >= 980) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/alumni_poster.png',
                      width: MediaQuery.of(context).size.width * .5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: w * .09),
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Join the ',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'BAUET Alumni Association',
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' to reconnect with your friends, classmates, seniors & juniors.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(70),
                          LayoutBuilder(builder: (context, _) {
                            return w >= 1229
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: _emailController,
                                        ),
                                      ),
                                      const Gap(20),
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              labelText: 'Password',
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  if (_obscureText) {
                                                    setState(() {
                                                      _obscureText = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _obscureText = true;
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  _obscureText
                                                      ? Icons.visibility_rounded
                                                      : Icons
                                                          .visibility_off_rounded,
                                                  size: 17,
                                                ),
                                              )),
                                          controller: _passwordController,
                                          obscureText: _obscureText,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      TextField(
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const Gap(26),
                                      TextField(
                                        decoration: InputDecoration(
                                            labelText: 'Password',
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                if (_obscureText) {
                                                  setState(() {
                                                    _obscureText = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _obscureText = true;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                        .visibility_off_rounded,
                                                size: 17,
                                              ),
                                            )),
                                        controller: _passwordController,
                                        obscureText: _obscureText,
                                      ),
                                    ],
                                  );
                          }),
                          const SizedBox(height: 26.0),
                          MaterialButton(
                            minWidth: w * .4,
                            onPressed: _login,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            color: fromCssColor('#006FFF'),
                            child: _isLoading
                                ? Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  )
                                : const ReusableText(
                                    'Log in',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                          ),
                          const SizedBox(height: 8.0),
                          TextButton(
                            onPressed: () => Get.toNamed(
                              ForgetPassword.routeName,
                            ),
                            child: const ReusableText(
                              'Forgot Password?',
                              fontSize: 13.5,
                              color: Colors.blue,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 22.0),
                          MaterialButton(
                            minWidth: w * .4,
                            onPressed: () {
                              Get.toNamed(SignUpNew.routeName);
                              // Create account action
                            },
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            color: fromCssColor('#8A8AFF'),
                            child: const ReusableText(
                              'Create Account',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/images/alumni_poster.png',
                        height: MediaQuery.of(context).size.height * .4,
                        opacity: const AlwaysStoppedAnimation(0.6),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: w * .09),
                        // height: MediaQuery.of(context).size.height * .475,
                        width: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Join the ',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'BAUET Alumni Association',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' to reconnect with your friends, classmates, seniors & juniors.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(70),
                            TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const Gap(26),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (_obscureText) {
                                        setState(() {
                                          _obscureText = false;
                                        });
                                      } else {
                                        setState(() {
                                          _obscureText = true;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 17,
                                    ),
                                  )),
                              controller: _passwordController,
                              obscureText: _obscureText,
                            ),
                            const SizedBox(height: 26.0),
                            MaterialButton(
                              minWidth: 500,
                              onPressed: _login,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              color: fromCssColor('#006FFF'),
                              child: const ReusableText(
                                'Log in',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextButton(
                              onPressed: () {
                                // Add your forgot password logic here
                              },
                              child: const ReusableText(
                                'Forgot Password?',
                                fontSize: 13.5,
                                color: Colors.blue,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(height: 22.0),
                            MaterialButton(
                              minWidth: 500,
                              onPressed: () {
                                Get.toNamed(SignUpNew.routeName);
                                // Create account action
                              },
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              color: fromCssColor('#8A8AFF'),
                              child: const ReusableText(
                                'Create Account',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
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

  Container _divider() {
    return Container(
      color: Colors.grey.shade600,
      height: .26,
      width: double.maxFinite,
    );
  }

  // void _logIn() async {
  //   try {
  //     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
  //       _errorDialogue(context, 'Fill the email and password field.');
  //       return;
  //     }
  //     if (!_emailController.text.contains('@gmail.com')) {
  //       _errorDialogue(context, 'Email address is badly formatted.');
  //       return;
  //     }
  //     if (!isUserExist(_emailController.text)) {
  //       _errorDialogue(context,
  //           'The email address you entered is not found in our system. Please check and try again.');
  //       return;
  //     }
  //
  //     setState(() {
  //       _isFileUploading = true;
  //     });
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     )
  //         .then((value) {
  //       setState(() {
  //         _isFileUploading = false;
  //       });
  //       Get.offAllNamed(HomeMain.routeName);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       _isFileUploading = false;
  //     });
  //     _errorDialogue(context, e.message.toString());
  //   }
  // }

  // List<String> emails = []; // Corrected type here
  // bool isUserExist(String email) {
  //   for (var user in emails) {
  //     if (user == email) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Future<void> fetchEmails() async {
  //   try {
  //     QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('students').get();
  //     List<String> fetchedEmails =
  //         querySnapshot.docs.map((doc) => doc['email'] as String).toList();
  //
  //     setState(() {
  //       emails = fetchedEmails;
  //     });
  //   } catch (e) {
  //     debugPrint("Error fetching emails: $e");
  //   }
  // }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          const uuid = Uuid();
          final id = uuid.v1();

          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.email)
              .get();

          if (!userDoc.exists) {
            FirebaseFirestore.instance.collection('users').doc(user.email).set({
              'profilePictureUrl':
                  "https://firebasestorage.googleapis.com/v0/b/bauet-alumni-3504f.appspot.com/o/profile_pictures%2F6769264_60111.jpg?alt=media&token=53736915-f636-4f0c-8ca7-2ef400cf67f8",
              'coverPictureUrl':
                  "https://firebasestorage.googleapis.com/v0/b/bauet-alumni-3504f.appspot.com/o/cover_pictures%2F4547.jpg?alt=media&token=026d1e5c-ec90-4c29-aeab-9d6fd33ae8a3",
              'id': id,
              'firstName': user.displayName,
              'lastName': '',
              'phoneNumber': '',
              'email': user.email,
              'studentId': '',
              'password': _passwordController.text,
              'role': 'user',
              'sscInstitution': '',
              'sscDuration': '',
              'hscInstitution': '',
              'hscDuration': '',
              'bscInstitution': '',
              'bscDuration': '',
              'bscDegree': '',
              'mscInstitution': '',
              'mscDuration': '',
              'mscDegree': '',
              'phdInstitution': '',
              'phdDuration': '',
              'phdSubject': '',
              'currentStatus': '',
              'experiencePosition': '',
              'institute': '',
              'dob': '',
              'bloodGroup': '',
              'hometown': '',
              'whatsappNumber': '',
              'wantToMentor': "No",
              'mentorOfferings': [],
            }, SetOptions(merge: true));
          }

          Get.offAllNamed(HomeMain.routeName);
        } else {
          _errorDialogue(
              context, 'Please verify your email before logging in.');
          await FirebaseAuth.instance
              .signOut(); // Sign out the user if email is not verified
        }
      }
    } catch (e) {
      _errorDialogue(context, 'Failed to login');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
