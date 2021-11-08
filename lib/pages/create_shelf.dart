import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/create_shelf_bloc.dart';
import 'package:the_library/blocs/shelf_details_bloc.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/widgets/BookViewForThreeColumnGrid.dart';
import 'package:the_library/widgets/book_list_for_two_colunm_grid.dart';
import 'package:the_library/widgets/book_list_view.dart';
import 'package:the_library/widgets/sort_type_and_show_style_widget.dart';

class CreateShelf extends StatelessWidget {
  TextEditingController shelfName = TextEditingController();
  final List<String> sortType = ["Author", "Recent", "Title"];
  // CreateShelf({this.shelfName});

  final ShelfVO? shelf;
  CreateShelf({this.shelf});

  @override
  Widget build(BuildContext context) {
    if (shelf != null) {
      shelfName.text = shelf?.shelfName ?? "";
    }
    return ChangeNotifierProvider(
      create: (context) => CreateShelfBloc(shelf),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 10.0,
        ),
        body: Selector<CreateShelfBloc, ShelfVO?>(
          selector: (context, bloc) => bloc.shelf,
          builder: (context, shelf, child) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_3,
                    vertical: MARGIN_MEDIUM_2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.done_outlined,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          CreateShelfBloc shelfBloc =
                              Provider.of(context, listen: false);
                          ShelfVO newShelf =
                              new ShelfVO("", shelfName.text, []);
                          shelfBloc.createShelf(newShelf);
                          Navigator.pop(context);
                        },
                      ),
                      TextField(
                        cursorHeight: 30.0,
                        // autofocus: true,
                        controller: shelfName,
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
                Divider(
                  color: Colors.black54,
                ),
              ],
            );
          },
          //child: ,
        ),
      ),
    );
  }
}
