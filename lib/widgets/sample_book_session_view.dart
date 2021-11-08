import 'package:flutter/material.dart';
import 'package:the_library/data/vos/book_vo.dart';
import 'package:the_library/resources/dimens.dart';
import 'package:the_library/widgets/download_status_icon_session.dart';
import 'package:the_library/widgets/sample_text_session.dart';

class SampleBookSession extends StatelessWidget {
  final BookVO? book;
  final Function onTabMore;
  final double? progressValue;

  SampleBookSession(this.book, this.onTabMore(), {this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BunnerImageViewSession(book?.bookImage),
        BunnerMoreIconSession(() => onTabMore()),
        BunnerProcessBarSession(progressValue),
        BunnerDownloadStatusSession(),
      ],
    );
  }
}

class BunnerDownloadStatusSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      left: 160,
      width: 30,
      height: 30,
      //alignment: Alignment.bottomCenter,
      child: DownloadStatusIconSession(),
    );
  }
}

class BunnerProcessBarSession extends StatelessWidget {
  final double? _progressValue;

  BunnerProcessBarSession(this._progressValue);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 290,
      left: 5,
      width: 190,
      height: 5,
      //alignment: Alignment.bottomCenter,
      child: LinearProgressIndicator(
        backgroundColor: Colors.black54,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        value: _progressValue,
      ),
    );
  }
}

class BunnerMoreIconSession extends StatelessWidget {
  final Function onTab;
  BunnerMoreIconSession(this.onTab());
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM,
            ),
            child: SampleTextSession(),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
            ),
            onPressed: () => this.onTab(),
          ),
        ],
      ),
    );
  }
}

class BunnerImageViewSession extends StatelessWidget {
  final String? image;
  BunnerImageViewSession(this.image);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 200.0,
        height: 400.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            image ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
