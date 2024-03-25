import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inbridge/Sprints/taskManagement/controllers/listOfTasksController.dart';
import 'package:inbridge/core/Widgets/ListOfMandatoryTasks.dart';
import 'package:inbridge/core/Widgets/ListOfOptionalTasks.dart';
import 'package:inbridge/core/Widgets/SearchBar.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:badges/badges.dart' as badges;

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListOfTasksController controller = Get.put(ListOfTasksController());

    return DefaultTabController(
        length: 2,
        // child: RefreshIndicator(
        //     onRefresh: () async {
        //       // Fetch the latest data from the database
        //       await controller.fetchTask();
        //       print("helooo");
        //     },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: MySearchBar(controller: null)),
                      SizedBox(width: 8),
                    ]),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileTabbar(
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: controller.tabController,
                    unselectedLabelStyle: TextStyle(color: KroseClair),
                    labelColor: Colors.black,
                    indicatorColor: Color.fromARGB(255, 0, 0, 0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2,
                    dividerColor: kgrey,
                    tabs: [
                      Tab(
                        child: Obx(() => controller.optionalCount.value != 0
                            ? badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: KRoseFonce,
                                  padding: EdgeInsets.all(5),
                                ),
                                position: badges.BadgePosition.topEnd(
                                    top: -10, end: -15),
                                showBadge: true,
                                ignorePointer: false,
                                badgeContent: Text(
                                    controller.optionalCount.value.toString()),
                                child: Text('Optional', style: KGalleryPrivate),
                              )
                            : Text('Optional', style: KGalleryPrivate)),
                      ),
                      Tab(
                        child: Obx(() => controller.mandatoryCount.value != 0
                            ? badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: KRoseFonce,
                                  padding: EdgeInsets.all(5),
                                ),
                                position: badges.BadgePosition.topEnd(
                                    top: -10, end: -15),
                                showBadge: true,
                                ignorePointer: false,
                                badgeContent: Text(
                                    controller.mandatoryCount.value.toString()),
                                child:
                                    Text('Mandatory', style: KGalleryPrivate),
                              )
                            : Text('Mandatory', style: KGalleryPrivate)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: controller.tabController,
            children: [
              //Optional(),
              Mandatory(),
              Mandatory(),
            ],
          ),
        ));
  }
}

class ProfileTabbar extends SliverPersistentHeaderDelegate {
  final Widget child;

  ProfileTabbar({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 48;

  @override
  // TODO: implement minExtent
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
