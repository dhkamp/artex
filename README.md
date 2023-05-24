## Description
Artex is a command line application that helps export webpages to markdown articles. 
_Artex is also a project for me to learn dart._

#TODO
Export configuriation
 + target element selector
 + exclude element selector
 + download images / absolute image url

<br/>

## Dependencies
There are currently no dependencies.
For development dependencies see development #TODO 

<br/>

## Syntax
```powershell
artex.exe -u <string> [[-s <string>] [-e <string>]]
```

<br/>

## Examples

### Export webpage by url

Executing this command creates an export from the provided url inside the folder,m artex is run in.
The export will be named after the webpages-title-tag.

```bash
artex.exe -u "www.path-to-webpage.com"
```

<br/>

### Export webpage by url and limit export to contents inside specific html element

Executing this command creates an export from the provided url inside the folder,m artex is run in.
The export will be named after the webpages-title-tag.
The content of the export will be limited to the innerHTML of the element thats obtained by using the selector "#main-content".

```bash
artex.exe -u "www.path-to-webpage.com" -s "#main-content"
```

<br/>

### Export webpage but exclude specific HTML-elements from the export

Executing this command creates an export from the provided url inside the folder,m artex is run in.
The export will be named after the webpages-title-tag.
All elements fitting the selectors in the exclude `-e` parameter will be excluded from the export.

```bash
artex.exe -u "www.path-to-webpage.com" -e "#main-content,.side-content,.footer"
```
