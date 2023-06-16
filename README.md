## Description
Artex is a command line application that helps export webpages to markdown articles. 
By executint the command with the url of the page to be exproted, artex will load the pages html, process it and create a markdown file containing the html export.

_Artex is also a project for me to learn dart._

## Dependencies
There are currently no dependencies.
For development dependencies see development #TODO 

## Installation

### Windows

You can add artex to your PATH so that it can be executed from CLI without being in the artex folder.
To do that execute the following command.
Note: Removing the `/M`-Flag adds the directory to the USER PAth, not the system PATH.

#TODO
Do not execute the following script, it will remove the path, needs to be fixed
```powershell
setx /M path "%path%;C:\your\path\here\"
```

## Syntax
```powershell
artex.exe -u <string> [[-s <string>] [-e <string>]]
```

## Examples

### Export webpage by url
Executing this command creates an export from the provided url inside the folder,m artex is run in.
The export will be named after the webpages-title-tag.

```bash
artex.exe -u "www.path-to-webpage.com"
```

### Export webpage by url and limit export to contents inside specific html element
Executing this command creates an export from the provided url inside the folder,m artex is run in.
The export will be named after the webpages-title-tag.
The content of the export will be limited to the innerHTML of the element thats obtained by using the selector "#main-content".

```bash
artex.exe -u "www.path-to-webpage.com" -s "#main-content"
```

### Export webpage but exclude specific HTML-elements from the export
Executing this command creates an export from the provided url inside the folder,m artex is run in.
The export will be named after the webpages-title-tag.
All elements fitting the selectors in the exclude `-e` parameter will be excluded from the export.

```bash
artex.exe -u "www.path-to-webpage.com" -e "#main-content,.side-content,.footer"
```

## Parameter

**-u (Url)**
```yaml
Name: Url
Description: The url to the webpage for which a markdown-export should be created
Required: True
Position: Named
```

**-s (Selector)**
```yaml
Name: Selector
Description: Define which html element (base on the selector) should be the exports root.
Required: False
Position: Named
```

**-e (Excludes)**
```yaml
Name: Excludes
Description: Comma-separated lits of html element selectors. Provided element will be excluded from export
Required: False
Position: Named
```

## Development

Clone repostiory
install dependencies with 

```bash
dart pub get
```

### Compile to executable

```bash
dart compile exe main.dart -o release/artex.exe
```

## Roadmap

+ Better parameter names
+ Set output file path and name
+ Include images in export (either download or base64)
+ Add frontmatter to the export (including the source and export date)