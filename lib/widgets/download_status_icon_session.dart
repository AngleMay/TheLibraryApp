import 'package:flutter/material.dart';

class DownloadStatusIconSession extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Icon(
        Icons.download_done_outlined,
        color: Colors.white,
      ),
    );
  }
}