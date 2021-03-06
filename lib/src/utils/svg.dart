import 'package:vector_math/vector_math.dart';
import 'package:xml/xml.dart';

import '../svg/element.dart';
import '../svg/shapes.dart';
import '../svg/transform.dart';

extension XmlElementExt on XmlElement {
  num getScalarAttribute(String name,
      {String namespace, bool zeroIfAbsent = true}) {
    final attr = getAttribute(name, namespace: namespace);

    if (attr == null) {
      return zeroIfAbsent ? 0 : null;
    }

    return num.parse(attr);
  }

  List<SvgElement> parseSvgElements(SvgElement parent, bool ignoreShapes) {
    var elements = children
        .whereType<XmlElement>()
        .map((e) => SvgElement.fromXmlElement(parent, e, ignoreShapes))
        // Ignoring unknown elements
        .where((e) => e != null)
        // Expanding groups
        .expand((e) {
      if (e is! GroupElement) {
        return [e];
      }

      final g = e as GroupElement..applyTransformOnChildren();

      return g.elementList;
    });

    if (!ignoreShapes) {
      // Converting shapes into paths
      elements = elements.map(
          (e) => e is PathConvertible ? (e as PathConvertible).getPath() : e);
    }

    return elements.toList();
  }

  Matrix3 parseTransformMatrix() {
    final transformList = Transform.parse(getAttribute('transform'));
    return generateTransformMatrix(transformList);
  }
}
