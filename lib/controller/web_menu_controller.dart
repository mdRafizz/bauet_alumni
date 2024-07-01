import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/menu_data.dart';
import '../pages/event/events.dart';
import '../pages/home/pages/business.dart';
import '../pages/home/pages/fundraisings.dart';
import '../pages/home/pages/jobs.dart';
import '../pages/home/pages/members.dart';
import '../pages/home/pages/membership.dart';
import '../pages/home/pages/mentors.dart';
import '../pages/home/pages/my_feed.dart';
import '../pages/profile/profile_main.dart';

class WebMenuController extends GetxController {
  var currentPage = MenuData.myFeed.obs;

  Widget getScreen() {
    switch (currentPage.value) {
      case MenuData.myFeed:
        return const MyFeed();
      case MenuData.membership:
        return const Membership();
      case MenuData.members:
        return const Members();
      case MenuData.mentor:
        return const Mentors();
      // case MenuData.offers:
      //   return Offers();
      case MenuData.business:
        return const Business();
      // case MenuData.insights:
      //   return Insights();
      case MenuData.events:
        return const Events();
      case MenuData.fundraising:
        return const Fundraising();
      case MenuData.jobs:
        return const Jobs();
      default:
        return const ProfileMain();
    }
  }
}
