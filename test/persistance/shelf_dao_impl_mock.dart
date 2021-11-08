import 'package:flutter/foundation.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/persistence/daos/shelf_dao.dart';

import '../mock_data/mock_data.dart';

class ShelfDaoImplMock extends ShelfDao {
  Map<String?, ShelfVO?> shelfInDatabase = {};

  @override
  void deleteShelf(ShelfVO? shelf) {
    shelfInDatabase.remove(shelf?.id);
    debugPrint(shelfInDatabase.toString());
  }

  @override
  List<ShelfVO> getAllShelfList() {
    if (getShelfList().isNotEmpty) {
      return getShelfList();
    } else {
      return [];
    }
  }

  @override
  List<ShelfVO> getShelfList() {
    return getMockShelves();
  }

  @override
  Stream<void> getShelfListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<List<ShelfVO>> getShelfListStream() {
    return Stream.value(getShelfList());
  }

  @override
  void saveShelf(ShelfVO? shelf) {
    if (shelf != null) {
      shelfInDatabase[shelf?.id] = shelf;
      debugPrint("shelfInDatabase>>" + shelfInDatabase.toString());
    }
  }

  List<ShelfVO?>? getShelfDetailsListForTest() {
    return shelfInDatabase?.values?.toList();
  }
}
