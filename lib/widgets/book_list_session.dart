import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/resources/dimens.dart';

class BookListSession extends StatelessWidget {
  final BookVO? book;
  final Function onTab;
  BookListSession(this.onTab(), {this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: (book != null) ? BookViewSession(book,() => onTab()) : Container(),
    );
  }
}

class BookViewSession extends StatelessWidget {
  final BookVO? book;
  final Function onTab;

  BookViewSession(this.book, this.onTab());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              book?.bookImage ?? "",
              height: 250.0,
            ),
          ),
          onTap: () => onTab(),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        GestureDetector(
          child: Text(
            book?.title ?? "",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          onTap: () => onTab(),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          book?.author ?? "",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Row(
          children: [
            // Text(
            //   "5.0",
            //   style: TextStyle(
            //     color: Colors.black54,
            //   ),
            // ),
            // Icon(
            //   Icons.star,
            //   size: 10.0,
            //   color: Colors.black54,
            // ),
            Text(
              book?.price ?? "",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }
}
