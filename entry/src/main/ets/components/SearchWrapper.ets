class SearchWrapperOptions {
  align: FlexAlign = FlexAlign.Start
  bg: string = '#f5f5f5'
  textColor: string = '#979797'
}

@Preview
@Component
export default struct SearchWrapper {
  alignValue: FlexAlign = FlexAlign.Start
  bg: string = '#f5f5f5'
  textColor: string = '#979797'

  build() {
    Row() {
      Image($r("app.media.icon_public_search"))
        .size({ width: 16, height: 16 })
        .margin({ left: 8, right: 6, bottom: 1 })
        .fillColor(this.textColor)
      Text('请输入关键词')
        .fontColor(this.textColor)
        .fontSize(14)
    }
    .backgroundColor(this.bg)
    .height(32)
    .borderRadius(16)
    .width('100%')
    .justifyContent(this.alignValue)
  }
}