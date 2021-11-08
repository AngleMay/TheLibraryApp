import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/blocs/shelf_details_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("shelf details bloc test", () {
    ShelfDetailsBloc? shelfDetailsBloc;

    setUp(() {
      shelfDetailsBloc = new ShelfDetailsBloc(books: getMockBooksByListName(),
          shelf1: getMockShelves()[0], libModel: LibraryModelImplMock());
    });

    test("Fetch shelves from database test", () {
      expect(
        shelfDetailsBloc?.shelf,
        getMockShelves()[0],
      );
    });

    test("Fetch shelves from database test", () {
      expect(
        shelfDetailsBloc?.bookList,
        getMockBooksByListName(),
      );
    });
  });
}
