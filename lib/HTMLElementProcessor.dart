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
