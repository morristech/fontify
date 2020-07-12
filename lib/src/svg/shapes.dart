import 'dart:math' as math;

import 'package:xml/xml.dart';

import '../utils/svg.dart';
import 'element.dart';
import 'path.dart';

/// Element convertable to path.
abstract class PathConvertible {
  PathElement getPath();
}

class RectElement implements SvgElement, PathConvertible {
  RectElement(this.rectangle, this.rx, this.ry, this.transform);

  factory RectElement.fromXmlElement(XmlElement element) {
    final rect = math.Rectangle(
      element.getScalarAttribute('x'),
      element.getScalarAttribute('y'),
      element.getScalarAttribute('width'),
      element.getScalarAttribute('height'),
    );

    num rx = element.getScalarAttribute('rx', zeroIfAbsent: false);
    num ry = element.getScalarAttribute('ry', zeroIfAbsent: false);

    ry ??= rx;
    rx ??= ry;

    final transform = element.getAttribute('transform');

    return RectElement(rect, rx, ry, transform);
  }

  final math.Rectangle rectangle;
  final num rx;
  final num ry;
  final String transform;

  num get x => rectangle.left;

  num get y => rectangle.top;

  num get width => rectangle.width;

  num get height => rectangle.height;

  @override
  PathElement getPath() {
    final topRight = rx != 0 || ry != 0 ? 'a $rx $ry 0 0 1 $rx $ry' : '';
    final bottomRight = rx != 0 || ry != 0 ? 'a $rx $ry 0 0 1 ${-rx} $ry' : '';
    final bottomLeft = rx != 0 || ry != 0 ? 'a $rx $ry 0 0 1 ${-rx} ${-ry}' : '';
    final topLeft = rx != 0 || ry != 0 ? 'a $rx $ry 0 0 1 $rx ${-ry}' : '';

    final d = 'M${x + rx} ${y}h${width - rx * 2}${topRight}v${height - ry * 2}${bottomRight}h${-(width - rx * 2)}${bottomLeft}v${-(height - ry * 2)}${topLeft}z';
    
    return PathElement(null, transform, d);
  }
}