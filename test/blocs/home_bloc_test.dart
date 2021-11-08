import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/blocs/home_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("home bloc test", () {
    HomeBloc? homeBloc;

    setUp(() {
      homeBloc = new HomeBloc(LibraryModelImplMock());
    });

    ///book list for ebook and audiobook
    test("Fetch  book List test", () {
      expect(homeBloc?.bookList?.contains(getMockBookDetailsList().first), true);
    });


    ///book list for carousal slider
    test("Fetch read book List test", () {
      expect(homeBloc?.readBookList?.contains(getMockReadBooks().first), true);
    });


  });
}
