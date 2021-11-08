import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_library/pages/search_page.dart';
import 'package:the_library/pages/shelves_page.dart';
import 'package:the_library/pages/your_books_page.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/widgets/search_bar_view.dart';

class LibraryPage extends StatelessWidget {
  // final List<Map<String, dynamic>> _items = List.generate(
  //     10,
  //     (index) =>
  //         {"id": index, "title": "Item $index", "subtitle": "Subtitle $index"});

  _navigateToSearchPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SearchPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Kindacode.com'),
        // ),
        body: SingleChildScrollView(
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchBarViewSession(() => _navigateToSearchPage(context)),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              child: TabBar(
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.black54,
                labelColor: Colors.blue,
                tabs: [
                  TabBarTextSession("Your books"),
                  TabBarTextSession("Shelves"),
                  //TabBarTextSession("Series"),
                ],
              ),
            ),
            Container(
              //height: MediaQuery.of(context).size.height / 0.1,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                children: [
                  YourBooksPage(),
                  ShelvesPage(),
                  //SeriesPage(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class BookListTileViewSession extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return ListTileViewSession();
          }),
    );
  }
}

class ListTileViewSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Kebijakan Administrasi"),
      subtitle: Text("Drs.Chairil Anwar Pohan,M.Si.,MBA"),
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 64,
          maxHeight: 64,
        ),
        child: Image.network(
          "https://images-na.ssl-images-amazon.com/images/I/41yNUpi2QrL._SX303_BO1,204,203,200_.jpg",
        ),
      ),
      trailing: Icon(Icons.download_done_outlined),
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
          //fontWeight: FontWeight.bold,
          //color: Colors.black54,
          fontSize: TEXT_REGULAR_2X,
        ),
      ),
    );
  }
}
