# 4d-tips-docusaurus-wkhtmltopdf
[docusaurus-wkhtmltopdf](https://nuxnik.com/docusaurus-pdf-generator/
)を使用してPDFを作成するには

**参考**: [docusaurus-prince-pdf](https://github.com/miyako/4d-tips-docusaurus-prince-pdf)

* デフォルトの設定では余計な要素が出力されるので

```
~/.npm/_npx/{identifier}/node_modules/docusaurus-prince-pdf/print.css
```

のスタイルシートを編集する

```css

  .navPusher {
    padding-top: 0px !important;
  }

  .mainContainer{
    padding: 50px 0 0 0 !important;
  }
  
  .fixedHeaderContainer {
    /* 上部の青いバナーも消すには display: none; */
  }    


  .slidingNav,
  .button,
  .nav-footer,
  .navBreadcrumb {
    display: none !important;
  }

  input {
    display: none !important;
  }

  ul.nav-site > li {
    display: none !important;
  }

  p, li, th, tr, td, h1, h2, h3, h4, h5, h6 {
    font-family: "Meiryo UI" !important;
  }
```
