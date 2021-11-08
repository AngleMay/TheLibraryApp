import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/widgets/download_status_icon_session.dart';
import 'package:the_library/widgets/sample_text_session.dart';

class BookViewForThreeColumnGrid extends StatelessWidget {
  final List<BookVO?>? readBookList;

  BookViewForThreeColumnGrid({this.readBookList});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3 * 180.toDouble(),
      child: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 3,
        //childAspectRatio: MediaQuery.of(context).size.height / 1400,
        childAspectRatio: 1 / 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(readBookList?.length ?? 0, (index) {
          return ImageViewForGrid(200.0, readBookList?[index]);
        }),
      ),
    );
  }
}

class ImageViewForGrid extends StatelessWidget {
  final double imageHeight;
  final BookVO? book;
  final int? type;

  ImageViewForGrid(this.imageHeight, this.book, {this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      //height: 400.0,
      margin: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
        vertical: MARGIN_MEDIUM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MARGIN_SMALL,
          ),
          type != 2
              ? ImageViewSession(imageHeight, book?.bookImage)
              : ImageViewSessionForTwo(imageHeight, book?.bookImage),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          type == 2
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2,
                  ),
                  child: Text(
                    book?.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                )
              : Text(
                  book?.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          type == 2
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2,
                  ),
                  child: Text(
                    book?.price ?? "",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                )
              : Text(
                  book?.price ?? "",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                )
        ],
      ),
    );
  }
}

class ImageViewSession extends StatelessWidget {
  final double imageHeight;
  final String? bookImage;

  ImageViewSession(this.imageHeight, this.bookImage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              bookImage ?? "",
              fit: BoxFit.cover,
              height: imageHeight,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.symmetric(
              //horizontal: 35.0,
              horizontal: 5.0,
              vertical: 5.0,
            ),
            child: SampleTextSession(),
          ),
        ),
        Positioned(
          top: 165,
          left: 85,
          right: 0,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            child: DownloadStatusIconSession(),
          ),
        ),
      ],
    );
  }
}

class ImageViewSessionForTwo extends StatelessWidget {
  final double imageHeight;
  final String? bookImage;

  ImageViewSessionForTwo(this.imageHeight, this.bookImage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              bookImage ?? "",
              fit: BoxFit.cover,
              height: imageHeight,
              width: 150.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 35.0,
              //horizontal:  5.0,
              vertical: 5.0,
            ),
            child: SampleTextSession(),
          ),
        ),
        Positioned(
          top: 165,
          left: 115,
          right: 30,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            child: DownloadStatusIconSession(),
          ),
        ),
      ],
    );
  }
}
