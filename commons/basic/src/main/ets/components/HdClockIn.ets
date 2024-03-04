@Component
export struct HdClockIn {
  @Prop
  clockCount: number = 0

  build() {
    Stack({ alignContent: Alignment.End }) {
      Image(this.clockCount > 0 ? $r("app.media.ic_common_clocked") : $r("app.media.ic_common_unclock"))
        .objectFit(ImageFit.Fill)
      if (this.clockCount > 0) {
        Column() {
          Text($r('app.string.hd_clock_continue'))
            .fontSize($r('app.float.common_font8'))
          Text() {
            Span(this.clockCount.toString())
              .fontWeight(FontWeight.Bold)
              .fontSize($r('app.float.common_font12'))
            Span($r('app.string.hd_clock_day'))
              .fontSize($r('app.float.common_font10'))
          }
        }
        .width($r('app.float.hd_clock_text_width'))
      } else {
        Text($r('app.string.hd_clock_in'))
          .width($r('app.float.hd_clock_text_width'))
          .textAlign(TextAlign.Center)
          .fontSize($r('app.float.hd_clock_font'))
          .fontWeight(500)
          .fontColor($r('app.color.black'))
          .margin({ bottom: $r('app.float.common_space4') })
      }
    }
    .width($r('app.float.hd_clock_width'))
    .height($r('app.float.hd_clock_height'))
  }
}