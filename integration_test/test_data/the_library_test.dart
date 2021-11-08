import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
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
import 'package:the_library/main.dart';
import 'package:the_library/pages/audio_books_page.dart';
import 'package:the_library/pages/ebooks_page.dart';
import 'package:the_library/pages/home_page.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:the_library/pages/shelf_details.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
import 'package:the_library/widgets/search_bar_view.dart';

import 'test_data.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets(" Use Case 1 - Add eBook to Library + Change View",
      (WidgetTester tester) async {
    tester.pumpWidget(MyApp());

    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 5));

    ///tap to ebook
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.byType(EBooksPage), findsOneWidget);
    expect(find.text(TEST_DATA_BOOK_NAME), findsOneWidget);
    await tester.tap(find.text(TEST_DATA_BOOK_NAME));
    await tester.pumpAndSettle(Duration(seconds: 5));

    ///show book details
    // expect(find.text(TEST_DATA_BOOK_NAME), findsOneWidget);
    // await tester.tap(find.byIcon(Icons.arrow_back));
    // await tester.pumpAndSettle(Duration(seconds: 3));

    //go to library
    await tester.tap(find.byIcon(Icons.library_books_outlined));
    await tester.pumpAndSettle(Duration(seconds: 2));
  });



  testWidgets("Use Case 2 - Search Books", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.byType(SearchBarViewSession), findsOneWidget);

    await tester.tap(find.byType(SearchBarViewSession));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.enterText(find.byType(TextField), "user");
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text(TEST_DATA_SEARCH_BOOK_TITLE), findsOneWidget);
  });



  testWidgets("Use Case 3 - Create Shelf + Delete Shelf + Edit Shelf",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.byType(HomeTabPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.library_books_outlined));
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.text("Shelves"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    //test create new shelf
    await tester.tap(find.text("Create new"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Shelf name"), findsOneWidget);

    await tester.enterText(find.byType(TextField), "Test Shelf");
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.done_outlined));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 1));

    // test rename shelf
    await tester.tap(find.text("Test Shelf"));
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.text("Test Shelf"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.more_vert_outlined));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text("Rename shelf"));
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.text("Test Shelf"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.enterText(find.byKey(Key("TextFieldKey")), "Test Shelf updated");
    await tester.pumpAndSettle(Duration(seconds: 3));

    await tester.tap(find.byIcon(Icons.done_outlined));

    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Test Shelf updated"), findsOneWidget);
  });
}
