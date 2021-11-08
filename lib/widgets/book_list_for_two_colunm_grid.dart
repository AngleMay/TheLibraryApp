import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/widgets/BookViewForThreeColumnGrid.dart';
import 'package:the_library/widgets/download_status_icon_session.dart';
import 'package:the_library/widgets/sample_text_session.dart';

class BookListForTwoColumnGrid extends StatelessWidget {
  List<BookVO?>? readBookList;
  BookListForTwoColumnGrid({this.readBookList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2 * 250.toDouble(),
      child: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        //childAspectRatio: MediaQuery.of(context).size.height / 1400,
        childAspectRatio: 1 / 1.3,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(readBookList?.length ?? 0, (index) {
          return ImageViewForGrid(
            200.0,
            readBookList?[index],
            type: 2,
          );
        }),
      ),
    );
  }
}


