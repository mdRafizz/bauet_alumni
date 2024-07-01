import 'package:alumni2/pages/event/event_add.dart';
import 'package:alumni2/pages/forget_password/forget_password.dart';
import 'package:alumni2/pages/home/home_main.dart';
import 'package:alumni2/pages/profile/edit_profile.dart';
import 'package:alumni2/pages/root/root_main.dart';
import 'package:alumni2/pages/sign_up/info_card.dart';
import 'package:alumni2/pages/sign_up/monitoring_screen.dart';
import 'package:alumni2/pages/sign_up/signup_new.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class WebRoute {
  static List<GetPage> route = [
    GetPage(
      name: '/',
      page: () => const RootMain(),
    ),
    GetPage(
      name: HomeMain.routeName,
      page: () => const HomeMain(),
    ),
    GetPage(
      name: ForgetPassword.routeName,
      page: () => const ForgetPassword(),
    ),
    GetPage(
      name: PersonalInfoScreen.routeName,
      page: () => const PersonalInfoScreen(),
    ),
    GetPage(
      name: MonitoringScreen.routeName,
      page: () => const MonitoringScreen(),
    ),
    GetPage(
      name: EditProfile.routeName,
      page: () => const EditProfile(),
    ),
    // GetPage(
    //   name: LoginMain.routeName,
    //   page: () => const LoginMain(),
    // ),
    GetPage(
      name: RootMain.routeName,
      page: () => const RootMain(),
    ),
    GetPage(
      name: EventAdd.routeName,
      page: () => const EventAdd(),
    ),
    GetPage(
      name: SignUpNew.routeName,
      page: () => const SignUpNew(),
    ),
  ];
}
