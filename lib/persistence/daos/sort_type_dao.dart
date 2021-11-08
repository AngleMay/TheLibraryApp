import 'package:hive/hive.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

class SortTypeDao {
  static final SortTypeDao _singleton = SortTypeDao._internal();

  factory SortTypeDao() {
    return _singleton;
  }

  SortTypeDao._internal();

  void saveSortType(int index) {
    getSortTypeBoxName().put(0, index);
  }

  int? getSortType() {
    return getSortTypeBoxName().get(0);
  }

  Box<int> getSortTypeBoxName() {
    return Hive.box<int>(BOX_NAME_SORT_TYPE);
  }
}
