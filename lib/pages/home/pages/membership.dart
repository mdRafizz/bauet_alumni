import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/reusable_text.dart';

class Membership extends StatefulWidget {
  const Membership({super.key});

  @override
  State<Membership> createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.only(top: 20, bottom: 40),
          children: [
            _membershipHeader(),
            const Gap(20),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 19, vertical: 17),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.white,
            //   ),
            //   child: Column(
            //     children: [],
            //   ),
            // )
            _onGoingFundraising(),
          ],
        ),
      ),
    );
  }

  Material _membershipHeader() {
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
          'Membership',
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
              'Purchase membership',
              fontSize: 15,
            ),
            const Gap(25),
            Divider(
              height: .3,
              thickness: .0987,
              color: Colors.grey.shade900,
            ),

            ///******** A condition will be added before visualize this portion after connecting the database **********///
            // Container(
            //   height: 200,
            //   alignment: Alignment.center,
            //   child: const Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.volunteer_activism,
            //         size: 40,                    color: Color(0xffb1afba),
            //       ),
            //       Gap(12),
            //       ReusableText(
            //         'No fundraising found',
            //         color: Color(0xffb1afba),
            //       ),
            //     ],
            //   ),
            // )
            const Gap(25),
            ReusableText(
              'Enter your mailing address',
              color: Color(0xff5e6e83),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            const Gap(17),
            ReusableText(
              'We may need this address to send you membership ID, gifts or other benefits. Delivery charges may be applicable based on your location',
              color: Color(0xff5e6e83),
              fontSize: 13,
            ),
            const Gap(17),
            ReusableText(
              '* This address will be updated in your profile too',
              color: Color(0xff5e6e83),
              fontSize: 11.5,
            ),
            const Gap(17),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(),
                    hintText: 'Address Line 1'),
              ),
            ),
            const Gap(17),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(),
                    hintText: 'Address Line 2 (Optional)'),
              ),
            ),
            const Gap(17),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: const TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(),
                          hintText: 'City'),
                    ),
                  ),
                ),
                const Gap(17),
                Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: const TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(),
                          hintText: 'State (Optional)'),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(17),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(),
                        hintText: 'Country',
                      ),
                    ),
                  ),
                ),
                const Gap(17),
                Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: const TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(),
                          hintText: 'Zip Code (Optional)'),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(25),
            // Divider(
            //   height: .3,
            //   thickness: .0987,
            //   color: Colors.grey.shade900,
            // ),
            MaterialButton(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  // minLeadingWidth: 0,
                  // horizontalTitleGap: 0,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  // leading: AvatarView(
                  //   radius: 11,
                  //   backgroundColor: Colors.white,
                  //   borderColor: Colors.black,
                  //   borderWidth: 1,
                  // ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          'Annula Member',
                        ),
                        Gap(8),
                        ReusableText(
                          '12 months validity',
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 10),
                    child: ReusableText(
                      'Valid from 01 Jan 2024 to 31 Dec 2024',
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  trailing: ReusableText(
                    'BDT 1,500.00',
                    fontSize: 14.7,
                  ),
                ),
              ),
            ),
            const Gap(17),
            MaterialButton(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          'Lifetime Member',
                        ),
                        Gap(8),
                        ReusableText(
                          'Lifetime validity',
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 10),
                    child: ReusableText(
                      'Pay once & get lifetime membership',
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  trailing: ReusableText(
                    'BDT 5,000.00',
                    fontSize: 14.7,
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
