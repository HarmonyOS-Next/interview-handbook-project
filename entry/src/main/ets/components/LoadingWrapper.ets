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
        Text('没有更多了~').fontColor($r('app.color.ih_gray_color')).fontSize(14)
      }.width('100%').height(50).justifyContent(FlexAlign.Center)
    } else {
      if (this.loading) {
        Row() {
          LoadingProgress().width(24).margin({ right: 5 })
          Text('加载中...').fontColor($r('app.color.ih_gray_color')).fontSize(14)
        }.width('100%').height(50).justifyContent(FlexAlign.Center)
      }
    }
  }
}