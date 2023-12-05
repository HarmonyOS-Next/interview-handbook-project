(self.webpackChunkrspress_doc_template=self.webpackChunkrspress_doc_template||[]).push([["108"],{94859:function(n,t,e){"use strict";n.exports=e.p+"static/image/34.41908361.png"},14850:function(n,t,e){"use strict";n.exports=e.p+"static/image/35.bbc8a690.png"},21037:function(n,t,e){"use strict";e.r(t),e.d(t,{default:function(){return c}});var i=e("69051"),o=e("72525"),r=e("14850"),a=e("94859");function s(n){let t=Object.assign({h1:"h1",a:"a",h2:"h2",table:"table",thead:"thead",tr:"tr",th:"th",tbody:"tbody",td:"td",img:"img",h3:"h3",pre:"pre",code:"code",p:"p",ul:"ul",li:"li"},(0,o.useMDXComponents)(),n.components);return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsxs)(t.h1,{id:"\u9E3F\u8499-4-\u7F8E\u56E2\u5916\u5356",children:["\u9E3F\u8499-4. \u7F8E\u56E2\u5916\u5356",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#\u9E3F\u8499-4-\u7F8E\u56E2\u5916\u5356",children:"#"})]}),"\n",(0,i.jsxs)(t.h2,{id:"\u9636\u6BB5\u6848\u4F8B-\u7F8E\u56E2\u5916\u5356",children:["\u9636\u6BB5\u6848\u4F8B-\u7F8E\u56E2\u5916\u5356",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#\u9636\u6BB5\u6848\u4F8B-\u7F8E\u56E2\u5916\u5356",children:"#"})]}),"\n",(0,i.jsxs)(t.table,{children:["\n",(0,i.jsxs)(t.thead,{children:["\n",(0,i.jsxs)(t.tr,{children:["\n",(0,i.jsx)(t.th,{children:"\u5546\u54C1\u9875"}),"\n",(0,i.jsx)(t.th,{children:"\u8D2D\u7269\u8F66"}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(t.tbody,{children:["\n",(0,i.jsxs)(t.tr,{children:["\n",(0,i.jsx)(t.td,{children:(0,i.jsx)("img",{src:a,width:"320"})}),"\n",(0,i.jsx)(t.td,{children:(0,i.jsx)("img",{src:r,width:"320"})}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(t.h3,{id:"1-\u9875\u9762\u7ED3\u6784-\u5165\u53E3\u9875\u9762",children:["1. \u9875\u9762\u7ED3\u6784-\u5165\u53E3\u9875\u9762",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#1-\u9875\u9762\u7ED3\u6784-\u5165\u53E3\u9875\u9762",children:"#"})]}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="pages/Index.ets"',children:"import { Cart } from '../components/Cart'\nimport { Footer } from '../components/Footer'\nimport { MenuWrapper } from '../components/MenuWrapper'\nimport { Nav } from '../components/Nav'\n\n@Entry\n@Component\nstruct Index {\n\n  @State\n  showCart: boolean = false\n\n  build() {\n    Stack({ alignContent: Alignment.Bottom }) {\n      Column() {\n        Nav()\n        MenuWrapper()\n      }\n      .width('100%')\n      .height('100%')\n      if (this.showCart) {\n        Cart()\n      }\n      Footer({ showCart: $showCart })\n    }\n  }\n}\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"2-\u9875\u9762\u7ED3\u6784-\u5E95\u90E8\u7EC4\u4EF6",children:["2. \u9875\u9762\u7ED3\u6784-\u5E95\u90E8\u7EC4\u4EF6",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#2-\u9875\u9762\u7ED3\u6784-\u5E95\u90E8\u7EC4\u4EF6",children:"#"})]}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/Footer.ets"',children:"@Component\nexport struct Footer {\n  @Link\n  showCart: boolean\n\n  build() {\n    Row() {\n      Row() {\n        Badge({\n          value: '0',\n          position: BadgePosition.Right,\n          style: { badgeSize: 18 }\n        }) {\n          Image('https://zqran.gitee.io/images/waimai/cart-2.png')\n            .width(47)\n            .height(69)\n            .position({ y: -19 })\n        }\n        .width(50)\n        .height(50)\n        .margin({ left: 25, right: 10 })\n        .onClick(() => {\n          this.showCart = !this.showCart\n        })\n\n        Column() {\n          Text() {\n            Span('\xa5')\n              .fontColor('#fff')\n              .fontSize(12)\n            Span('0.00')\n              .fontColor('#fff')\n              .fontSize(24)\n          }\n\n          Text('\u9884\u4F30\u53E6\u9700\u914D\u9001\u8D39 \xa55')\n            .fontSize(12)\n            .fontColor('#999')\n        }\n        .layoutWeight(1)\n        .alignItems(HorizontalAlign.Start)\n\n        Text('\u53BB\u7ED3\u7B97')\n          .backgroundColor('#f8c74e')\n          .alignSelf(ItemAlign.Stretch)\n          .padding(15)\n          .borderRadius({\n            topRight: 25,\n            bottomRight: 25\n          })\n      }\n      .height(50)\n      .layoutWeight(1)\n      .backgroundColor('#222426')\n      .borderRadius(25)\n    }\n    .padding(15)\n    .height(80)\n  }\n}\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"3-\u9875\u9762\u7ED3\u6784-\u5BFC\u822A\u7EC4\u4EF6",children:["3. \u9875\u9762\u7ED3\u6784-\u5BFC\u822A\u7EC4\u4EF6",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#3-\u9875\u9762\u7ED3\u6784-\u5BFC\u822A\u7EC4\u4EF6",children:"#"})]}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/Nav.ets"',children:"@Component\nexport struct Nav {\n  @Builder\n  NavItem(active: boolean, title: string, subTitle?: string) {\n    Column() {\n      Text() {\n        Span(title)\n        if (subTitle) {\n          Span(' ' + subTitle)\n            .fontSize(10)\n            .fontColor(active ? '#000' : '#666')\n        }\n      }.layoutWeight(1)\n      .fontColor(active ? '#000' : '#666')\n      .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)\n\n      Text()\n        .height(1)\n        .width(20)\n        .margin({ left: 6 })\n        .backgroundColor(active ? '#fa0' : 'transparent')\n    }\n    .width(73)\n    .alignItems(HorizontalAlign.Start)\n    .padding({ top: 3 })\n  }\n\n  build() {\n    Row() {\n      this.NavItem(true, '\u70B9\u83DC')\n      this.NavItem(false, '\u8BC4\u4EF7', '1796')\n      this.NavItem(false, '\u5546\u5BB6')\n\n      Row() {\n        Image($r('app.media.ic_public_input_search'))\n          .width(14)\n          .aspectRatio(1)\n          .fillColor('#999')\n        Text('\u8BF7\u8F93\u5165\u83DC\u54C1\u540D\u79F0')\n          .fontSize(12)\n          .fontColor('#999')\n      }\n      .backgroundColor('#eee')\n      .height(25)\n      .borderRadius(13)\n      .padding({ left: 5, right: 5 })\n      .layoutWeight(1)\n    }\n    .padding({ left: 15, right: 15 })\n    .height(40)\n    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })\n  }\n}\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"4-\u9875\u9762\u7ED3\u6784-\u5546\u54C1\u83DC\u5355\u548C\u5546\u54C1\u5217\u8868",children:["4. \u9875\u9762\u7ED3\u6784-\u5546\u54C1\u83DC\u5355\u548C\u5546\u54C1\u5217\u8868",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#4-\u9875\u9762\u7ED3\u6784-\u5546\u54C1\u83DC\u5355\u548C\u5546\u54C1\u5217\u8868",children:"#"})]}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/MenuWrapper.ets"',children:"\nimport { MenuWrapperItem } from './MenuWrapperItem'\n\n@Component\nexport struct MenuWrapper {\n  list: string[] = ['\u4E00\u4EBA\u5957\u9910', '\u7279\u8272\u70E7\u70E4', '\u6742\u7CAE\u4E3B\u98DF']\n  @State\n  activeIndex: number = 0\n\n  build() {\n    Row() {\n      Column() {\n        ForEach(this.list, (item: string, index: number) => {\n          Text(item)\n            .height(50)\n            .width('100%')\n            .textAlign(TextAlign.Center)\n            .fontSize(14)\n            .backgroundColor(this.activeIndex === index ? '#fff' : '#f5f5f5')\n            .onClick(() => {\n              this.activeIndex = index\n            })\n        })\n      }\n      .width(90)\n\n      List() {\n        ListItem(){\n          MenuWrapperItem()\n        }\n      }\n      .layoutWeight(1)\n      .height('100%')\n      .backgroundColor('#fff')\n    }\n    .layoutWeight(1)\n    .alignItems(VerticalAlign.Top)\n    .backgroundColor('#f5f5f5')\n  }\n}\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/MenuWrapperItem.ets"',children:"import { CalcBtn } from './CalcBtn'\n\n@Component\nexport struct MenuWrapperItem {\n  build() {\n    Row() {\n      Image('https://zqran.gitee.io/images/waimai/8078956697.jpg')\n        .width(90)\n        .aspectRatio(1)\n      Column({ space: 5 }) {\n        Text('\u5C0F\u4EFD\u9178\u6C64\u839C\u9762\u9C7C\u9C7C+\u8089\u5939\u998D\u5957\u9910')\n          .textOverflow({\n            overflow: TextOverflow.Ellipsis,\n          })\n          .maxLines(2)\n          .fontWeight(600)\n        Text('\u9178\u6C64\u839C\u9762\u9C7C\u9C7C\uFF0C\u4E3B\u6599\uFF1A\u9178\u6C64\u3001\u839C\u9762 \u8089\u5939\u998D\uFF0C\u4E3B\u6599\uFF1A\u767D\u76AE\u997C\u3001\u732A\u8089')\n          .textOverflow({\n            overflow: TextOverflow.Ellipsis,\n          })\n          .maxLines(1)\n          .fontSize(12)\n          .fontColor('#333')\n        Text('\u70B9\u8BC4\u7F51\u53CB\u63A8\u8350')\n          .fontSize(10)\n          .backgroundColor('#fff5e2')\n          .fontColor('#ff8000')\n          .padding({ top: 2, bottom: 2, right: 5, left: 5 })\n          .borderRadius(2)\n        Text() {\n          Span('\u6708\u9500\u552E40')\n          Span(' ')\n          Span('\u597D\u8BC4\u5EA6100%')\n        }\n        .fontSize(12)\n        .fontColor('#999')\n\n        Row() {\n          Text() {\n            Span('\xa5 ')\n              .fontColor('#ff8000')\n              .fontSize(10)\n            Span('34.23')\n              .fontColor('#ff8000')\n              .fontWeight(FontWeight.Bold)\n          }\n\n          CalcBtn({ icon: $r('app.media.ic_public_add_filled') })\n        }\n        .justifyContent(FlexAlign.SpaceBetween)\n        .width('100%')\n      }\n      .layoutWeight(1)\n      .alignItems(HorizontalAlign.Start)\n      .padding({ left: 10, right: 10 })\n    }\n    .padding(10)\n    .alignItems(VerticalAlign.Top)\n  }\n}\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"5-\u4E1A\u52A1\u903B\u8F91-\u6E32\u67D3\u5546\u54C1\u83DC\u5355\u548C\u5217\u8868",children:["5. \u4E1A\u52A1\u903B\u8F91-\u6E32\u67D3\u5546\u54C1\u83DC\u5355\u548C\u5217\u8868",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#5-\u4E1A\u52A1\u903B\u8F91-\u6E32\u67D3\u5546\u54C1\u83DC\u5355\u548C\u5217\u8868",children:"#"})]}),"\n",(0,i.jsx)(t.p,{children:"1\uFF09\u5B9A\u4E49 model \u6570\u636E\u6A21\u578B"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="models/index.ets"',children:"export class FoodItem {\n  id: number\n  name: string\n  like_ratio_desc: string\n  food_tag_list: string[]\n  price: number\n  picture: string\n  description: string\n  tag: string\n  month_saled: number\n}\n\nexport class Category {\n  tag: string\n  name: string\n  foods: FoodItem[]\n}\n"})}),"\n",(0,i.jsxs)(t.p,{children:["2\uFF09\u4F7F\u7528 ",(0,i.jsx)(t.code,{children:"http"})," \u53D1\u9001\u8BF7\u6C42\uFF0C\u83B7\u53D6\u6570\u636E"]}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'{1,6,16,17,19-28,34} title="pages/Index.ets"',children:"import http from '@ohos.net.http'\nimport { Cart } from '../components/Cart'\nimport { Footer } from '../components/Footer'\nimport { MenuWrapper } from '../components/MenuWrapper'\nimport { Nav } from '../components/Nav'\nimport { Category } from '../models'\n\nconst req = http.createHttp()\n\n@Entry\n@Component\nstruct Index {\n  @State\n  showCart: boolean = false\n\n  @State\n  categoryList: Category[] = []\n\n  aboutToAppear() {\n    req.request('http://172.16.39.26:3000/takeaway')\n      .then(res => {\n        const data = JSON.parse(res.result as string) as Category[]\n        this.categoryList = data\n      })\n      .catch(err => {\n        console.error('MEITU', err.message)\n      })\n  }\n\n  build() {\n    Stack({ alignContent: Alignment.Bottom }) {\n      Column() {\n        Nav()\n        MenuWrapper({ categoryList: $categoryList })\n      }\n      .width('100%')\n      .height('100%')\n\n      if (this.showCart) {\n        Cart()\n      }\n      Footer({ showCart: $showCart })\n    }\n  }\n}\n"})}),"\n",(0,i.jsx)(t.p,{children:"3\uFF09\u4F20\u5165\u5217\u8868\u6570\u636E\u7ED9\uFF0C\u5546\u54C1\u83DC\u5355\u7EC4\u4EF6\uFF0C\u8FDB\u884C\u6E32\u67D3"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'{1,6,7,14-15,29-33} title="components/MenuWrapper.ets"',children:"import { Category, FoodItem } from '../models'\nimport { MenuWrapperItem } from './MenuWrapperItem'\n\n@Component\nexport struct MenuWrapper {\n  @Link\n  categoryList: Category[]\n  @State\n  activeIndex: number = 0\n\n  build() {\n    Row() {\n      Column() {\n        ForEach(this.categoryList, (item: Category, index: number) => {\n          Text(item.name)\n            .height(50)\n            .width('100%')\n            .textAlign(TextAlign.Center)\n            .fontSize(14)\n            .backgroundColor(this.activeIndex === index ? '#fff' : '#f5f5f5')\n            .onClick(() => {\n              this.activeIndex = index\n            })\n        })\n      }\n      .width(90)\n\n      List() {\n        ForEach(this.categoryList[this.activeIndex]?.foods, (item: FoodItem) => {\n          ListItem() {\n            MenuWrapperItem({ food: item })\n          }\n        })\n      }\n      .layoutWeight(1)\n      .height('100%')\n      .backgroundColor('#fff')\n    }\n    .layoutWeight(1)\n    .alignItems(VerticalAlign.Top)\n    .backgroundColor('#f5f5f5')\n  }\n}\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'{1,7,8,12,16,22,29,30,38,40,50} title="components/MenuWrapperItem.ets"',children:"import { FoodItem } from '../models'\nimport { CalcBtn } from './CalcBtn'\n\n@Component\nexport struct MenuWrapperItem {\n\n  @ObjectLink\n  food: FoodItem\n\n  build() {\n    Row() {\n      Image(this.food.picture)\n        .width(90)\n        .aspectRatio(1)\n      Column({ space: 5 }) {\n        Text(this.food.name)\n          .textOverflow({\n            overflow: TextOverflow.Ellipsis,\n          })\n          .maxLines(2)\n          .fontWeight(600)\n        Text(this.food.description)\n          .textOverflow({\n            overflow: TextOverflow.Ellipsis,\n          })\n          .maxLines(1)\n          .fontSize(12)\n          .fontColor('#333')\n        ForEach(this.food.food_tag_list, (tag) => {\n          Text(tag)\n            .fontSize(10)\n            .backgroundColor('#fff5e2')\n            .fontColor('#ff8000')\n            .padding({ top: 2, bottom: 2, right: 5, left: 5 })\n            .borderRadius(2)\n        })\n        Text() {\n          Span('\u6708\u9500\u552E'+this.food.month_saled)\n          Span(' ')\n          Span(this.food.like_ratio_desc)\n        }\n        .fontSize(12)\n        .fontColor('#999')\n\n        Row() {\n          Text() {\n            Span('\xa5 ')\n              .fontColor('#ff8000')\n              .fontSize(10)\n            Span(this.food.price.toFixed(2))\n              .fontColor('#ff8000')\n              .fontWeight(FontWeight.Bold)\n          }\n\n          CalcBtn({ icon: $r('app.media.ic_public_add_filled') })\n        }\n        .justifyContent(FlexAlign.SpaceBetween)\n        .width('100%')\n      }\n      .layoutWeight(1)\n      .alignItems(HorizontalAlign.Start)\n      .padding({ left: 10, right: 10 })\n    }\n    .padding(10)\n    .alignItems(VerticalAlign.Top)\n  }\n}\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"6-\u9875\u9762\u7ED3\u6784-\u8D2D\u7269\u8F66",children:["6. \u9875\u9762\u7ED3\u6784-\u8D2D\u7269\u8F66",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#6-\u9875\u9762\u7ED3\u6784-\u8D2D\u7269\u8F66",children:"#"})]}),"\n",(0,i.jsxs)(t.ul,{children:["\n",(0,i.jsx)(t.li,{children:"\u62BD\u53D6\u8BA1\u7B97\u6848\u4F8B\u7EC4\u4EF6"}),"\n",(0,i.jsx)(t.li,{children:"\u642D\u5EFA\u8D2D\u7269\u8F66\u9875\u9762"}),"\n"]}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/CalcBtn.ets"',children:"@Component\nexport struct CalcBtn {\n\n  icon: Resource\n\n  plain?: boolean\n\n  build() {\n    Row() {\n      Image(this.icon)\n        .width(10)\n        .aspectRatio(1)\n    }\n    .width(16)\n    .aspectRatio(1)\n    .backgroundColor(this.plain ? '#fff' : '#f8c74e')\n    .border(this.plain ? { width: 0.5 , color: '#f8c74e'}: {})\n    .borderRadius(4)\n    .justifyContent(FlexAlign.Center)\n  }\n}\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/Cart.ets"',children:"import { CartItem } from './CartItem'\n@Component\nexport struct Cart {\n  build() {\n    Column(){\n      Column(){\n        Row(){\n          Text('\u8D2D\u7269\u8F66')\n            .fontSize(14)\n          Text('\u6E05\u7A7A\u8D2D\u7269\u8F66')\n            .fontSize(14)\n            .fontColor('#999')\n        }\n        .width('100%')\n        .height(40)\n        .justifyContent(FlexAlign.SpaceBetween)\n        .padding({ left: 15, right: 15 })\n        .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })\n        // \u8D2D\u7269\u8F66\u5217\u8868\n        List(){\n          ListItem(){\n            CartItem()\n          }\n          ListItem(){\n            CartItem()\n          }\n          ListItem(){\n            CartItem()\n          }\n        }\n        .divider({\n          strokeWidth: 0.5,\n          color: '#e4e4e4'\n        })\n        .padding({ left: 15, right: 15 })\n      }\n      .width('100%')\n      .padding({ bottom: 100 })\n      .backgroundColor('#fff')\n      .borderRadius({\n        topLeft: 16,\n        topRight: 16\n      })\n    }\n    .height('100%')\n    .width('100%')\n    .backgroundColor('rgba(0,0,0,0.5)')\n    .justifyContent(FlexAlign.End)\n  }\n}\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/CartItem.ets"',children:"import { CalcBtn } from './CalcBtn'\n@Component\nexport struct CartItem {\n  build() {\n    Row(){\n      Image('https://zqran.gitee.io/images/waimai/7384994864.jpg')\n        .width(60)\n        .aspectRatio(1)\n      Column({ space: 10 }){\n        Text('\u5C0F\u4EFD\u9178\u6C64\u839C\u9762\u9C7C\u9C7C+\u8089\u5939\u998D\u5957\u9910')\n          .textOverflow({\n            overflow: TextOverflow.Ellipsis\n          })\n          .maxLines(2)\n        Row(){\n          Text(){\n            Span('\xa5 ')\n              .fontSize(10)\n              .fontColor('#ff8000')\n            Span('23.23')\n              .fontWeight(600)\n              .fontColor('#ff8000')\n          }\n\n          Row({ space: 10 }){\n            CalcBtn({ icon: $r('app.media.ic_screenshot_line'), plain: true })\n            Text('0')\n              .fontSize(14)\n            CalcBtn({ icon: $r('app.media.ic_public_add_filled') })\n          }\n        }\n        .width('100%')\n        .justifyContent(FlexAlign.SpaceBetween)\n      }\n      .layoutWeight(1)\n      .alignItems(HorizontalAlign.Start)\n      .padding({ left: 10 })\n    }\n    .padding({ top: 15, bottom: 15 })\n    .alignItems(VerticalAlign.Top)\n  }\n}\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"7-\u4E1A\u52A1\u903B\u8F91-\u52A0\u5165\u8D2D\u7269\u8F66",children:["7. \u4E1A\u52A1\u903B\u8F91-\u52A0\u5165\u8D2D\u7269\u8F66",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#7-\u4E1A\u52A1\u903B\u8F91-\u52A0\u5165\u8D2D\u7269\u8F66",children:"#"})]}),"\n",(0,i.jsx)(t.p,{children:"1\uFF09\u8D2D\u7269\u8F66\u6570\u636E\u6A21\u578B"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="models/index.ets"',children:"export class CartItemModel {\n  id: number\n  name: string\n  price: number\n  picture: string\n  count: number\n}\n"})}),"\n",(0,i.jsx)(t.p,{children:"2\uFF09\u8D2D\u7269\u8F66\u6DFB\u52A0\u903B\u8F91"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="utils/index.ets"',children:"import { CartItemModel, FoodItem } from '../models'\n\nexport const CART_KEY = 'CART_KEY'\n\nexport const getCart = () => {\n  return JSON.parse(AppStorage.Get(CART_KEY) || '[]') as CartItemModel[]\n}\n\nexport const addCart = (food: FoodItem) => {\n  const cart = getCart()\n  const f = cart.find(f => f.id === food.id)\n  if (f) {\n    f.count++\n  } else {\n    const { id, price, picture, name } = food\n    cart.unshift({\n      id,\n      price,\n      picture,\n      name,\n      count: 1\n    })\n  }\n  AppStorage.Set(CART_KEY, JSON.stringify(cart))\n}\n"})}),"\n",(0,i.jsx)(t.p,{children:"3\uFF09\u8D2D\u7269\u8F66\u72B6\u6001\u6301\u4E45\u5316"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="pages/Index.ets"',children:"import { CART_KEY } from '../utils'\n\n\nPersistentStorage.PersistProp(CART_KEY, '[]')\n"})}),"\n",(0,i.jsx)(t.p,{children:"4\uFF09\u76D1\u542C\u8D2D\u7269\u8F66\u6570\u636E\u53D8\u5316\uFF0C\u8BBE\u7F6E\u8D2D\u7269\u8F66\u72B6\u6001\uFF0C\u5E95\u90E8\u7EC4\u4EF6\u663E\u793A\u6570\u91CF\u548C\u603B\u4EF7"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="pages/Index.ets"',children:"  @StorageProp(CART_KEY)\n  @Watch('onUpdateCart')\n  cartJson: string = '[]'\n  @State\n  cart: CartItem[] = JSON.parse(this.cartJson)\n  onUpdateCart () {\n    this.cart = JSON.parse(this.cartJson)\n  }\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="pages/Index.ets"',children:"Footer({ showCart: $showCart, cart: $cart })\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/Footer.ets"',children:"@Link\ncart: CartItem[]\n\n  // ...\n          Badge({\n          value: this.cart.reduce((p, c) => p + c.count, 0) + '',\n          })\n\n  // ...\n          Span(this.cart.reduce((p, c) => p + (c.count * c.price * 100) / 100, 0).toFixed(2))\n          .fontColor('#fff')\n          .fontSize(24)\n\n"})}),"\n",(0,i.jsx)(t.p,{children:"5\uFF09\u6DFB\u52A0\u8D2D\u7269\u8F66"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/MenuWrapperItem.ets"',children:"          CalcBtn({ icon: $r('app.media.ic_public_add_filled') })\n            .onClick(() => {\n              addCart(this.food)\n              promptAction.showToast({ message: '\u6DFB\u52A0\u8D2D\u7269\u8F66\u6210\u529F' })\n            })\n"})}),"\n",(0,i.jsxs)(t.h3,{id:"8-\u4E1A\u52A1\u903B\u8F91-\u8D2D\u7269\u8F66\u7BA1\u7406",children:["8. \u4E1A\u52A1\u903B\u8F91-\u8D2D\u7269\u8F66\u7BA1\u7406",(0,i.jsx)(t.a,{className:"header-anchor","aria-hidden":"true",href:"#8-\u4E1A\u52A1\u903B\u8F91-\u8D2D\u7269\u8F66\u7BA1\u7406",children:"#"})]}),"\n",(0,i.jsx)(t.p,{children:"1\uFF09\u6E32\u67D3\u8D2D\u7269\u8F66"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="pages/Index.ets"',children:"      if (this.showCart) {\n        Cart({ cart: $cart })\n      }\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/Cart.ets"',children:"@Component\nexport struct Cart {\n  @Link\n  cart: CartItemModel[]\n\n  // ...\n\n          List({ space: 30 }) {\n          ForEach(this.cart, (item:CartItemModel) => {\n            ListItem() {\n              CartItemComp({ item })\n            }\n          })\n        }\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/CartItem.ets"',children:"import { CartItemModel } from '../models'\nimport { CalcBtn } from './CalcBtn'\n\n@Component\nexport struct CartItem {\n\n  @ObjectLink\n  item: CartItemModel\n\n  build() {\n    Row() {\n      Image(this.item.picture)\n        .width(60)\n        .aspectRatio(1)\n        .borderRadius(8)\n      Column({ space: 5 }) {\n        Text(this.item.name)\n          .fontSize(14)\n          .textOverflow({\n            overflow: TextOverflow.Ellipsis\n          })\n          .maxLines(2)\n        Row() {\n          Text() {\n            Span('\xa5 ')\n              .fontColor('#ff8000')\n              .fontSize(10)\n            Span(this.item.price.toFixed(2))\n              .fontColor('#ff8000')\n              .fontWeight(FontWeight.Bold)\n          }\n\n          Row() {\n            CalcBtn({ icon: $r('app.media.ic_screenshot_line'), plain: true })\n            Text(this.item.count+'')\n              .padding(10)\n              .fontSize(12)\n            CalcBtn({ icon: $r('app.media.ic_public_add_filled') })\n          }\n        }\n        .justifyContent(FlexAlign.SpaceBetween)\n        .width('100%')\n      }\n      .layoutWeight(1)\n      .alignItems(HorizontalAlign.Start)\n      .padding({ left: 10, right: 10 })\n    }\n    .alignItems(VerticalAlign.Top)\n  }\n}\n"})}),"\n",(0,i.jsx)(t.p,{children:"2\uFF09\u8D2D\u7269\u8F66\u6570\u91CF\u4FEE\u6539"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="utils/index.ets"',children:"export const addCart = (food: FoodItem | CartItemModel) => { ... }\n\nexport const delCart = (id: number) => {\n  const cart = getCart()\n  const f = cart.find(f => f.id === id)\n  if (f && f.count > 0) {\n    f.count--\n  }\n  AppStorage.Set(CART_KEY, JSON.stringify(cart))\n}\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/CartItem.ets"',children:"            CalcBtn({ icon: $r('app.media.ic_screenshot_line'), plain: true })\n              .onClick(() => {\n                delCart(this.item.id)\n              })\n            Text(this.item.count+'')\n              .padding(10)\n              .fontSize(12)\n            CalcBtn({ icon: $r('app.media.ic_public_add_filled') })\n              .onClick(()=>{\n                addCart(this.item)\n              })\n"})}),"\n",(0,i.jsx)(t.p,{children:"3\uFF09\u6E05\u7A7A\u8D2D\u7269\u8F66"}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="utils/index.ets"',children:"export const clearCart  = () => {\n  AppStorage.Set(CART_KEY, '[]')\n}\n"})}),"\n",(0,i.jsx)(t.pre,{children:(0,i.jsx)(t.code,{className:"language-typescript",meta:'title="components/Cart.ets"',children:"          Text('\u6E05\u7A7A\u8D2D\u7269\u8F66')\n            .fontSize(12)\n            .fontColor('#999')\n            .onClick(() => {\n              clearCart()\n            })\n"})})]})}function l(){let n=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},{wrapper:t}=Object.assign({},(0,o.useMDXComponents)(),n.components);return t?(0,i.jsx)(t,{...n,children:(0,i.jsx)(s,{...n})}):s(n)}var c=l;l.__RSPRESS_PAGE_META={},l.__RSPRESS_PAGE_META["guide%2Fmeituan.mdx"]={toc:[{text:"\u9636\u6BB5\u6848\u4F8B-\u7F8E\u56E2\u5916\u5356",id:"\u9636\u6BB5\u6848\u4F8B-\u7F8E\u56E2\u5916\u5356",depth:2},{text:"1. \u9875\u9762\u7ED3\u6784-\u5165\u53E3\u9875\u9762",id:"1-\u9875\u9762\u7ED3\u6784-\u5165\u53E3\u9875\u9762",depth:3},{text:"2. \u9875\u9762\u7ED3\u6784-\u5E95\u90E8\u7EC4\u4EF6",id:"2-\u9875\u9762\u7ED3\u6784-\u5E95\u90E8\u7EC4\u4EF6",depth:3},{text:"3. \u9875\u9762\u7ED3\u6784-\u5BFC\u822A\u7EC4\u4EF6",id:"3-\u9875\u9762\u7ED3\u6784-\u5BFC\u822A\u7EC4\u4EF6",depth:3},{text:"4. \u9875\u9762\u7ED3\u6784-\u5546\u54C1\u83DC\u5355\u548C\u5546\u54C1\u5217\u8868",id:"4-\u9875\u9762\u7ED3\u6784-\u5546\u54C1\u83DC\u5355\u548C\u5546\u54C1\u5217\u8868",depth:3},{text:"5. \u4E1A\u52A1\u903B\u8F91-\u6E32\u67D3\u5546\u54C1\u83DC\u5355\u548C\u5217\u8868",id:"5-\u4E1A\u52A1\u903B\u8F91-\u6E32\u67D3\u5546\u54C1\u83DC\u5355\u548C\u5217\u8868",depth:3},{text:"6. \u9875\u9762\u7ED3\u6784-\u8D2D\u7269\u8F66",id:"6-\u9875\u9762\u7ED3\u6784-\u8D2D\u7269\u8F66",depth:3},{text:"7. \u4E1A\u52A1\u903B\u8F91-\u52A0\u5165\u8D2D\u7269\u8F66",id:"7-\u4E1A\u52A1\u903B\u8F91-\u52A0\u5165\u8D2D\u7269\u8F66",depth:3},{text:"8. \u4E1A\u52A1\u903B\u8F91-\u8D2D\u7269\u8F66\u7BA1\u7406",id:"8-\u4E1A\u52A1\u903B\u8F91-\u8D2D\u7269\u8F66\u7BA1\u7406",depth:3}],title:"\u9E3F\u8499-4. \u7F8E\u56E2\u5916\u5356",frontmatter:{title:"HM - \u9E3F\u8499-\u7F8E\u56E2\u5916\u5356"}}}}]);