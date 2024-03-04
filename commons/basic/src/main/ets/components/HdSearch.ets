import { BasicConstant } from '../constants/BasicConstant'

@Component
export struct HdSearch {
  @Prop
  val: string = ''
  @State
  readonlyMode: boolean = true
  ph: string = ''
  bg: ResourceStr = ''
  color: string = ''
  onSubmit: () => void = () => {
  }
  onChange: (val: string) => void = (val: string) => {
  }

  build() {
    Row() {
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
        .height($r('app.float.hd_search_height'))
        .width('100%')
        .backgroundColor(this.bg || $r('app.color.common_gray_border'))
        .borderRadius($r('app.float.hd_search_radius'))
        .justifyContent(FlexAlign.Center)
      } else {
        Search({
          placeholder: this.ph || $r('app.string.hd_search_placeholder'),
          value: this.val
        })
          .searchIcon({
            size: $r('app.float.hd_search_icon_size'),
            src: $r("app.media.ic_common_search"),
            color: $r('app.color.common_gray_02')
          })
          .textFont({ size: $r('app.float.common_font14') })
          .width('100%')
          .padding(0)
          .margin(0)
          .backgroundColor(this.bg || $r('app.color.common_gray_border'))
          .placeholderColor($r('app.color.common_gray_02'))
          .placeholderFont({ size: $r('app.float.common_font14') })
          .height($r('app.float.hd_search_height'))
          .onSubmit(() => {
            this.onSubmit && this.onSubmit()
          })
          .onChange((val) => {
            this.onChange && this.onChange(val)
          })
      }
    }
  }
}