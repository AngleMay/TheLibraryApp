import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/pages/book_details.dart';
import 'package:the_library/pages/book_details_list.dart';
import 'package:the_library/pages/home_page.dart';

_navigateToBookDetailList(BuildContext context, String? title, String listName,String type) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => BookDetailsListPage(title, listName,type)),
      (Route<dynamic> route) => false);
}

_navigateToBookDetail(
    BuildContext context, BookVO? book, String? listName, type) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => BookDetails(listName, type,book: book,)),
      (Route<dynamic> route) => false);
}

class AudioBooksPage extends StatelessWidget {
  final List<BookListVO?>? bookList;
  AudioBooksPage(this.bookList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.7 * 360.toDouble(),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: this.bookList?.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return MoreLikeBookListSession(
              bookList?[index]?.displayName,
              bookList?[index],
              (listName) => _navigateToBookDetailList(
                  context, bookList?[index]?.displayName, listName,"Audiobook"),
              (book, listName) =>
                  _navigateToBookDetail(context, book, listName, "Audiobook"),
            );
            // return MoreLikeBookListSession(
            //     "More like KebijaKan dan Administrasi Perpajan",
            //     () => _navigateToBookDetailList(
            //         context, "More like KebijaKan dan Administrasi Perpajan"),
            //     () => _navigateToBookDetail(context));
          }),
    );
  }
}
