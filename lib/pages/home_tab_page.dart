import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_library/pages/home_page.dart';
import 'package:the_library/pages/library_page.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/resources/strings.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int currentButtonTabIndex = 0;

  final List<Widget> _tabPage = [HomePage(), LibraryPage()];

  @override
  void initState() {
    // _navigateToTabItemPage(currentButtonTabIndex);
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      currentButtonTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: MARGIN_MEDIUM,
      ),
      body: _tabPage[currentButtonTabIndex],
      // Column(
      //   children: [
      //     SearchBarViewSession(),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: this.currentButtonTabIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            title: Text(HOME_TAB_PAGE_HOME_TAB_TITLE),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books_outlined,
            ),
            title: Text(HOME_TAB_PAGE_HOME_TAB_LIBRARY),
          ),
          // new BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.shop_outlined,
          //   ),
          //   title: Text(HOME_TAB_PAGE_HOME_TAB_SHOP),
          // ),
        ],
      ),
    );
    _navigatePage(int index) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }
}


