import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library/blocs/shelf_page_bloc.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/data/vos/shelf_vo.dart';
import 'package:the_library/pages/create_shelf.dart';
import 'package:the_library/pages/home_tab_page.dart';
import 'package:the_library/pages/shelf_details.dart';

class ShelvesPage extends StatelessWidget {
  final BookVO? book;

  ShelvesPage({this.book});

  _navigateToCreateShelf(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateShelf()));
  }

  _navigateToShelfDetails(BuildContext context, ShelfVO? shelf) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShelfDetails(shelf)));
  }

  _navigateToHomePage(BuildContext context, String status, ShelfVO? shelf) {
    if (status == "save") {
      ShelfPageBloc bloc = Provider.of<ShelfPageBloc>(context, listen: false);
      bloc.saveBookToShelf(book, shelf);
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeTabPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShelfPageBloc(),
      child: Scaffold(
        appBar: book != null
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () => _navigateToHomePage(context, "pop", null),
                ),
                title: Text(
                  "Add to shelf",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              )
            : AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                toolbarHeight: 10.0,
              ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //ShelveListView(),
                  Selector<ShelfPageBloc, List<ShelfVO?>?>(
                    selector: (context, bloc) => bloc.shelfList ,
                    builder: (context, shelfList, bloc) {
                      return Container(
                        height: 3 * 180.toDouble(),
                        //width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: shelfList?.length,
                            itemBuilder: (context, index) {
                              return ShelveListView(
                                  shelfList?[index],
                                  () => book != null
                                      ? _navigateToHomePage(
                                          context, "save", shelfList?[index])
                                      : _navigateToShelfDetails(
                                          context, shelfList?[index]));
                            }),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              //bottom: 20,
              top: 550,
              left: 140,
              child: FloatingActionButton.extended(
                onPressed: () => _navigateToCreateShelf(context),
                label: book != null ? Text("Add to new") : Text("Create new"),
                icon: Icon(
                  Icons.create,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShelveListView extends StatelessWidget {
  final Function onTab;
  final ShelfVO? shelf;
  ShelveListView(this.shelf, this.onTab());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ShelfListTileSession(shelf, () => this.onTab()),
        ),
        HorizontalLineSession(),
      ],
    );
  }
}

class HorizontalLineSession extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 6,
      left: 17.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 2.0,
        color: Colors.black12,
      ),
    );
  }
}

class ShelfListTileSession extends StatelessWidget {
  final Function onTabShelf;
  final ShelfVO? shelf;

  ShelfListTileSession(this.shelf, this.onTabShelf);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabShelf(),
      child: ListTile(
        leading: (shelf?.bookList?.length ?? 0) > 0
            ? Image.network(shelf?.bookList?[(shelf?.bookList?.length ?? 0) - 1]?.bookImage ?? "")
            : Image.asset(
                "assets/images/emptyBook.png",
                //height: 200,
              ),
        title: Text(
          shelf?.shelfName ?? "",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: (shelf?.bookList?.length ?? 0) > 0
            ? Text("${shelf?.bookList?.length} books ")
            : Text(" empty"),
        trailing: Icon(
          Icons.arrow_forward_outlined,
          color: Colors.blue,
        ),
      ),
    );
  }
}
