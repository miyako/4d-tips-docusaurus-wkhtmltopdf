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

`externalLinks`が`true`だとエラーになる

書き出しパスの中間フォルダーが存在しないとエラーになる（princeと同じ）

#### 回避策

* `userStyleSheet`をフルパスで指定する
* `@media print {}`を外す
* `externalLinks`を`false`にする
* PdfGenerator.js

```js
      wkhtmltopdf(url, {userStyleSheet:'/Users/miyako/.npm/_npx/c59504acf4d2eb99/node_modules/docusaurus-wkhtmltopdf/print.css', dpi:72, background:true, minimumFontSize:13, imageDpi:300, externalLinks:false, noPrintMediaType:null, copies:1, disableJavascript:null, orientation: 'landscape', marginTop: 0, marginRight: 0, marginBottom: 0, marginLeft: 0}).pipe(
```

#### 結論

ブックマークが崩れる。この方法は使えない。
