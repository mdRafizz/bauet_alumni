import 'package:alumni2/pages/event/event_add.dart';
import 'package:alumni2/pages/event/event_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/reusable_text.dart';
import '../../../../controller/user_controller.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final _user = Get.put<UserController>(UserController());

  bool _showEmptyFieldMsg = false;

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
            _eventsHeader(),
            const Gap(20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final DateFormat dateFormat =
                    DateFormat('MMMM d, yyyy', "en_US");
                final DateTime today = DateTime.now();

                List<Map<String, dynamic>> upcomingEvents = [];
                List<Map<String, dynamic>> pastEvents = [];

                for (var doc in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  String dateString = data['date'];
                  DateTime eventDate = dateFormat.parse(dateString);

                  if (eventDate.isBefore(today)) {
                    pastEvents.add(data);
                  } else {
                    upcomingEvents.add(data);
                  }
                }
                return Column(
                  children: [
                    _pastEvents('Upcoming', upcomingEvents),
                    const Gap(20),
                    _pastEvents('Past', pastEvents),
                  ],
                );
              },
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }

  // Material _upcomingEvents() {
  //   return Material(
  //     borderRadius: BorderRadius.circular(10),
  //     elevation: 1.5,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10), color: Colors.white),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const ReusableText(
  //             'Upcoming',
  //             fontSize: 15,
  //           ),
  //           const Gap(25),
  //           Divider(
  //             height: .3,
  //             thickness: .0987,
  //             color: Colors.grey.shade900,
  //           ),
  //
  //           ///******** A condition will be added before visualize this portion after connecting the database **********///
  //           Container(
  //             height: 200,
  //             alignment: Alignment.center,
  //             child: const ReusableText(
  //               'No events found',
  //               color: Color(0xffb1afba),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Material _pastEvents(String hTitle, List<Map<String, dynamic>> events) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 1.5,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableText(
                  hTitle,
                  fontSize: 15,
                ),
                const Gap(10),
                const CircleAvatar(
                  radius: 3.5,
                  backgroundColor: Colors.black,
                ),
                const Gap(10),
                ReusableText(
                  events.length.toString(),
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ],
            ),
            const Gap(25),

            ///******** A condition will be added before visualize this portion after connecting the database **********///
            // Container(
            //   // height: 150,
            //   alignment: Alignment.center,
            //   child: const ReusableText(
            //     'No events found',
            //     color: Color(0xffb1afba),
            //   ),
            // )
            if (events.isNotEmpty)
              ListView.builder(
                itemCount: events.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (_, i) {
                  var event = events[i];
                  return Column(
                    children: [
                      _eventDetailsSection(
                        event['day'],
                        event['title'],
                        event['desc'],
                        event['location'],
                        event['time'],
                        event['date'],
                        event['regMembers'],
                        event['regNonMembers'],
                        event['guest'],
                        event['month'],
                        event['coverPictureUrl'],
                        event['profilePictureUrl'],
                      ),
                      if (i < events.length - 1)
                        const Divider(
                          color: CupertinoColors.systemGrey3,
                          height: 1,
                        ),
                    ],
                  );
                },
              ),
            if (events.isEmpty)
              SizedBox(
                height: 150,
                child: Center(
                  child: ReusableText(
                    'No $hTitle event available',
                    color: Colors.grey.shade600,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Material _eventsHeader() {
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
              'Events',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            if (_user.user.value!.role == 'admin')
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(EventAdd.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const ReusableText(
                  'Add Event',
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            // const Gap(40),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const ReusableText(
            //     'My Ticket',
            //     fontSize: 13,
            //   ),
            // ),
            const Gap(30),
          ],
        ),
      ),
    );
  }

  Widget _eventDetailsSection(
    String day,
    String title,
    String desc,
    String location,
    String time,
    String date,
    String member,
    String nonMember,
    String guest,
    String month,
    String coverUrl,
    String profileUrl,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: CupertinoColors.white,
      ),
      child: ListTile(
        horizontalTitleGap: 28,
        onTap: () => Get.to(
          () => EventDetails(
            day: day,
            title: title,
            desc: desc,
            location: location,
            time: time,
            date: date,
            member: member,
            nonMember: nonMember,
            guest: guest,
            month: month,
            profileUrl: profileUrl,
            coverUrl: coverUrl,
          ),
        ),
        focusColor: CupertinoColors.systemBlue.withOpacity(.1),
        dense: true,
        visualDensity: const VisualDensity(vertical: 3),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            // height: 50,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              border: Border.all(color: Colors.red),
            ),
            child: Column(
              children: [
                Container(
                  height: 25,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: ReusableText(
                    month,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
                Container(
                  height: 27,
                  alignment: Alignment.center,
                  child: ReusableText(
                    day,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: const Color(0xffb1afba),
                  ),
                )
              ],
            ),
          ),
        ),
        title: ReusableText(
          title,
          color: Colors.blue,
        ),
        subtitle: ReusableText(
          location,
          color: Colors.black,
          fontSize: 12.5,
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}
