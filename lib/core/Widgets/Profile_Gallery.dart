// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
// import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

// import 'package:inbridge/test/Utils/Enums.dart';
// import 'package:inbridge/core/Widgets/CircleAvatar.dart';

// import 'package:inbridge/core/Widgets/SearchBar.dart';

// import 'package:inbridge/core/Widgets/UserName.dart';

// class ProfileGallery extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _ProfileImage(),
//                   SizedBox(height: 16),
//                   UserName(username: "Hidri hadil", email: "hadil@gmail.com"),
//                   SizedBox(height: 30),
//                   Row(children: [
//                     Expanded(child: MySearchBar(controller: null)),
//                     SizedBox(width: 8),
//                   ]),
//                   SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: ProfileTabbar(
//               child: Container(
//                 color: Colors.white,
//                 child: const TabBar(
//                   unselectedLabelStyle: TextStyle(color: kgrey),
//                   labelColor: Colors.black,
//                   indicatorColor: Color.fromARGB(255, 0, 0, 0),
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicatorWeight: 2,
//                   dividerColor: kgrey,
//                   tabs: [
//                     Tab(
//                       child: Text('Public', style: KGalleryPublic),
//                     ),
//                     Tab(
//                       child: Text('Private', style: KGalleryPrivate),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//         body: TabBarView(
//           children: [
//             _ProfileGridView(privateposts),
//             _ProfileGridView(publicposts),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProfileGridView extends StatelessWidget {
//   _ProfileGridView(this.posts);
//   List<String> posts;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: EdgeInsets.all(0),
//       physics: const ClampingScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 2,
//         crossAxisSpacing: 2,
//       ),
//       itemCount: posts.length,
//       itemBuilder: (BuildContext context, int index) {
//         final post = posts[index];
//         return Container(
//           padding: EdgeInsets.all(2),
//           child: Image.asset(
//             post,
//             fit: BoxFit.cover,
//           ),
//         );
//       },
//     );
//   }
// }

// class ProfileTabbar extends SliverPersistentHeaderDelegate {
//   final Widget child;

//   ProfileTabbar({required this.child});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => 48;

//   @override
//   // TODO: implement minExtent
//   double get minExtent => 48;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       false;
// }

// class _ProfileImage extends StatelessWidget {
//   const _ProfileImage({
//     Key? key,
//   }) : super(key: key);
// //todo prend comme parametres File image
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Stack(
//       children: [
//         Avatar(
//           image: true,
//           radius: width * 0.129,
//           border: false,
//         ),
//         Positioned(
//             right: 0,
//             bottom: 8,
//             child: Avatar(
//               image: false,
//               icon: CupertinoIcons.pencil,
//               border: false,
//               color: KRoseFonce,
//               radius: width * 0.03,
//             )),
//       ],
//     );
//   }
// }
