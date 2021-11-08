import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/resources/dimens.dart';

class BookListView extends StatelessWidget {
  final List<BookVO?>? bookList;
  BookListView({this.bookList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3 * 180.toDouble(),
      child: ListView.builder(
        itemCount: bookList?.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(bookList?[index]?.bookImage ?? ""),
            title: Text(
              bookList?[index]?.title ?? "",
              style: TextStyle(height: 1.3),
              maxLines: 2,
            ),
            subtitle: Text(
              bookList?[index]?.author ?? "",
              style: TextStyle(height: 1.4),
              maxLines: 2,
            ),
            trailing: Container(
              width: 80.0,
              height: 100.0,
              child: Row(
                children: [
                  Icon(
                    Icons.download_done_outlined,
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM_2,
                  ),
                  Icon(Icons.more_vert_outlined)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
