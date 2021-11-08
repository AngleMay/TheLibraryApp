import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/home_bloc.dart';
import 'package:the_library/data/vos/book_list_vo.dart';
import 'package:the_library/data/vos/book_type_vo.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/pages/audio_books_page.dart';
import 'package:the_library/pages/ebooks_page.dart';
import 'package:the_library/pages/search_page.dart';
import 'package:the_library/pages/shelves_page.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/widgets/sample_book_session_view.dart';
import 'package:the_library/widgets/book_list_session.dart';
import 'package:the_library/widgets/search_bar_view.dart';
import 'package:the_library/dummy/book_type.dart';

class HomePage extends StatelessWidget {
  final double _progressValue = 0.2;
  final List<BookTypeVO> bookTypes = bookTypeList;

  _navigateToSearchPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SearchPage()),
        (Route<dynamic> route) => false);
  }

  _navigateToShelfPage(BuildContext context, BookVO? book) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => ShelvesPage(
            book: book,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  // _onTabDeleteFromLibrary(BuildContext context,BookVO book){
  //   HomeBloc bloc = Provider.of(context, listen: false);
  //    bloc.deleteBookFromLibrary(book);
  // }

  _onTabMoreButton(BuildContext context, BookVO? book) {
    showModalBottomSheet(
        context: context,
        //backgroundColor: Colors.black54,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (context) => HomeBloc(),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return ChangeNotifierProvider(
                create: (context) => HomeBloc(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 100.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                              horizontal: MARGIN_MEDIUM_2,
                              vertical: MARGIN_MEDIUM_2,
                            ),
                            height: 130.0,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    book?.bookImage ?? "",
                                    height: 150.0,
                                    //width: 120.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                SizedBox(
                                  width: MARGIN_MEDIUM_2,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book?.title ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: MARGIN_MEDIUM,
                                      ),
                                      Text(
                                        book?.author ?? "",
                                        style: TextStyle(color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ),
                                // Divider(
                                //   color: Colors.black87,
                                //   height: 50.0,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black38,
                        //height: 10.0,
                      ),
                      GestureDetector(
                        child: ListTile(
                          title: Text("Remove download"),
                          // leading: Icon(
                          //   Icons.remove_circle_outline,
                          // ),
                          leading: IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                            ),
                            onPressed: () {},
                            //Icons.add,
                          ),
                        ),
                        onTap: () => {},
                      ),
                      GestureDetector(
                        child: ListTile(
                          title: Text("Delete from library"),
                          leading: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {},
                            //Icons.add,
                          ),
                        ),
                        onTap: () {
                          //_onTabDeleteFromLibrary(context,book);
                          Navigator.pop(context);
                          HomeBloc bloc = Provider.of(context, listen: false);
                          bloc.deleteBookFromLibrary(book);
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          title: Text("Add to shelf"),
                          leading: IconButton(
                            icon: Icon(Icons.add), onPressed: () {},
                            //onPressed: () => _navigateToShelfPage(context, book),
                            //Icons.add,
                          ),
                        ),
                        onTap: () => _navigateToShelfPage(context, book),
                      ),
                      GestureDetector(
                        child: ListTile(
                          title: Text("About this eBook"),
                          // leading: Icon(
                          //   Icons.bookmark_border_outlined,
                          leading: IconButton(
                            icon: Icon(Icons.bookmark_border_outlined),
                            onPressed: () {},
                            //Icons.add,
                          ),
                        ),
                        onTap: () => {},
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchBarViewSession(() => _navigateToSearchPage(context)),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Selector<HomeBloc, List<BookVO?>?>(
                  selector: (context, bloc) => bloc.readBookList,
                  builder: (context, readBookList, child) =>
                      readBookList != null
                          ? CarouselSliderSession(_progressValue, readBookList,
                              (book) => _onTabMoreButton(context, book))
                          : Container(),
                ),

                TabBar(
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.black87,
                  labelColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    TabBarTextSession("Ebooks"),
                    TabBarTextSession("Audiobooks"),
                  ],
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                // BookTypeGenreSession(bookTypes),
                // SizedBox(
                //   height: MARGIN_MEDIUM_2,
                // ),
                Selector<HomeBloc, List<BookListVO?>?>(
                    selector: (context, bloc) => bloc.bookList,
                    builder: (context, bookList, child) =>
                        EbookAndAudioBookTabView(bookList)),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                //BookListSession(),
                // Container(
                //   height: 5.7 * 360.toDouble(),
                //   child: ListView.builder(
                //     scrollDirection: Axis.vertical,
                //       itemCount: 10,
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) {
                //         return MoreLikeBookListSession(
                //             "More like KebijaKan dan Administrasi Perpajan",
                //             () => _navigateToBookDetailList(context,
                //                 "More like KebijaKan dan Administrasi Perpajan"),
                //             () => _navigateToBookDetail(context));
                //       }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoreLikeBookListSession extends StatelessWidget {
  final String? title;
  final Function(String) onTab;
  final Function(BookVO?, String) onTabBook;
  final BookListVO? bookList;

  MoreLikeBookListSession(
      this.title, this.bookList, this.onTab, this.onTabBook);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
            vertical: MARGIN_MEDIUM_2,
          ),
          child: BookListTitleViewSession(
              title, () => onTab(bookList?.listNameEncoded ?? "")),
        ),
        Container(
          // padding: EdgeInsets.symmetric(
          //   horizontal: MARGIN_MEDIUM_2,
          // ),
          height: 360.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bookList?.books?.length,
              itemBuilder: (context, index) {
                //return BookListSession(() => onTabBook());
                return BookListSession(
                    () => onTabBook(
                        bookList?.books?[index], bookList?.listNameEncoded ?? ""),
                    book: bookList?.books?[index]);
              }),
        ),
      ],
    );
  }
}

