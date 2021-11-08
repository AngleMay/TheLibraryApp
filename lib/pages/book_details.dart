import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/book_details_bloc.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/search_book_vo.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/widgets/back_button_view.dart';
import 'package:the_library/widgets/book_list_session.dart';
import 'package:the_library/widgets/rating_view.dart';

class BookDetails extends StatelessWidget {
  final BookVO? book;
  final String? listName;
  final String type;
  final SearchBookVO? searchBook;

  BookDetails(this.listName, this.type, {this.book, this.searchBook});

  List<int> ratingBar = [5, 4, 3, 2, 1];

  _navigatorToHomeTabPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeTabPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookDetailsBloc(this.listName, this.book,
          searchBook: this.searchBook),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: LeftButtonSession(
            Colors.black54,
            () => _navigatorToHomeTabPage(context),
          ),
          actions: [
            AppBarActionView(),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 1000.0,
            child: Selector<BookDetailsBloc, BookVO?>(
              selector: (context, bloc) => bloc.book,
              builder: (context, book, child) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookDetailsHeaderSession(book),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    RatingBarSession(book?.rankLastWeek, type),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    PriceButtonSession(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    horizontalLineSession(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_2,
                        vertical: MARGIN_MEDIUM_2,
                      ),
                      child: Column(
                        children: [
                          AboutBookSession(book?.description),
                          SizedBox(
                            height: MARGIN_MEDIUM_2,
                          ),
                          RatingAndReviewSession(ratingBar, book?.rankLastWeek)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_MEDIUM_2,
                      ),
                      child: HeaderLineSession("Similar EBooks"),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    Expanded(
                      child: Selector<BookDetailsBloc, List<BookVO>?>(
                          selector: (context, bloc) => bloc.similarBook,
                          builder: (context, bookList, child) {
                            return bookList != null
                                ? Container(
                                    height: 300.0,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: bookList.length,
                                        itemBuilder: (context, index) {
                                          return BookListSession(() {},
                                              book: bookList[index]);
                                        }),
                                  )
                                : Container();
                          }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AboutBookSession extends StatelessWidget {
  final String? description;
  AboutBookSession(this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderLineSession("About this eBook"),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          description ?? "",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class RatingAndReviewSession extends StatelessWidget {
  final List<int>? ratingBar;
  final int? rate;

  RatingAndReviewSession(this.ratingBar, this.rate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderLineSession("Ratings and reviews"),
        Row(
          children: [
            Column(
              children: [
                Text(
                  "$rate",
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                RatingView(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Text("$rate total"),
              ],
            ),
            SizedBox(
              width: MARGIN_MEDIUM_3,
            ),
            Column(
              children: ratingBar?.map((bar) {
                    return (rate == (bar ?? ""))
                        ? RatingRowBarSession(bar, Colors.blue)
                        : RatingRowBarSession(bar, Colors.black12);
                  }).toList() ??
                  [],
            )
          ],
        )
      ],
    );
  }
}

class RatingRowBarSession extends StatelessWidget {
  final int bar;
  final Color color;
  RatingRowBarSession(this.bar, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(bar.toString()),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Container(
          width: 200.0,
          height: 5.0,
          child: LinearProgressIndicator(
            backgroundColor: color,
            valueColor: new AlwaysStoppedAnimation<Color>(color),
            value: 1.0,
          ),
        )
      ],
    );
  }
}

class HeaderLineSession extends StatelessWidget {
  final String title;

  HeaderLineSession(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: TEXT_REGULAR_4X,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_outlined,
          color: Colors.blue,
          size: 23.0,
        ),
      ],
    );
  }
}

class horizontalLineSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 1.0,
      color: Colors.black26,
    );
  }
}

class PriceButtonSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 40.0,
          margin: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
            vertical: MARGIN_MEDIUM_2,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FlatButton(
            onPressed: () {},
            child: Text(
              "Free Sample",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: MARGIN_MEDIUM_2,
        // ),
        Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 40.0,
          margin: EdgeInsets.symmetric(
              //horizontal: MARGIN_MEDIUM_2,
              //vertical: MARGIN_MEDIUM_2,
              ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue,
          ),
          child: FlatButton(
            onPressed: () {},
            child: Text(
              "Buy THB 44.79",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class RatingBarSession extends StatelessWidget {
  final int? rating;
  final String type;
  RatingBarSession(this.rating, this.type);
  @override
  Widget build(BuildContext context) {
    return Rating(rating, type);
  }
}

class Rating extends StatelessWidget {
  final int? rate;
  final String type;

  Rating(this.rate, this.type);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.33,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$rate",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_SMALL,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black54,
                  )
                ],
              ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              Text(
                "$rate reviews",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(color: Colors.black54),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.33,
          child: Column(
            children: [
              (type == "eBook")
                  ? Icon(
                      Icons.bookmark_border,
                      color: Colors.black54,
                    )
                  : Icon(
                      Icons.headset_mic_outlined,
                      color: Colors.black54,
                    ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              Text(
                "$type",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.33,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "160",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              Text(
                "Pages",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class BookDetailsHeaderSession extends StatelessWidget {
  final BookVO? book;

  BookDetailsHeaderSession(this.book);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // SizedBox(
        //   width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              book?.bookImage ?? "",
              height: 200.0,
              width: 150.0,
            ),
          ),
        ),
        // SizedBox(
        //   width: MARGIN_MEDIUM_2,
        // ),
        (book != null)
            ? Container(
                width: 200.0,
                height: 170.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book?.title ?? "",
                      maxLines: 2,
                      textDirection: TextDirection.ltr,
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: true),
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    Text(
                      book?.author ?? "",
                      maxLines: 2,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    book?.publisher != null
                        ? Text(
                            book?.publisher ?? "",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 15.0),
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}

class AppBarActionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.search,
          color: Colors.black54,
        ),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Icon(
          Icons.bookmark_outline_sharp,
          color: Colors.black54,
        ),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Icon(
          Icons.more_vert,
          color: Colors.black54,
        ),
      ],
    );
  }
}
