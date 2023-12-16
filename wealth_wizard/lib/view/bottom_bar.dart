import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/bottombar_provider.dart';
import 'package:wealth_wizard/view/home_screen.dart';
import 'package:wealth_wizard/view/settings.dart';
import 'package:wealth_wizard/view/statistics.dart';
import 'package:wealth_wizard/view/transaction_list.dart';
import 'package:wealth_wizard/view/add_screen.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  String username;
  File file;
  BottomBar({super.key, required this.username, required this.file});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List screen = [];

  @override
  void initState() {
    super.initState();
    screen = [
      HomeScreen(username: widget.username, file: widget.file),
      const StatisticsScreen(),
      const TransactionList(),
      const settings(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottonBarProvider>(
      builder: (context, provider, child) {
        print("Index Color: ${provider.indexcolor}");
        return Scaffold(
          body: screen[provider.indexcolor],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddTransaction(
                      file: File('wealth_wizard/assets/Education.jpeg')),
                ),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.purple,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 0;
                      // });
                      provider.setIndexColor(provider.indexcolor = 0);
                    },
                    child: Icon(
                      Icons.home,
                      size: 30,
                      color: provider.indexcolor == 0
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 1;
                      // });
                      provider.setIndexColor(provider.indexcolor = 1);
                    },
                    child: Icon(
                      Icons.bar_chart_outlined,
                      size: 30,
                      color: provider.indexcolor == 1
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 2;
                      // });
                      provider.setIndexColor(provider.indexcolor = 2);
                    },
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: provider.indexcolor == 2
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   index_color = 3;
                      // });
                      provider.setIndexColor(provider.indexcolor = 3);
                    },
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: provider.indexcolor == 3
                          ? const Color.fromARGB(255, 122, 27, 139)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
// import 'package:wealth_wizard/controller/bottombar_provider.dart';
// import 'package:wealth_wizard/screens/screen/home_screen.dart';
// import 'package:wealth_wizard/screens/screen/settings.dart';
// import 'package:wealth_wizard/screens/screen/statistics.dart';
// import 'package:wealth_wizard/screens/screen/transaction_list.dart';
// import 'package:wealth_wizard/transaction/add_screen.dart';
// import 'package:stylish_bottom_bar/model/bar_items.dart';

// class BottomBar extends StatefulWidget {
//   int initialIndex = 0;
//   String username;
//   File file;

//   BottomBar({super.key,required this.file,required this.username});

//   @override
//   State<BottomBar> createState() => _BottomBar();
// }

// class _BottomBar extends State<BottomBar> {

//   @override
//   void initState() {
//     final provider = Provider.of<BottonBarProvider>(context, listen: false);
//     super.initState();
//     provider.indexcolor = widget.initialIndex;
//   }



//   final List screen = [
//     HomeScreen(username: widget.username, file: widget.file),
//     const StatisticsScreen(),
//     const TransactionList(),
//     const settings(),
//   ];
//   dynamic selected;
//   PageController controller = PageController();

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottonBarProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           body: screen.elementAt(provider.indexcolor),
//           extendBody: true,
//           bottomNavigationBar: StylishBottomBar(
//             hasNotch: true,
//             fabLocation: StylishBarFabLocation.center,
//             currentIndex: provider.indexcolor,
//             onTap: (int index) {
//               // setState(() {
//               //   _currentIndex = index;
//               // });
//               provider.setIndexColor(index);
//             },
//             items: [
//               BottomBarItem(
//                 icon: const Icon(
//                   Icons.home,
//                 ),
//                 selectedIcon: const Icon(Icons.home),
//                 selectedColor: Colors.purple,
//                 backgroundColor: Colors.grey,
//                 title: const Text('Home'),
//               ),
//               BottomBarItem(
//                 icon: const Icon(Icons.history_rounded),
//                 unSelectedColor: Colors.purple,
//                 backgroundColor: Colors.grey,
//                 title: const Text('Recent'),
//               ),
//               BottomBarItem(
//                   icon: const Icon(
//                     Icons.insert_chart,
//                   ),
//                   selectedIcon: const Icon(
//                     Icons.insert_chart,
//                   ),
//                   backgroundColor: Colors.purple,
//                   selectedColor: Colors.grey,
//                   title: const Text('Statistics')),
//               BottomBarItem(
//                   icon: const Icon(
//                     Icons.settings,
//                   ),
//                   selectedIcon: const Icon(
//                     Icons.settings,
//                   ),
//                   backgroundColor: Colors.purple,
//                   selectedColor: Colors.grey,
//                   title: const Text('Settings')),
//             ],
//             option: AnimatedBarOptions(
//               barAnimation: BarAnimation.fade,
//               iconStyle: IconStyle.animated,
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => AddTransaction(
//                         file: File('wealth_wizard/assets/Education.jpeg'),
//                       )));
//             },
//             backgroundColor: Colors.purple,
//             child: const Icon(
//               Icons.add,
//               color: Colors.grey,
//             ),
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//         );
//       },
//     );
//   }
// }
