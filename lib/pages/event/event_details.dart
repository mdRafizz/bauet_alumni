import 'package:alumni2/common/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({
    super.key,
    required this.day,
    required this.title,
    required this.desc,
    required this.location,
    required this.time,
    required this.date,
    required this.member,
    required this.nonMember,
    required this.guest,
    required this.month,
    required this.profileUrl,
    required this.coverUrl,
  });

  final String day;
  final String title;
  final String desc;
  final String location;
  final String time;
  final String date;
  final String member;
  final String nonMember;
  final String guest;
  final String month;
  final String profileUrl;
  final String coverUrl;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 900,
              margin: const EdgeInsets.symmetric(vertical: 50),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: 500,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 400,
                            child: Center(
                              child: LoadingAnimationWidget.halfTriangleDot(
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                          ),
                          Image.network(
                            widget.coverUrl,
                            height: 400,
                            width: 900,
                            fit: BoxFit.cover,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(150),
                                ),
                                child: Image.network(
                                  widget.profileUrl,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          widget.title,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const Gap(35),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 23,
                            ),
                            const Gap(9),
                            ReusableText(
                              widget.location,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const Gap(35),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              size: 23,
                            ),
                            const Gap(9),
                            ReusableText(
                              widget.date,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const Gap(35),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.time,
                              size: 23,
                            ),
                            const Gap(9),
                            ReusableText(
                              widget.time,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const Gap(35),
                        const Divider(
                          thickness: 2,
                          color: CupertinoColors.systemGrey5,
                        ),
                        const Gap(35),
                        const ReusableText(
                          'Event Description',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        const Gap(35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ReusableText(
                            widget.desc,
                            fontSize: 17,
                          ),
                        ),
                        const Gap(35),
                        const Divider(
                          thickness: 2,
                          color: CupertinoColors.systemGrey5,
                        ),
                        const Gap(35),
                        const ReusableText(
                          'Registration Fees',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        const Gap(35),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                "Members: ${widget.member}",
                                fontSize: 17,
                              ),
                              const Gap(15),
                              ReusableText(
                                "Non-members: ${widget.nonMember}",
                                fontSize: 17,
                              ),
                              const Gap(15),
                              ReusableText(
                                "Guest: ${widget.guest}",
                                fontSize: 17,
                              ),
                              const Gap(15),
                            ],
                          ),
                        ),
                        const Gap(40),
                        OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                          ),
                          child: const SizedBox(
                            height: 40,
                            width: 40,
                            child: Icon(
                              CupertinoIcons.back,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        const Gap(40),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
