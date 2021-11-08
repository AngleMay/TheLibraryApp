import 'package:hive/hive.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

// class ShelfDao{
//   static final ShelfDao _singleton = ShelfDao._internal();
//
//   factory ShelfDao() {
//     return _singleton;
//   }
//   ShelfDao._internal();
//
//   List<ShelfVO> shelfList = [];
//   List<BookVO> addedBook = [];
//
//   void saveShelf(ShelfVO? shelf) async {
//     shelfList = getShelfList();
//     if(shelf != null){
//       shelfList.add(shelf);
//     }
//     Map<String, ShelfVO> shelfListMap = Map.fromIterable(shelfList,
//         key: (list) => list.id, value: (list) => list);
//     await getShelfListBox().putAll(shelfListMap);
//     // await getShelfListBox().deleteAt(index)
//   }
//
//   void deleteShelf(ShelfVO? shelf) async {
//     await getShelfListBox().delete(shelf?.id);
//   }
//
//   Stream<List<ShelfVO>> getShelfListStream() {
//     return Stream.value(getShelfList().toList());
//   }
//
//
//
//
//   List<ShelfVO> getShelfList() {
//     return getShelfListBox().values.toList();
//   }
//
//   /// reactive programming
//   Stream<void> getShelfListEventStream() {
//     return getShelfListBox().watch();
//   }
//
//
//
//   List<ShelfVO> getAllShelfList() {
//     if (getShelfList() != null) {
//       return getShelfList().toList();
//     } else {
//       return [];
//     }
//   }
//   Box<ShelfVO> getShelfListBox() {
//     return Hive.box(BOX_NAME_STORAGE_SHELF_LIST);
//   }
// }

abstract class ShelfDao {
  void saveShelf(ShelfVO? shelf);
  void deleteShelf(ShelfVO? shelf);
  Stream<List<ShelfVO>> getShelfListStream();
  Stream<void> getShelfListEventStream();
  List<ShelfVO> getShelfList();
  List<ShelfVO> getAllShelfList();
  List<ShelfVO?>? getShelfDetailsListForTest();
}
