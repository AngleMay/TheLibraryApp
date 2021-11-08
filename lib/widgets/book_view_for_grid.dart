import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_details_list_vo.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/resources/dimens.dart';

class BookViewForGrid extends StatelessWidget {

  final double imageHeight;
  final BookVO? book;
  final Function(BookVO?) onTab;

  BookViewForGrid(this.imageHeight,this.book,this.onTab);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      //height: 400.0,
      margin: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
        vertical: MARGIN_MEDIUM,
      ),
      child: GestureDetector(
        onTap: () => onTab(book),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MARGIN_SMALL,
            ),
            Image.network(
              book?.bookImage ?? "",
              fit: BoxFit.cover,
              height: imageHeight,
            ),
            SizedBox(
              height: MARGIN_SMALL,
            ),
            Text(
              book?.title ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: MARGIN_SMALL,
            ),
            Text(
              book?.price ?? "",
              style: TextStyle(
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