class BookListTitleViewSession extends StatelessWidget {
  final String? title;
  final Function onTab;

  BookListTitleViewSession(this.title, this.onTab());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Expanded(
            child: new Text(
              title ?? "",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_3X,
              ),
            ),
          ),
          // IconButton(
          //onPressed: _navigateToBookDetail(context),
          Icon(
            Icons.arrow_forward_outlined,
            color: Colors.blue,
          ),
          // ),
        ],
      ),
      onTap: () => onTab(),
    );
  }
}

class EbookAndAudioBookTabView extends StatelessWidget {
  final List<BookListVO?>? bookList;

  EbookAndAudioBookTabView(this.bookList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: TabBarView(
        children: [
          EBooksPage(this.bookList),
          AudioBooksPage(this.bookList),
        ],
      ),
    );
  }
}

class BookTypeGenreSession extends StatelessWidget {
  final List<BookTypeVO> bookTypes;
  BookTypeGenreSession(this.bookTypes);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: Text(
            "Explore Play Books",
            style: TextStyle(
                color: Colors.black87,
                fontSize: TEXT_REGULAR_3X,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        ExplorePlayBooksTypeSession(bookTypes),
      ],
    );
  }
}

class ExplorePlayBooksTypeSession extends StatelessWidget {
  List<BookTypeVO> bookTypeList;

  ExplorePlayBooksTypeSession(this.bookTypeList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bookTypeList.length,
          itemBuilder: (context, index) {
            return BookTypeSession(bookTypeList[index]);
          }),
    );
  }
}

class BookTypeSession extends StatelessWidget {
  BookTypeVO bookType;
  BookTypeSession(this.bookType);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      child: Container(
        //width: 150.0,
        padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2,
          //vertical: MARGIN_MEDIUM_2,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Image.asset(
              //"assets/icons/genres.png",
              bookType.icon,
              height: 60.0,
              width: 50.0,
            ),
            Text(bookType.type),
          ],
        ),
      ),
    );
  }
}

class CarouselSliderSession extends StatelessWidget {
  final double _progressValue;
  final Function(BookVO?) onTabMore;
  final List<BookVO?>? bookList;

  CarouselSliderSession(this._progressValue, this.bookList, this.onTabMore);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.6,
        enlargeCenterPage: true,
      ),
      items: bookList
          ?.map(
            (book) => Wrap(
              children: [
                Column(
                  children: [
                    BunnerViewSession(
                      book,
                      _progressValue,
                      () => onTabMore(book),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    BunnerPriceSession(book?.price ?? "")
                  ],
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class BunnerPriceSession extends StatelessWidget {
  final String price;
  BunnerPriceSession(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(
          "Buy $price",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

class BunnerViewSession extends StatelessWidget {
  final double _progressValue;
  final BookVO? book;
  final Function onTabMore;

  BunnerViewSession(this.book, this._progressValue, this.onTabMore());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: 200.0,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 10,
          blurRadius: 7,
          offset: Offset(0, 10), // changes position of shadow
        ),
      ]),
      margin: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM,
      ),
      child: SampleBookSession(book,
          () => onTabMore(), progressValue: _progressValue),
    );
  }
}

class TabBarTextSession extends StatelessWidget {
  final String text;
  TabBarTextSession(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
      child: Text(
        this.text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //color: Colors.black54,
          fontSize: TEXT_REGULAR_3X,
        ),
      ),
    );
  }
}
