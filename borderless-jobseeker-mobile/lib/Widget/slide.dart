import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  // final String title;
  // final String description;

  Slide({
    @required this.imageUrl,
    // @required this.title,
    // @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/work1.png',
    // title: 'this is our title',
    // description: 'this is our description'
  ),
  Slide(
    imageUrl: 'assets/images/work2.png',
    // title: 'this is our title',
    // description: 'this is our description'
  ),
  Slide(
    imageUrl: 'assets/images/work3.png',
    // title: 'this is our title',
    // description: 'this is our description'
  ),
];
