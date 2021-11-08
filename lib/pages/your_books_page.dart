import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/your_books_bloc.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/utils/data.dart';
import 'package:the_library/widgets/BookViewForThreeColumnGrid.dart';
import 'package:the_library/widgets/book_list_for_two_colunm_grid.dart';
import 'package:the_library/widgets/book_list_view.dart';
import 'package:the_library/widgets/sort_type_and_show_style_widget.dart';

class YourBooksPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YourBooksBloc(),
      child: Scaffold(
        body: Selector<YourBooksBloc, StyleDatas>(
          shouldRebuild: (previous, next) => true,
          selector: (context, isListBloc) => isListBloc.styleData,
          builder: (context, style, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2,
                    vertical: MARGIN_MEDIUM_2,
                  ),
                  child: Selector<YourBooksBloc, SortDatas>(
                    selector: (context, bloc) => bloc.sortData,
                    shouldRebuild: (previous, next) => true,
                    builder: (context, sortData, child) {
                      return SortByRowView(style, sortData, () {
                        YourBooksBloc bookBloc =
                            Provider.of(context, listen: false);
                        bookBloc.changeStyle(style);
                      }, () {
                         YourBooksBloc bookBloc =
                             Provider.of(context, listen: false);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: MARGIN_MEDIUM_3,
                                        vertical: MARGIN_MEDIUM_2,
                                      ),
                                      child: Text(
                                        "Sort by",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
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
                                              bookBloc.changeSortType(SortDatas.SORT_BY_AUTHOR);
                                              //changeSortType(value);
                                            },
                                            groupValue: sortData,
                                            value: SortDatas.SORT_BY_AUTHOR,
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
                                              bookBloc.changeSortType(SortDatas.SORT_BY_RECENT);
                                            },
                                            groupValue: sortData,
                                            value: SortDatas.SORT_BY_RECENT,
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
                                              bookBloc.changeSortType(SortDatas.SORT_BY_TITLE);
                                            },
                                            groupValue: sortData,
                                            value: SortDatas.SORT_BY_TITLE,
                                            activeColor: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      });
                    },
                  ),
                ),
                Selector<YourBooksBloc, List<BookVO?>?>(
                  selector: (context, bloc) => bloc.readBookList,
                  shouldRebuild: (previous, next) => true,
                  builder: (context, readBookList, child) {
                    return Column(
                      children: [
                        (style == StyleDatas.LIST_VIEW || style == null)
                            ? BookListView(
                                bookList: readBookList,
                              )
                            : (style == StyleDatas.TWO_COLUMN_GRID)
                                ? BookListForTwoColumnGrid(
                                    readBookList: readBookList,
                                  )
                                : BookViewForThreeColumnGrid(
                                    readBookList: readBookList,
                                  ),
                      ],
                    );
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

// class SortByRowView extends StatelessWidget {
//   final bool isList;
//   final Function changeStyle;
//   final Function onTabSort;
//   final List<String> sortType;
//   final int sortTypeIndex;
//
//   SortByRowView(this.isList, this.sortType, this.sortTypeIndex,
//       this.changeStyle(), this.onTabSort());
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () => onTabSort(),
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Sort by: ${sortType[sortTypeIndex]}",
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   SizedBox(
//                     width: MARGIN_SMALL,
//                   ),
//                   Icon(
//                     Icons.sort,
//                     color: Colors.black54,
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Spacer(),
//         GestureDetector(
//           onTap: () => this.changeStyle(),
//           child: Row(
//             children: [
//               isList
//                   ? Text(
//                       "View: List",
//                       style: TextStyle(color: Colors.black54),
//                     )
//                   : Text(
//                       "View: Grid",
//                       style: TextStyle(color: Colors.black54),
//                     ),
//               SizedBox(
//                 width: MARGIN_SMALL,
//               ),
//               Icon(
//                 Icons.grid_on_sharp,
//                 color: Colors.black54,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
