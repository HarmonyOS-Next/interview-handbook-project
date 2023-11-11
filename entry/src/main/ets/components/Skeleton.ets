@Preview
@Component
export struct Skeleton {
  w: number | string = 100
  h: number | string = 20
  @State
  translateValue: string = '-100%'

  build() {
    Stack() {
      Text()
        .backgroundColor($r('app.color.ih_bg_color'))
        .height('100%')
        .width('100%')
      Text()
        .linearGradient({
          angle: 135,
          colors: [['rgba(255,255,255,0)', 0], ['rgba(255,255,255,0.5)', 0.5], ['rgba(255,255,255,0)', 1]]
        })
        .height('100%')
        .width('100%')
        .translate({
          x: this.translateValue,
        })
        .animation({
          duration: 1500,
          iterations: -1
        })
    }
    .height(this.h)
    .width(this.w)
    .borderRadius(4)
    .clip(true)
    .onAppear(() => {
      this.translateValue = '120%'
    })
  }
}
