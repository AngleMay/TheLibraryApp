import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/blocs/shelf_page_bloc.dart';
import 'package:the_library/data/models/library_model.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/buy_vo.dart';
import 'package:the_library/data/vos/is_bn_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("book details list bloc test", () {
    ShelfPageBloc? shelfPageBloc;
    setUp(() {
      shelfPageBloc = new ShelfPageBloc(LibraryModelImplMock());
    });

    test("Fetch shelf list test", () {
      expect(shelfPageBloc?.shelfList?.contains(getMockShelves().first), true);
    });

    test("fetch save book to shelf ", () {
      shelfPageBloc?.saveBookToShelf(
          BookVO(
            "",
            "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20",
            "",
            "Amor Towles",
            "https://storage.googleapis.com/du-prd/books/images/9780735222359.jpg",
            331,
            500,
            "",
            "by Amor Towles",
            "",
            "2021-10-13 22:12:26",
            "Two friends who escaped from a juvenile work farm take Emmett Watson on an unexpected journey to New York City in 1954.",
            "",
            "0.00",
            "0735222355",
            "9780735222359",
            "nyt://book/43839b1f-c8cc-5ef4-8893-bd85582906a4",
            "Viking",
            1,
            0,
            "",
            "THE LINCOLN HIGHWAY",
            "2021-10-15 20:13:01",
            1,
            [
              BuyVO("Amazon",
                  "https://www.amazon.com/dp/0735222355?tag=NYTBSREV-20")
            ],
            1,
            0,
            [
              IsBnVO(
                "1984821520",
                "9781984821522",
              )
            ],
          ),
          ShelfVO(
            '1',
            "Test Shelf",
            [],
          ));
      expect(shelfPageBloc?.testSaveBookToShelf(), getMockShelves());
    });
  });
}
