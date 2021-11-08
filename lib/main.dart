import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_details_list_vo.dart';
import 'package:the_library/data/vos/book_details_vo.dart';
import 'package:the_library/data/vos/book_list_results_vo.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/buy_link_vo.dart';
import 'package:the_library/data/vos/buy_vo.dart';
import 'package:the_library/data/vos/is_bn_vo.dart';
import 'package:the_library/data/vos/review_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BookListResultsVOAdapter());
  Hive.registerAdapter(BookListVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BuyVOAdapter());
  Hive.registerAdapter(BookReviewVOAdapter());
  Hive.registerAdapter(BookDetailsVOAdapter());
  Hive.registerAdapter(IsBnVOAdapter());
  Hive.registerAdapter(BookDetailsListVOAdapter());
  Hive.registerAdapter(BuyLinksVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());


  await Hive.openBox<int>(BOX_NAME_CHANGE_STYLE);
  await Hive.openBox<int>(BOX_NAME_SORT_TYPE);
  await Hive.openBox<BookListVO>(BOX_NAME_BOOK_LIST);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_DETAILS_LIST);
  await Hive.openBox<BookVO>(BOX_NAME_STORAGE_BOOK_LIST);
  await Hive.openBox<ShelfVO>(BOX_NAME_STORAGE_SHELF_LIST);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomeTabPage(),
    );
  }
}


