import 'package:hive/hive.dart';
import 'package:the_library/persistence/daos/hive_constants.dart';

class ChangeStyleDao {
  static final ChangeStyleDao _singleton = ChangeStyleDao._internal();

  factory ChangeStyleDao() {
    return _singleton;
  }

  ChangeStyleDao._internal();

  void saveStyle(int type) {
    this.getChangeStyleBox().put(0, type);
  }

  int? getStyle(){
    return getChangeStyleBox().get(0);
  }

  Box<int> getChangeStyleBox() {
    return Hive.box<int>(BOX_NAME_CHANGE_STYLE);
  }
}
