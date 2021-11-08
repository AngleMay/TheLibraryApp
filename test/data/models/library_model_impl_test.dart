import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/data/models/library_model_impl.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/buy_vo.dart';
import 'package:the_library/data/vos/is_bn_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/persistence/daos/impls/book_list_by_name_dao_impl.dart';

import '../../mock_data/mock_data.dart';
import '../../network/library_data_agent_impl_mock.dart';
import '../../persistance/book_list_by_name_dao_mock.dart';
import '../../persistance/search_book_list_dao_impl_mock.dart';
import '../../persistance/shelf_dao_impl_mock.dart';
import '../../persistance/storage_book_list_dao_impl_mock.dart';

void main() {
  group("library_model_impl", () {
    var libraryModel = LibraryModelImpl();

    setUp(() {
      libraryModel.setDaosAndDataAgents(
          SearchBookListDaoImplMock(),
          BookListByNameDaoMock(),
          StorageBookListDaoImplMock(),
          ShelfDaoImplMock());
    });

    test("Saving Book List and Getting Book List from Database", () {
      expect(
          libraryModel.getBookListFromDatabase(),
          emits([
            BookListVO(
                704,
                "Combined Print and E-Book Fiction",
                "combined-print-and-e-book-fiction",
                "Combined Print & E-Book Fiction",
                "WEEKLY",
                null,
                null,
                null,
                [
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
                  )
                ],
                null,
                null,
                null,
                null),
          ]));
    });

    ///book list for ebook and audio book
    test("Saving Book List By Name and Getting Book List from Database", () {
      expect(
          libraryModel.getBookDetailsListFromDatabase(""),
          emits([
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
          ]));
    });

    ///get book list with list name
    test("Saving Book List By Name and Getting Book List from Database", () {
      expect(
          libraryModel.getBookDetailsListFromDatabase(""),
          emits([
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
          ]));
    });

    ///book list for carousal slider
    test(
        "Saving Book List to Database and Getting Saved Book List from Database",
        () {
      expect(
          libraryModel.getStorageBookListFromDatabase(),
          emits([
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
            BookVO(
              "",
              "https://www.amazon.com/dp/0063142937?tag=NYTBSREV-20",
              "",
              "Stephanie Grisham",
              "https://storage.googleapis.com/du-prd/books/images/9780063142930.jpg",
              331,
              500,
              "",
              "by Stephanie Grisham",
              "",
              "2021-11-21 22:12:27",
              "The former White House press secretary and communications director recounts her time in the Trump inner circle.",
              "",
              "0.00",
              "0063142937",
              "9780063142930",
              "nyt://book/0f544269-91b1-56b7-9928-9f0bd49b6e3c",
              "Harper",
              2,
              0,
              "",
              "I'LL TAKE YOUR QUESTIONS NOW",
              "2021-10-15 20:13:01",
              1,
              [
                BuyVO("Amazon",
                    "https://www.amazon.com/dp/0063142937?tag=NYTBSREV-20")
              ],
              1,
              0,
              [
                IsBnVO(
                  "0063142937",
                  "9780063142930",
                )
              ],
            ),
          ]));
    });

    //shelf list
    test("Saving shelf List to Database and Getting shelf list from Database",
        () {
      expect(
          libraryModel.getShelfListFromDatabase(),
          emits([
            ShelfVO(
              '1',
              "Test Shelf",
              [
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
              ],
            ),
          ]));
    });

    test("Get book from database with book id", () {
      expect(
          libraryModel.getBookFromStorage("1"),
          emits(
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
          ));
    });

    test("save shelf to database", () async {
      libraryModel.saveShelf(
        ShelfVO(
          '1',
          "Test Shelf",
          [
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
          ],
        ),
      );
      await Future.delayed(Duration(milliseconds: 700));
      expect(
        libraryModel.getShelfDetailsListForTest(),
        getMockShelves(),
      );
    });

    test("delete shelf from database", () async {
      libraryModel.deleteShelf(ShelfVO(
        '1',
        "Test Shelf",
        [
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
        ],
      ));
      await Future.delayed(Duration(milliseconds: 700));
      expect(libraryModel.getShelfDetailsListForTest(), []);
    });
  });
}
