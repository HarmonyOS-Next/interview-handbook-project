@Component
export struct HomeQuestionCardComp {
  linearColor: LinerColorType = LinerColorType.GREEN
  title: string = ''
  subTitle: string = ''

  build() {
    Row() {
      Column() {
        Text(this.title)
          .fontSize(14)
          .padding({ top: 8, bottom: 8 })
          .fontColor(Color.White)
        Text(this.subTitle)
          .fontSize(10)
          .fontColor(Color.White)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .alignSelf(ItemAlign.Start)
      .padding({ right: 8 })

      Image(IMAGES[this.linearColor])
        .width(50)
        .alignSelf(ItemAlign.End)
    }
    .padding(8)
    .width(140)
    .height(100)
    .linearGradient({
      colors: LINEAR_COLOR[this.linearColor]
    })
    .borderRadius(8)
  }
}

enum LinerColorType {
  GREEN,
  BLUE,
  YELLOW,
  ORANGE,
}

const LINEAR_COLOR = [
  [['#026bf1', 0], ['#52d3ff', 1]],
  [['#fe6544', 0], ['#fdd081', 1]],
  [['#1FDE06', 0], ['#61F27A', 1]],
  [['#fe954a', 0], ['#f9b388', 1]],
]

const IMAGES: ResourceStr[] = [
  $r('app.media.card01'),
  $r('app.media.card02'),
  $r('app.media.card03'),
  $r('app.media.card04'),
]