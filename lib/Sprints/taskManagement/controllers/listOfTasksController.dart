import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/Sprints/taskManagement/data/UserTaskbyId.dart';
import 'package:inbridge/Sprints/taskManagement/models/UserTaskModel.dart';
import 'package:inbridge/core/services/services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ListOfTasksController extends GetxController
    with GetSingleTickerProviderStateMixin {
  MyServices myServices = Get.find();
  RxList<Rx<TaskView>> taskList = <Rx<TaskView>>[].obs;
  RxList<Rx<TaskView>> optionalList = <Rx<TaskView>>[].obs;
  RxList<Rx<TaskView>> mandatoryList = <Rx<TaskView>>[].obs;
  late TabController tabController;
  var optionalCount = 0.obs;
  var mandatoryCount = 0.obs;
  var activeTabIndex = 0.obs; // Observable to store active tab index

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchTask();
    _listenToBadgeValue();
    tabController.addListener(_handleTabSelection);
  }

  void updateOpenTile(String id) {}

  void _handleTabSelection() {
    // This method will be called whenever the tab selection changes
    activeTabIndex.value = tabController.index;
    print('${tabController.index}  index');
    updateList(tabController.index);
    // Do something with the selected index...
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
      mandatoryCount.value = unreadMandatoryCount;
    });

    unreadOptionalCountPref.listen((unreadOptionalCount) {
      optionalCount.value = unreadOptionalCount;
    });
  }

  void updateList(int value) {
    if (value == 0) {
      final List<Rx<TaskView>> unreadTasks =
          optionalList.value.where((task) => !task.value.vu).toList();
      //updateDataBase
      optionalList.forEach((task) => task.value.vu = true);

      myServices.sharedPreferences.setInt("unreadOptionalCount", 0);
    } else {
      final List<Rx<TaskView>> unreadTasks =
          mandatoryList.where((task) => !task.value.vu).toList();
      //updateDataBase
      mandatoryList.forEach((task) => task.value.vu = true);

      myServices.sharedPreferences.setInt("unreadMandatoryCount", 0);
    }
  }

  Future<void> fetchTask() async {
    taskList.clear();
    optionalList.clear();
    mandatoryList.clear();
    UserTask user = await fetchUserById("65fc0ad49635019959a580e6");
    List<Rx<TaskView>> rxTaskList =
        user.tachesVues.map((taskView) => taskView.obs).toList();
    taskList.value = rxTaskList;

    optionalList.value =
        taskList.where((taskView) => taskView.value.tache.optionnel!).toList();

    mandatoryList.value =
        taskList.where((taskView) => !taskView.value.tache.optionnel!).toList();
    print("aamal update");
    updateList(activeTabIndex.value);
  }
}

Future<void> calculateUnreadOptionalTasks(String userId) async {
  try {
    final UserTask userTask = await fetchUserById(userId);

    final List<TaskView> tachesVues = userTask.tachesVues;

    int unreadOptionalCount = tachesVues
        .where((taskView) => taskView.tache.optionnel! && !taskView.vu)
        .length;
    int unreadMandatoryCount = tachesVues
        .where((taskView) => !taskView.tache.optionnel! && !taskView.vu)
        .length;

    MyServices myServices = Get.find();
    print(unreadOptionalCount);
    print(unreadMandatoryCount);

    myServices.sharedPreferences
        .setInt("unreadOptionalCount", unreadOptionalCount);

    myServices.sharedPreferences
        .setInt("unreadMandatoryCount", unreadMandatoryCount);
  } catch (e) {
    print('Failed to calculate unread optional tasks: $e');
  }
}
