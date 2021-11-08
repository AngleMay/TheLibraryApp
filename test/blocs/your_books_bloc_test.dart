import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/blocs/your_books_bloc.dart';
import 'package:the_library/utils/data.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("book details list bloc test", () {
    YourBooksBloc? yourBooksBloc;
    setUp(() {
      yourBooksBloc = new YourBooksBloc(LibraryModelImplMock());
    });

    test("fetch read book list test", () {
      expect(yourBooksBloc?.readBookList, getMockReadBooks());
    });

    test("test two column grid  style", () {
      yourBooksBloc?.changeStyle(StyleDatas.TWO_COLUMN_GRID);
      expect(yourBooksBloc?.styleData, StyleDatas.THREE_COLUMN_GRID);
    });

    test("test three column grid  style", () {
      yourBooksBloc?.changeStyle(StyleDatas.THREE_COLUMN_GRID);
      expect(yourBooksBloc?.styleData, StyleDatas.LIST_VIEW);
    });

    test("test two column grid  style", () {
      yourBooksBloc?.changeStyle(StyleDatas.LIST_VIEW);
      expect(yourBooksBloc?.styleData, StyleDatas.TWO_COLUMN_GRID);
    });

    test(" sort read book list by title test", () {
      yourBooksBloc?.changeSortType(SortDatas.SORT_BY_TITLE);
      expect(yourBooksBloc?.readBookList,  [getMockReadBooks()[1],getMockReadBooks()[0]]);
    });

    test(" sort read book list by author test", () {
      yourBooksBloc?.changeSortType(SortDatas.SORT_BY_AUTHOR);
      expect(yourBooksBloc?.readBookList,  getMockReadBooks());
    });

    test(" sort read book list by recent test", () {
      yourBooksBloc?.changeSortType(SortDatas.SORT_BY_RECENT);
      expect(yourBooksBloc?.readBookList,  getMockReadBooks());
    });

  });
}
