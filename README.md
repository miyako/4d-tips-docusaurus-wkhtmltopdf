# 4d-tips-docusaurus-wkhtmltopdf
[docusaurus-wkhtmltopdf](https://nuxnik.com/docusaurus-pdf-generator/
)を使用してPDFを作成するには

**参考**: [docusaurus-prince-pdf](https://github.com/miyako/4d-tips-docusaurus-prince-pdf)

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

#### 回避策

* `userStyleSheet`をフルパスで指定する
* `@media print {}`を外す
* PdfGenerator.js

```js
      wkhtmltopdf(url, {userStyleSheet:'/Users/miyako/.npm/_npx/c59504acf4d2eb99/node_modules/docusaurus-wkhtmltopdf/print.css', dpi:72, background:true, minimumFontSize:13, imageDpi:300, externalLinks:true, noPrintMediaType:null, copies:1, disableJavascript:null, orientation: 'landscape', marginTop: 0, marginRight: 0, marginBottom: 0, marginLeft: 0}).pipe(
```
