import 'package:flutter_test/flutter_test.dart';
import 'package:the_library/blocs/search_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("search bloc test", () {
    SearchBloc? searchBloc;

    setUp(() {
      searchBloc = new SearchBloc(LibraryModelImplMock());
    });

    test("Fetch search book list from network test", () async {

      searchBloc?.onTabSearchBar("");

      await Future.delayed(Duration(microseconds: 700 ));

      expect(searchBloc?.searchBookList?.contains(getMockSearchBooksList().first),true);
    });



  });
}