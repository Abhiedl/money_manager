import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:money_manager/screens/home/screen_home.dart';

class MoneyBottomNavigation extends StatelessWidget {
  const MoneyBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            selectedFontSize: 15,
            selectedItemColor: Color.fromRGBO(61, 164, 248, 1),
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
            ],
          );
        });
  }
}
