![version](https://img.shields.io/badge/version-19%2B-5682DF)
![downloads](https://img.shields.io/github/downloads/miyako/4d-tips-docusaurus-wkhtmltopdf/total)

# 4d-tips-docusaurus-wkhtmltopdf
[docusaurus-wkhtmltopdf](https://nuxnik.com/docusaurus-pdf-generator/
)を使用してPDFを作成するには

**参考**: [docusaurus-prince-pdf](https://github.com/miyako/4d-tips-docusaurus-prince-pdf)

---

#### 問題点

```
~/.npm/_npx/{identifier}/node_modules/docusaurus-prince-pdf/print.css
```

が使用されていない

そもそも

```css
@media print {

}
```

が使われていない（**wkhtmltopdf**の[デフォルト](https://wkhtmltopdf.org/usage/wkhtmltopdf.txt)は`noPrintMediaType`）

`externalLinks`が`true`だとエラーになる

書き出しパスの中間フォルダーが存在しないとエラーになる（princeと同じ）

JavaScriptが有効だと目次が崩れて大量のページが失われる

`h1`で見出しが作成されない（`header`の中だから?）

> Wkhtmltopdf with patched qt has support for PDF outlines also known as book
  marks, this can be enabled by specifying the --outline switch. The outlines
  are generated based on the <h?> tags, for a in-depth description of how this
  is done see the Table Of Contents section.

#### 回避策

* `userStyleSheet`をフルパスで指定する
* `@media print {}`を外す
* `externalLinks`を`false`にする
* `javascriptDelay`を指定する
* PdfGenerator.js

```js
wkhtmltopdf(url, {userStyleSheet:'/Users/miyako/.npm/_npx/c59504acf4d2eb99/node_modules/docusaurus-wkhtmltopdf/print.css', dpi:72, background:true, minimumFontSize:13, imageDpi:300, externalLinks:false, noPrintMediaType:null, copies:1, disableJavascript:null, orientation: 'landscape', marginTop: 0, marginRight: 0, marginBottom: 0, marginLeft: 0})
```

#### 結論

この方法は使えない。**wkhtmltopdf**を直接コールする。

---

同時に開くことができるファイルの数はデフォルトで`256`なので

```
ulimit -n 2048
```

`top_.html` `atomic_.html`のエラーを無視する

```
--load-error-handling ignore
```

---

Core Developement, Language Conceptsはリンク中心なので除外する

```sh
wkhtmltopdf --enable-local-file-access --load-error-handling ignore --minimum-font-size 18 --background --dpi 96 --image-dpi 300  --javascript-delay 15000 --outline --outline-depth 2 --print-media-type --user-style-sheet print.css 
{URLs}
{path_to_pdf}
```
