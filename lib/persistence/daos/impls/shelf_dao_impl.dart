import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';
import 'package:the_library/persistence/daos/shelf_dao.dart';

class ShelfDaoImpl extends ShelfDao {
  static final ShelfDaoImpl _singleton = ShelfDaoImpl._internal();

  factory ShelfDaoImpl() {
    return _singleton;
  }
  ShelfDaoImpl._internal();

  List<ShelfVO> shelfList = [];
  List<BookVO> addedBook = [];

  @override
  void saveShelf(ShelfVO? shelf) async {
    shelfList = getShelfList();
    if (shelf != null) {
      shelfList.add(shelf);
    }
    Map<String, ShelfVO> shelfListMap = Map.fromIterable(shelfList,
        key: (list) => list.id, value: (list) => list);
    await getShelfListBox().putAll(shelfListMap);
    // await getShelfListBox().deleteAt(index)
  }

  @override
  void deleteShelf(ShelfVO? shelf) async {
    await getShelfListBox().delete(shelf?.id);
  }

  @override
  Stream<List<ShelfVO>> getShelfListStream() {
    return Stream.value(getShelfList().toList());
  }

  @override
  List<ShelfVO> getShelfList() {
    return getShelfListBox().values.toList();
  }

  @override

  /// reactive programming
  Stream<void> getShelfListEventStream() {
    return getShelfListBox().watch();
  }

  @override
  List<ShelfVO> getAllShelfList() {
    if (getShelfList() != null) {
      return getShelfList().toList();
    } else {
      return [];
    }
  }

  Box<ShelfVO> getShelfListBox() {
    return Hive.box(BOX_NAME_STORAGE_SHELF_LIST);
  }

  @override
  List<ShelfVO?>? getShelfDetailsListForTest() {
    return getShelfList();
  }
}
