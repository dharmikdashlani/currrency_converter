import 'package:currency/view/screens/profile_page_3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

import '../../provider/theme_changer_provider.dart';
import 'Convert_page_1.dart';
import 'book_mark_page_3.dart';
import 'list_page_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text('Currency Converter'),
        backgroundColor: (Provider.of<ThemeController>(context,
            listen: true)
            .t
            .isDark)
            ? Colors.deepOrange
            : Colors.greenAccent,
      ),
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          Convert(),
          ListPage(),
          BookMarkPage(),
          Profile(),
          // ColoredBox(color: Colors.blueGrey.shade100),
          // const ColoredBox(color: Color(0xffE3F2C1)),
          // const ColoredBox(color: Color(0xffC9DBB2)),
          // const ColoredBox(color: Color(0xffAAC8A7)),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        items: const [
          RollingBottomBarItem(Icons.currency_exchange, label: 'Convert'),
          RollingBottomBarItem(Icons.list_rounded, label: 'List'),
          RollingBottomBarItem(Icons.bookmark_add_sharp, label: 'Book Mark'),
          RollingBottomBarItem(Icons.person, label: 'profile'),
        ],
        activeItemColor: (Provider.of<ThemeController>(context,
            listen: true)
            .t
            .isDark)
            ? Colors.deepOrange
            : Colors.greenAccent,
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
