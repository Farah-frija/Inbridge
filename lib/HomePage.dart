import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/AddUser/View/addUserScreen.dart';
import 'package:inbridge/Sprints/auth/Users/views/UsersListScreen.dart';
import 'package:inbridge/Sprints/auth/login/Views/loginScreen.dart';
import 'package:inbridge/Sprints/taskManagement/views/TasksList.dart';
import 'package:inbridge/Sprints/taskManagement/views/addTaskScreen.dart';
import 'package:inbridge/Sprints/taskManagement/views/taskDetails.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:inbridge/core/services/services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  final MyNavigationController controller = Get.put(MyNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Obx(() => controller
          .pages[controller.currentIndex.value]), // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.currentIndex.value,
        selectedItemColor: KRoseFonce,
        unselectedItemColor: kgrey,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        onTap: (index) {
          controller.changePage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Obx(() => controller.badgeValue.value != 0
                ? badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: KRoseFonce,
                      padding: EdgeInsets.all(2),
                    ),
                    position: badges.BadgePosition.topEnd(top: -8, end: -5),
                    showBadge: true,
                    ignorePointer: false,
                    badgeContent: Text(controller.badgeValue.value.toString(),
                        style: TextStyle(color: kwhite, fontSize: 10)),
                    child: Icon(Icons.checklist_outlined),
                  )
                : Icon(Icons.checklist_outlined)),
            label: 'checklist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle button press in the middle
          print('Middle button pressed');
        },
        child: Icon(
          Icons.add,
          color: kwhite,
          size: 50,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        backgroundColor: KRoseFonce,
        elevation: 0.0, // Remove shadow
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MyNavigationController extends GetxController {
  var currentIndex = 0.obs;
  var badgeValue = 0.obs;
  List<Widget> pages = [
    Login(),
    TasksList(),
    UsersListScreen(),
    TaskDetailsBottomSheet(),
  ];
  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    _listenToBadgeValue();
  }

  void _listenToBadgeValue() async {
    MyServices myServices = Get.find();

    // Create Preference objects for unread counts
    final Preference<int> unreadMandatoryCountPref = myServices
        .sharedPreferences
        .getInt('unreadMandatoryCount', defaultValue: 0);
    final Preference<int> unreadOptionalCountPref = myServices.sharedPreferences
        .getInt('unreadOptionalCount', defaultValue: 0);

    // Listen to the streams of Preference objects
    unreadMandatoryCountPref.listen((unreadMandatoryCount) {
      _updateBadgeValue(
          unreadMandatoryCount, unreadOptionalCountPref.getValue());
    });

    unreadOptionalCountPref.listen((unreadOptionalCount) {
      _updateBadgeValue(
          unreadMandatoryCountPref.getValue(), unreadOptionalCount);
    });
  }

  void _updateBadgeValue(int unreadMandatoryCount, int unreadOptionalCount) {
    badgeValue.value = unreadMandatoryCount + unreadOptionalCount;
  }
}
