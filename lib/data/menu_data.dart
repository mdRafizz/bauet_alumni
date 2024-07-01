import 'package:flutter/material.dart';

import 'model/menu_model.dart';

class MenuData {
  static const myFeed = MenuModel(
    'My Feed',
    Icons.feed,
  );
  static const members = MenuModel(
    'Members',
    Icons.group,
  );

  static const mentor = MenuModel(
    'Mentor',
    Icons.beach_access,
  );
  static const jobs = MenuModel(
    'Jobs',
    Icons.work_rounded,
  );

  // static const offers = MenuModel(
  //   'Offers',
  //   Icons.workspaces,
  // );

  static const business = MenuModel(
    'Business',
    Icons.business_center,
  );

  // static const insights = MenuModel(
  //   'Insight',
  //   Icons.insights,
  // );
  static const events = MenuModel(
    'Events',
    Icons.calendar_month,
  );
  static const fundraising = MenuModel(
    'Fundraising',
    Icons.volunteer_activism,
  );
  static const membership = MenuModel(
    'Membership',
    Icons.workspace_premium,
  );

  static const viewProfile = MenuModel(
    '',
    Icons.workspace_premium,
  );

  static const all = <MenuModel>[
    myFeed,
    members,
    mentor,
    jobs,
    business,
    // offers,
    // insights,
    events,
    fundraising,
    membership,
  ];
}
