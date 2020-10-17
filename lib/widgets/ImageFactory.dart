import 'package:flutter/material.dart';

enum ImageType {
  cell,
  cell2,
  computer,
  computer2
}

Widget image(ImageType img) {
  String path = '';
  switch(img) {
    case ImageType.cell:
      path = 'celular.jpg';
      break;
    case ImageType.cell2:
      path = 'celular2.png';
      break;
    case ImageType.computer:
      path = 'computador.jpg';
      break;
    case ImageType.computer2:
      path = 'computador2.png';
      break;
  }
  return Image(image: AssetImage('assets/$path'));
}
