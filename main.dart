import "dart:io";
import "package:args/args.dart";
import "package:html2md/html2md.dart" as HTML2MD;

import "lib/WebCrawler.dart";

void main(List<String> args) async {
  final parser = ArgParser();

  parser.addOption("url", abbr: "u", mandatory: true);
  parser.addOption("selector", abbr: "s");
  parser.addOption("exclude",
      abbr: "e",
      help:
          "Comma-separated QuerySelectors to exclude from the export e.g. #element-id,.element-class");

  try {
    final arguments = parser.parse(args);
    final excludes = _ParseExcludes(arguments["exclude"]);

    Execute(arguments["url"], arguments["selector"], excludes);

    print("Export complete");
  } on ArgParserException catch (argParserException) {
    printError(argParserException.message);
  }
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}

List<String>? _ParseExcludes(dynamic argsResult) {
  final asString = argsResult.toString();

  if (asString.isNotEmpty) {
    return asString.split(",");
  }

  return null;
}

void Execute(String url, String? selector, List<String>? excludes) async {
  var crawler = new WebCrawler();

  if (selector != null && selector.isNotEmpty) {
    crawler.TargetSelector = selector;
  }

  if (excludes != null && excludes.length > 0) {
    excludes.forEach((exclude) {
      crawler.AddExcludeSelector(exclude);
    });
  }

  final result = await crawler.Crawl(url);
  print(result);

  final file = new File("./${result.Title}.md");
  final content = HTML2MD.convert(result.Content);
  file.writeAsString(content);
}
