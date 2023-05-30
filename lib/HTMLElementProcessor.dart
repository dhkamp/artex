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

void ProcessImages(DOM.Element element, String pageUrl) {
  List<DOM.Element> imageColl = element.querySelectorAll("img");

  imageColl.forEach((image) {
    if (!image.attributes.containsKey("src")) {
      return;
    }

    final src = image.attributes["src"];

    if (src != null && src.isNotEmpty && !_IsUrlAbsolute(src)) {
      image.attributes.update("src", (v) => _GetAbsoluteUrl(pageUrl, v));
    }
  });
}

void ProcessSVG(DOM.Element element) {
  List<DOM.Element> svgColl = element.querySelectorAll("svg");
  svgColl.forEach((svg) {
    final svgBase64 = base64Encode(utf8.encode(svg.outerHtml));

    final img = DOM.Element.tag("img");
    img.attributes["src"] = "data:image/svg+xml;base64,${svgBase64}";

    svg.replaceWith(img);
  });
}

DOM.Element ProcessHyperlinks(DOM.Element element, String baseUrl) {
  DOM.Element clone = element.clone(true);
  List<DOM.Element> hyperlinkColl = clone.querySelectorAll("a[href]");
  hyperlinkColl.forEach((hyperlink) {
    final href = hyperlink.attributes["href"];
    if (href != null && href.isNotEmpty && !_IsUrlAbsolute(href)) {
      hyperlink.attributes
          .update("href", (value) => _GetAbsoluteUrl(baseUrl, value));
    }
  });
  return clone;
}
