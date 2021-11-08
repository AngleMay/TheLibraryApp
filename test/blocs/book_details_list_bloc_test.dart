import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/blocs/book_details_list_bloc.dart';
import 'package:the_library/data/models/library_model.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("book details list bloc test", () {
    BookDetailsListBloc? bookDetailsListBloc;
    setUp(() {
      bookDetailsListBloc =
          new BookDetailsListBloc("list1",title: "title1", libModel: LibraryModelImplMock());
    });

    test("Fetch   book  List test", () {
      expect(
          bookDetailsListBloc?.bookList?.contains(getMockBooksByListName()[0]),
          true);
    });

    test("Fetch searchbooks  List test", () async {
      await Future.delayed(Duration(milliseconds: 700));
      expect(
          bookDetailsListBloc?.searchBookList?.contains(getMockSearchBooksList()[0]),
          true);
    });
  });
}
