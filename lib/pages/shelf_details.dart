import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/home_bloc.dart';
import 'package:the_library/blocs/shelf_details_bloc.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/utils/data.dart';
import 'package:the_library/widgets/BookViewForThreeColumnGrid.dart';
import 'package:the_library/widgets/book_list_for_two_colunm_grid.dart';
import 'package:the_library/widgets/book_list_view.dart';
import 'package:the_library/widgets/sort_type_and_show_style_widget.dart';

class ShelfDetails extends StatelessWidget {
  final List<String> sortType = ["Author", "Recent", "Title"];
  final List<String> popupRoutes = <String>[
    "Rename shelf",
    "Delete shelf",
  ];

  TextEditingController shelfName = new TextEditingController();

  final ShelfVO? shelf;
  final Function(String?)? onTab;
  ShelfDetails(this.shelf, {this.onTab});

  _morePopupView(BuildContext context, ShelfVO shelf) {
    //final Function(String) onTab;

    showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(200.0, 10.0, 5.0, 100.0),
        items: popupRoutes.map((item) {
          return PopupMenuItem<String>(
            child: ChangeNotifierProvider(
              create: (context) => ShelfDetailsBloc(shelf1: shelf),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return ChangeNotifierProvider(
                  create: (context) => ShelfDetailsBloc(),
                  child: ListTile(
                    title: Text("$item"),
                    //onTap: () => _chooseShelf(context, item, shelf, onTab),
                  ),
                );
              }),
            ),
          );
        }).toList());
  }

  _chooseShelf(
      BuildContext context, String chooseItem, ShelfVO shelf, Function onTab) {
    //shelfName.text = "novel";

    if (chooseItem == "Delete shelf") {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDeleteBoxSession(shelf);
          });
    } else {
      // ShelfDetailsBloc shelfBloc = Provider.of(context, listen: false);
      // shelfBloc.onTabRename();
      // ShelfDetailsBloc shelfBloc = Provider.of(context, listen: false);
      // shelfBloc.onTabRename();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CreateShelf(
      //         //shelfName: shelfName,
      //         shelf: shelf),
      //   ),
      // );
      //RenameShelf(context);
      // return clickRename(context);
      ShelfDetailsBloc bloc =
          Provider.of<ShelfDetailsBloc>(context, listen: false);
      bloc.onTabRename();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    shelfName.text = shelf?.shelfName ?? "";
    return ChangeNotifierProvider(
      create: (context) =>
          ShelfDetailsBloc(books: shelf?.bookList, shelf1: shelf),
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
          //toolbarHeight: 200.0,
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: Selector<ShelfDetailsBloc, bool>(
            selector: (context, bloc) => bloc.isRename,
            shouldRebuild: (previous, next) => true,
            builder: (context, isRename, child) {
              return Visibility(
                visible: !isRename,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                  ),
                ),
              );
            },
          ),
          actions: [
            Selector<ShelfDetailsBloc, bool>(
                selector: (context, bloc) => bloc.isRename,
                builder: (context, isRename, child) {
                  return Visibility(
                    visible: !isRename,
                    child: ShelfActionView(() {
                      AlertDeleteBoxSession(
                        //context,
                        shelf,
                      );
                    }, () {
                      clickRename(context);
                    }, shelf),
                    // child: Row(
                    //   children: [
                    //     Icon(
                    //       Icons.search,
                    //       color: Colors.black54,
                    //     ),
                    //     SizedBox(
                    //       width: MARGIN_MEDIUM,
                    //     ),
                    //     IconButton(
                    //         //onPressed: () => _morePopupView(context, shelf),
                    //         onPressed: () {
                    //           showMenu<String>(
                    //               context: context,
                    //               position: RelativeRect.fromLTRB(
                    //                   200.0, 10.0, 5.0, 100.0),
                    //               items: popupRoutes.map((item) {
                    //                 return PopupMenuItem<String>(
                    //                   child: StatefulBuilder(builder:
                    //                       (BuildContext context,
                    //                           StateSetter setState) {
                    //                     return ListTile(
                    //                       title: Text("$item"),
                    //                       onTap: () {
                    //                         //onTab(item);
                    //                         ShelfDetailsBloc bloc = Provider
                    //                             .of<ShelfDetailsBloc>(
                    //                                 context,
                    //                                 listen: false);
                    //                         bloc.onTabRename();
                    //                       },
                    //                       //onTap: () => _chooseShelf(context, item, shelf, onTab),
                    //                     );
                    //                   }),
                    //                 );
                    //               }).toList());
                    //         },
                    //         icon: Icon(
                    //           Icons.more_vert_outlined,
                    //           color: Colors.black54,
                    //         )),
                    //     SizedBox(
                    //       width: MARGIN_MEDIUM,
                    //     ),
                    //   ],
                    // ),
                  );
                }),
          ],
        ),
        body: Selector<ShelfDetailsBloc, ShelfVO?>(
          selector: (context, bloc) => bloc.shelf,
          shouldRebuild: (previous, next) => true,
          builder: (context, shelf, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<ShelfDetailsBloc, bool>(
                  selector: (context, bloc) => bloc.isRename,
                  builder: (context, isRenamed, child) {
                    // return Selector<ShelfDetailsBloc, ShelfVO>(
                    //   selector: (context, bloc) => bloc.shelf,
                    //   builder: (context, shelf, child) {
                    return Container(
                      //color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_2,
                      ),
                      child: Column(
                        children: [
                          Visibility(
                            visible: !isRenamed,
                            child: Column(
                              children: [
                                Text(
                                  shelf?.shelfName ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0,
                                  ),
                                ),
                                SizedBox(
                                  height: MARGIN_SMALL,
                                ),
                                Text("${shelf?.bookList?.length} books"),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isRenamed,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.done_outlined,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    ShelfDetailsBloc shelfBloc =
                                        Provider.of(context, listen: false);
                                    shelf?.shelfName = shelfName.text;
                                    shelfBloc.onTabRenameShelf(shelf);
                                  },
                                ),
                                TextField(
                                  cursorHeight: 30.0,
                                  controller: shelfName,
                                  key: Key("TextFieldKey"),
                                  decoration: InputDecoration(
                                    hintText: "Shelf name",
                                    hintStyle: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    // },
                    //  );
                  },
                ),
                SizedBox(
                  height: MARGIN_SMALL,
                ),
                Divider(
                  color: Colors.black54,
                ),
                Selector<ShelfDetailsBloc, StyleDatas>(
                  selector: (context, bloc) => bloc.styleData,
                  builder: (context, style, child) {
                    return Selector<ShelfDetailsBloc, SortDatas>(
                        selector: (context, bloc) => bloc.sortData,
                        shouldRebuild: (previous, next) => true,
                        builder: (context, sortTypeIndex, child) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: MARGIN_MEDIUM_2,
                                  vertical: MARGIN_MEDIUM_2,
                                ),
                                child: SortByRowView(
                                    style, sortTypeIndex, () {
                                  ShelfDetailsBloc bookBloc =
                                      Provider.of(context, listen: false);
                                  bookBloc.changeStyle(style);
                                }, () {
                                  ShelfDetailsBloc bookBloc =
                                      Provider.of(context, listen: false);
                                  //bookBloc.onTabSort(context, sortTypeIndex);
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 250.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: MARGIN_MEDIUM_3,
                                                  vertical: MARGIN_MEDIUM_2,
                                                ),
                                                child: Text(
                                                  "Sort by",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20.0),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.grey,
                                              ),
                                              ListTile(
                                                title: Text("Author"),
                                                leading: Column(
                                                  children: [
                                                    Radio(
                                                      onChanged: (value) {
                                                        Navigator.pop(context);
                                                        bookBloc.changeSortType(
                                                            SortDatas
                                                                .SORT_BY_AUTHOR);
                                                        //changeSortType(value);
                                                      },
                                                      groupValue: sortType,
                                                      value: SortDatas
                                                          .SORT_BY_AUTHOR,
                                                      activeColor: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ListTile(
                                                title: Text("Recent"),
                                                leading: Column(
                                                  children: [
                                                    Radio(
                                                      onChanged: (value) {
                                                        Navigator.pop(context);
                                                        //changeSortType(value);
                                                        bookBloc.changeSortType(
                                                            SortDatas
                                                                .SORT_BY_RECENT);
                                                      },
                                                      groupValue: sortType,
                                                      value: SortDatas
                                                          .SORT_BY_RECENT,
                                                      activeColor: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ListTile(
                                                title: Text("Title"),
                                                leading: Column(
                                                  children: [
                                                    Radio(
                                                      onChanged: (value) {
                                                        Navigator.pop(context);
                                                        //changeSortType(value);
                                                        bookBloc.changeSortType(
                                                            SortDatas
                                                                .SORT_BY_TITLE);
                                                      },
                                                      groupValue: sortType,
                                                      value: SortDatas
                                                          .SORT_BY_TITLE,
                                                      activeColor: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                }),
                                // },
                                //),
                              ),
                              Column(
                                children: [
                                  (style == StyleDatas.LIST_VIEW ||
                                          style == null)
                                      ? BookListView(
                                          bookList: shelf?.bookList,
                                        )
                                      : (style == StyleDatas.TWO_COLUMN_GRID)
                                          ? BookListForTwoColumnGrid(
                                              readBookList: shelf?.bookList,
                                            )
                                          : BookViewForThreeColumnGrid(
                                              readBookList: shelf?.bookList,
                                            ),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ShelfActionView extends StatelessWidget {
  final Function deleteShelf;
  final Function clickRename;
  final ShelfVO? shelf;
  ShelfActionView(this.deleteShelf(), this.clickRename(), this.shelf);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        icon: Icon(
          Icons.more_vert_outlined,
          color: Colors.black54,
          size: 22.0,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            shelf?.shelfName ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          height: 20.0,
                        ),
                        Column(
                          children: [
                            RenameShelfView(clickRename: clickRename),
                            InkWell(
                              child: ListTileView(
                                "Delete Shelf",
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.black54,
                                ),
                              ),
                              onTap: () {
                                deleteShelf();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class RenameShelfView extends StatelessWidget {
  const RenameShelfView({
    Key? key,
    required this.clickRename,
  }) : super(key: key);

  final Function clickRename;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTileView(
        "Rename shelf",
        Icon(
          Icons.edit_outlined,
          color: Colors.black87,
        ),
      ),
      onTap: () {
        clickRename();
      },
    );
  }
}

class ListTileView extends StatelessWidget {
  final String _text;
  final Icon _icon;
  ListTileView(this._text, this._icon);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // dense: true,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      leading: _icon,
      title: Text(
        _text,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      ),
    );
  }
}

// class RenameShelf extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => HomeBloc(),
//       child: GestureDetector(
//         onTap: () ,
//       ),
//     );
//   }
// }


clickRename(BuildContext context) {
  ShelfDetailsBloc bloc = Provider.of<ShelfDetailsBloc>(context, listen: false);
  bloc.onTabRename();
  Navigator.pop(context);
}

// class Rename extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (context) => ShelfDetailsBloc(),
//         child: Container(
//           child: GestureDetector(
//             onTap: () {
//               ShelfDetailsBloc shelfBloc = Provider.of(context, listen: false);
//               shelfBloc.onTabRename();
//             },
//           ),
//
//           // ShelfDetailsBloc shelfBloc = Provider.of(context, listen: false);
//           // shelfBloc.onTabRename();
//         ));
//   }
// }

class AlertDeleteBoxSession extends StatelessWidget {
  final ShelfVO? shelf;

  AlertDeleteBoxSession(this.shelf);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete  \'${shelf?.shelfName}\' ?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: Colors.black54,
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Text(
              "This shelf will be deleted from all of your devices.Purchases,samples,uploads and active rentals on this shelf will stay in 'Your books."),
        ],
      ),
      actions: <Widget>[
        CancelButtonSession(),
        DeleteButtonSession(shelf),
      ],
    );
  }
}

class CancelButtonSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text('Cancel'),
      minWidth: 120.0,
      textColor: Colors.blue,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class DeleteButtonSession extends StatelessWidget {
  final ShelfVO? deleteShelf;

  DeleteButtonSession(this.deleteShelf);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShelfDetailsBloc(),
      child: Selector<ShelfDetailsBloc, ShelfVO?>(
        selector: (context, bloc) => bloc.shelf,
        builder: (context, shelf, child) {
          return FlatButton(
            child: const Text('Delete'),
            color: Colors.blue,
            minWidth: 180.0,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              ShelfDetailsBloc bookBloc = Provider.of(context, listen: false);
              bookBloc.deleteShelf(deleteShelf);
              Navigator.of(context).pop();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomeTabPage(
              //         //shelfName: shelfName,
              //         ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
