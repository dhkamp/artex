import "dart:convert";
import "package:html/dom.dart" as DOM;

bool _IsUrlAbsolute(String url) {
  final uri = Uri.parse(url);
  return uri.isAbsolute;
}

String _GetAbsoluteUrl(String baseUrl, String relativeUrl) {
  final baseUri = Uri.parse(baseUrl);
  final fullUri = baseUri.resolve(relativeUrl);
  return fullUri.toString();
}

bool _HasAttributeValue(DOM.Element element, String key) {
  bool hasValue = false;
  if (element.attributes.containsKey(key)) {
    final value = element.attributes[key];
    hasValue = value != null && value.isNotEmpty;
  }

  return hasValue;
}

void _ProcessImages(DOM.Element element, String pageUrl) {
  List<DOM.Element> imageColl = element.querySelectorAll("img");

  imageColl.where((image) => _HasAttributeValue(image, "src")).forEach((image) {
    final src = image.attributes["src"];

    if (!_IsUrlAbsolute(src!)) {
      image.attributes.update("src", (v) => _GetAbsoluteUrl(pageUrl, v));
    }
  });
}

void _ProcessSVG(DOM.Element element) {
  List<DOM.Element> svgColl = element.querySelectorAll("svg");
  svgColl.forEach((svg) {
    final svgBase64 = base64Encode(utf8.encode(svg.outerHtml));

    final img = DOM.Element.tag("img");
    img.attributes["src"] = "data:image/svg+xml;base64,${svgBase64}";

    svg.replaceWith(img);
  });
}

void _ProcessHyperlinks(DOM.Element element, String baseUrl) {
  List<DOM.Element> hyperlinkColl = element.querySelectorAll("a[href]");
  hyperlinkColl
      .where((hyperlink) => _HasAttributeValue(hyperlink, "href"))
      .forEach((hyperlink) {
    final href = hyperlink.attributes["href"];
    if (!_IsUrlAbsolute(href!)) {
      hyperlink.attributes.update("href", (v) => _GetAbsoluteUrl(baseUrl, v));
    }
  });
}

DOM.Element ProcessDOM(DOM.Element element, String baseUrl) {
  final DOM.Element clone = element.clone(true);

  _ProcessHyperlinks(clone, baseUrl);
  _ProcessSVG(clone);
  _ProcessImages(clone, baseUrl);

  return clone;
}
