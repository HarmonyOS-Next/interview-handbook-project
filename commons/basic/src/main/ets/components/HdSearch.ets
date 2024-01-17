import { BasicConstant } from '../constants/BasicConstant'

@Component
export struct HdSearch {
  @State
  readonlyMode: boolean = true

  ph: string = ''
  bg: string = ''
  color: string = ''

  build() {
    if (this.readonlyMode) {
      Row({ space: BasicConstant.SPACE_SM }) {
        Image($r("app.media.ic_common_search"))
          .width($r('app.float.hd_search_icon_size'))
          .aspectRatio(1)
          .fillColor(this.color || $r('app.color.common_gray_02'))
        Text(this.ph || $r('app.string.hd_search_placeholder'))
          .fontColor(this.color || $r('app.color.common_gray_02'))
          .fontSize($r('app.float.common_font14'))
      }
      .layoutWeight(1)
      .height($r('app.float.hd_search_height'))
      .backgroundColor(this.bg || $r('app.color.common_gray_border'))
      .borderRadius($r('app.float.hd_search_radius'))
      .justifyContent(FlexAlign.Center)
    } else {
      Search({
        placeholder: this.ph || $r('app.string.hd_search_placeholder')
      })
        .searchIcon({
          size: $r('app.float.hd_search_icon_size'),
          src: $r("app.media.ic_common_search"),
          color: $r('app.color.common_gray_02')
        })
        .padding(0)
        .margin(0)
        .placeholderColor($r('app.color.common_gray_02'))
        .height($r('app.float.hd_search_height'))
        .layoutWeight(1)
    }
  }
}