import "package:http/http.dart" as http;
import "package:html/parser.dart" as DOMParser;
import "package:html/dom.dart" as DOM;

import "HTMLElementProcessor.dart" show ProcessImages;

class WebCrawlerResponse {
  late String Title;
  late String Content;

  WebCrawlerResponse(String title, String content) {
    this.Title = title;
    this.Content = content;
  }
}

class WebCrawler {
  List<String> _ExcludeSelectors = [];
  late String TargetSelector = "";

  Future<DOM.Document> _LoadDocument(Uri documentUri) async {
    final result = await http.get(documentUri);
    return DOMParser.parse(result.body);
  }

  String _GetDocumentTitle(DOM.Document document, Uri documentUri) {
    var title = documentUri.path;

    if (document.head != null) {
      final elementColl = document.head!.getElementsByTagName("title");
      if (elementColl.length > 0) {
        title = elementColl[0].text;
      }
    }

    return title;
  }

  void AddExcludeSelector(String selector) {
    if (!this._ExcludeSelectors.contains(selector)) {
      this._ExcludeSelectors.add(selector);
    }
  }

  Future<WebCrawlerResponse> Crawl(String url) async {
    final uri = Uri.parse(url);
    final document = await this._LoadDocument(uri);
    final title = this._GetDocumentTitle(document, uri);

    var element = document.documentElement;

    if (this.TargetSelector.isNotEmpty) {
      element = document.querySelector(this.TargetSelector);
    }

    if (element == null) {
      return throw ArgumentError(
          "Selector ${this.TargetSelector} did not return any elements");
    }

    this._ExcludeSelectors.forEach((selector) {
      element!.querySelector(selector)?.remove();
    });

    ProcessImages(element, url);

    return WebCrawlerResponse(title, element.outerHtml);
  }
}
