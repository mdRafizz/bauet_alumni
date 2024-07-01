import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/reusable_text.dart';

class Fundraising extends StatefulWidget {
  const Fundraising({super.key});

  @override
  State<Fundraising> createState() => _FundraisingState();
}

class _FundraisingState extends State<Fundraising> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 40,
          ),
          children: [
            _fundraisingHeader(),
            const Gap(20),
            _onGoingFundraising(),
            const Gap(20),
            _pastFundraising(),
          ],
        ),
      ),
    );
  }

  Material _fundraisingHeader() {
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
        child: const ReusableText(
          'Fundraising',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Material _onGoingFundraising() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 1.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableText(
              'On Going',
              fontSize: 15,
            ),
            const Gap(25),
            Divider(
              height: .3,
              thickness: .0987,
              color: Colors.grey.shade900,
            ),

            ///******** A condition will be added before visualize this portion after connecting the database **********///
            Container(
              height: 200,
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.volunteer_activism,
                    size: 40,
                    color: Color(0xffb1afba),
                  ),
                  Gap(12),
                  ReusableText(
                    'No fundraising found',
                    color: Color(0xffb1afba),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Material _pastFundraising() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 1.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableText(
                  'Past',
                  fontSize: 15,
                ),
                Gap(10),
                CircleAvatar(
                  radius: 3.5,
                  backgroundColor: Colors.black,
                ),
                Gap(10),
                ReusableText(
                  '10',
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ],
            ),
            const Gap(25),
            Divider(
              height: .3,
              thickness: .0987,
              color: Colors.grey.shade900,
            ),

            ///******** A condition will be added before visualize this portion after connecting the database **********///
            // Container(
            //   // height: 150,
            //   alignment: Alignment.center,
            //   child: const ReusableText(
            //     'No events found',
            //     color: Color(0xffb1afba),
            //   ),
            // )
            ListView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    const Gap(17),
                    Row(
                      children: [
                        const Gap(20),
                        const Icon(
                          Icons.volunteer_activism,
                          size: 35,
                          color: Colors.blue,
                        ),
                        const Gap(22),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const ReusableText(
                                  'IUTAA Zakat Fund 2023',
                                  color: Colors.blue,
                                ),
                              ),
                              const Gap(10),
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: ReusableText(
                                  "Cricketer's Kitchen & Cafe, Club Road, Dhaka, Bangladesh",
                                  color: Colors.black,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(17),
                    if (i < 9)
                      Divider(
                        height: .3,
                        thickness: .0987,
                        color: Colors.grey.shade900,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
