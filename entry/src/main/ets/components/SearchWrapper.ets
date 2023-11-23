import { vp2vp } from '../utils/base'
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
        .size({ width: vp2vp(16), height: vp2vp(16) })
        .margin({ left: vp2vp(8), right: vp2vp(6), bottom: vp2vp(1) })
        .fillColor(this.textColor)
      Text('请输入关键词')
        .fontColor(this.textColor)
        .fontSize(vp2vp(14))
    }
    .backgroundColor(this.bg)
    .height(vp2vp(32))
    .borderRadius(vp2vp(16))
    .width('100%')
    .justifyContent(this.alignValue)
  }
}