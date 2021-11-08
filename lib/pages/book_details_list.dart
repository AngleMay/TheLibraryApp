import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/book_details_list_bloc.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/pages/book_details.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:the_library/widgets/back_button_view.dart';
import 'package:the_library/widgets/book_view_for_grid.dart';

class BookDetailsListPage extends StatelessWidget {
   String? title;
  final String? listName;
  final String type;
  final List<BookVO>? bookList;

  BookDetailsListPage(this.title, this.listName, this.type, {this.bookList});

  _navigatorToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeTabPage(),
      ),
    );
  }

  _navigatorToBookDetailsPage(
      BuildContext context, BookVO? book, String? listName, String type) {
    if (listName == "") {
      title = listName ?? "";
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetails(listName, type, book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookDetailsListBloc(
        this.listName,
        title: title,
      ),
      child: Scaffold(
        appBar: AppBar(
          //elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            title ?? "",
            style: TextStyle(color: Colors.black87),
          ),
          leading: LeftButtonSession(
            Colors.black87,
            () => _navigatorToHomePage(context),
          ),
          // leading: Icon(
          //   Icons.arrow_back,
          //   color: Colors.black87,
          // ),
          //toolbarHeight: MARGIN_MEDIUM,
        ),
        body: Selector<BookDetailsListBloc, List<BookVO?>?>(
          selector: (context, bloc) => bloc.bookList,
          builder: (context, bookList, child) {
            return (bookList != null)
                ? GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.height / 1400,
                    // Generate 100 widgets that display their index in the List.
                    // children: List.generate(20, (index) {
                    //   return BookViewForGrid(300.0,);
                    // }),
                    children: bookList.map((book) {
                      return BookViewForGrid(
                          300.0,
                          book,
                          (book) => _navigatorToBookDetailsPage(
                              context, book, listName, type));
                    }).toList(),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
