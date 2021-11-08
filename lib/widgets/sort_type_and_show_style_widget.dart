import 'package:flutter/material.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/utils/data.dart';

class SortByRowView extends StatelessWidget {
  final StyleDatas style;
  final Function changeStyle;
  final Function onTabSort;

  final SortDatas sortTypeIndex;

  SortByRowView(this.style,  this.sortTypeIndex,
      this.changeStyle(), this.onTabSort());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTabSort(),
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    (sortTypeIndex == SortDatas.SORT_BY_RECENT)
                        ? "Sort by: Recent"
                        : (sortTypeIndex == SortDatas.SORT_BY_AUTHOR)
                            ? "Sort by: Author"
                            : "Sort by: Title",
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(
                    width: MARGIN_SMALL,
                  ),
                  Icon(
                    Icons.sort,
                    color: Colors.black54,
                  )
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => this.changeStyle(),
          child: Row(
            children: [
              (style == StyleDatas.LIST_VIEW)
                  ? Text(
                      "View: List",
                      style: TextStyle(color: Colors.black54),
                    )
                  : Text(
                      "View: Grid",
                      style: TextStyle(color: Colors.black54),
                    ),
              SizedBox(
                width: MARGIN_SMALL,
              ),
              (style != StyleDatas.LIST_VIEW)
                  ? Icon(
                      Icons.grid_on_sharp,
                      color: Colors.black54,
                    )
                  : Icon(
                      Icons.list,
                      color: Colors.black54,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
