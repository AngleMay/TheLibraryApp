import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/search_bloc.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/debouncer.dart';
import 'package:the_library/pages/book_details.dart';
import 'package:the_library/pages/book_details_list.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:the_library/pages/search_book_list_page.dart';
import 'package:the_library/resources/dimens.dart';

class SearchPage extends StatelessWidget {
  TextEditingController searchVal = new TextEditingController();

  final _deBouncer = Debouncer(milliseconds: 1000);
  List<String> searchList = ["after", "good to great", "design"];

  _navigateToHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeTabPage()),
        (Route<dynamic> route) => false);
  }

  _navigateToBookDetailsPage(BuildContext context, String title) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SearchBookListPage(
            title,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10.0,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Selector<SearchBloc, bool>(
            selector: (context, bloc) => bloc.isEmpty,
            builder: (context, isEmpty, child) {
              return Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MARGIN_MEDIUM_2,
                      ),
                      IconButton(
                        onPressed: () => _navigateToHomePage(context),
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      SizedBox(
                        width: MARGIN_MEDIUM_2,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (String searchValue) {
                            _deBouncer.run(() {
                              SearchBloc bloc = Provider.of<SearchBloc>(context,
                                  listen: false);
                              bloc.onTabSearchBar(searchValue);
                            });
                          },
                          onSubmitted: (String searchValue) async {
                            // SearchBloc bloc = Provider.of<SearchBloc>(context,
                            //     listen: false);
                            // await bloc.onSummitedSearch(searchValue);
                            _navigateToBookDetailsPage(context, searchValue);
                          },
                          controller: searchVal,
                          //autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Search Play Books",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        // }),
                      ),
                      //),
                      //   },
                      // ),
                      SizedBox(
                        width: MARGIN_MEDIUM_2,
                      ),
                      Visibility(
                        visible: !isEmpty,
                        child: IconButton(
                          onPressed: () {
                            searchVal.clear();
                            SearchBloc bloc =
                                Provider.of<SearchBloc>(context, listen: false);
                            bloc.onTabCrossIcon();
                          },
                          icon: Icon(
                            Icons.clear,
                          ),
                        ),
                      ),
                      // }),

                      SizedBox(
                        width: MARGIN_MEDIUM_2,
                      ),
                      Icon(
                        Icons.mic,
                      ),
                      SizedBox(
                        width: MARGIN_MEDIUM_2,
                      ),
                    ],
                  ),
                  // }),
                  Divider(
                    color: Colors.black26,
                  ),
                  Visibility(
                    //height: 1000.0,
                    //width: MediaQuery.of(context).size.width,
                    visible: isEmpty,
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: searchList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading:
                                  Image.asset("assets/icons/clock_icon.png"),
                              title: Text(searchList[index]),
                            );
                          }),
                    ),
                  ),

                  Visibility(
                    visible: !isEmpty,
                    child: Selector<SearchBloc, List<SearchBookVO?>?>(
                        selector: (context, bloc) => bloc.searchBookList,
                        builder: (context, searchBookList, child) {
                          return Expanded(
                            //height: 2 * 250.toDouble(),
                            child: (searchBookList != null)
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: searchBookList.length,
                                    itemBuilder: (context, index) {
                                      // return Selector<SearchBloc, BookVO>(
                                      //   selector: (context,bloc) => bloc.saveBook,
                                      //   builder: (context, saveBook, child) {
                                      return InkWell(
                                        child: ListTile(
                                          leading: Image.network(
                                            searchBookList[index]
                                                    ?.volumeInfo
                                                    ?.imageLinks
                                                    ?.thumbnail ??
                                                "https://p.kindpng.com/picc/s/84-843028_book-clipart-square-blank-book-cover-clip-art.png",
                                          ),
                                          title: Text(searchBookList[index]
                                                  ?.volumeInfo
                                                  ?.title ??
                                              ""),
                                          subtitle: Text(searchBookList[index]
                                                  ?.volumeInfo
                                                  ?.publisher ??
                                              ""),
                                        ),
                                        onTap: () {
                                          // SearchBloc bloc =
                                          //     Provider.of<SearchBloc>(context,
                                          //         listen: false);
                                          // bloc.saveSearchBookToStorage(
                                          //     searchBookList[index]);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BookDetails(
                                                "",
                                                "eBook",
                                                searchBook:
                                                    searchBookList[index],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      // },

                                      // );
                                    },
                                  )
                                : Container(),
                          );
                        }),
                  ),
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
