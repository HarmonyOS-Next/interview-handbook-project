import { vp2vp } from '../utils/base'
@Preview
@Component
export struct LoadingWrapper {
  @Prop
  finished: boolean
  @Prop
  loading: boolean

  build() {
    if (this.finished) {
      Row() {
        Text('没有更多了~').fontColor($r('app.color.ih_gray_color')).fontSize(vp2vp(14))
      }.width('100%').height(vp2vp(50)).justifyContent(FlexAlign.Center)
    } else {
      if (this.loading) {
        Row() {
          LoadingProgress().width(vp2vp(24)).margin({ right: vp2vp(5) })
          Text('加载中...').fontColor($r('app.color.ih_gray_color')).fontSize(vp2vp(14))
        }.width('100%').height(vp2vp(50)).justifyContent(FlexAlign.Center)
      }
    }
  }
}