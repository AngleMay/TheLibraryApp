import 'package:flutter/material.dart';
import 'package:the_library/resources/dimens.dart';

class SearchBarViewSession extends StatelessWidget {
  final Function onTabSearch;

  SearchBarViewSession(this.onTabSearch());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabSearch(),
      child: Container(
        width: HOME_TAB_PAGE_SEARCH_BAR_WIDTH,
        height: HOME_TAB_PAGE_SEARCH_BAR_HEIGHT,
        margin: EdgeInsets.symmetric(
            //horizontal: MARGIN_MEDIUM_2,
            //vertical: MARGIN_MEDIUM_2,
            ),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   color: Colors.black54,
          // ),
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_2,
                vertical: MARGIN_MEDIUM_2,
              ),
              child: Icon(
                Icons.search,
                color: Colors.black54,
                size: MARGIN_LARGE,
              ),
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              "Search Play Books",
              style: TextStyle(
                color: Colors.black54,
                fontSize: MARGIN_MEDIUM_2,
              ),
            ),
            // SizedBox(
            //   width: MARGIN_MEDIUM_2,
            // ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                //horizontal: MARGIN_SMALL,
                vertical: MARGIN_SMALL,
              ),
              child: CircleAvatar(
                radius: PROFILE_RADIUS,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    NetworkImage("https://wallpapercave.com/wp/wp7122047.jpg"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
