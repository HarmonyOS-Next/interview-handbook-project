@Component
export struct HomeDayQuestionComp {
  monthWords: string[] = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ]
  monthText: string = this.monthWords[new Date().getMonth()]
  today: string = new Date().getDate().toString().padStart(2,'0')

  build() {
    Row() {
      Row() {
        Column() {
          Text(this.monthText)
            .fontColor('#fc3c30')
            .fontSize(12)
            .fontWeight(500)
            .margin(4)
          Text(this.today)
            .fontSize(22)
        }
        .height(60)
        .width(44)
        .translate({ y: -10 })
        .backgroundColor(Color.White)
        .borderRadius(8)
        .margin({ left: 12 })
        .shadow(ShadowStyle.OUTER_DEFAULT_LG)
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('每日 1 题')
            .fontColor(14)
            .fontSize(10)
            .margin({ bottom: 8 })
          Text('JS 闭包你是怎么理解的?')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            })
            .maxLines(1)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 20 })

        DotCalendar()
      }
      .width('100%')
      .height(60)
      .backgroundColor('#EDECF2')
      .borderRadius(8)
    }
    .padding(16)
  }
}

@Component
struct DotCalendar {
  firstDay: number = 0
  days: number[] = []
  currentDate: number = 0

  aboutToAppear() {
    const now = new Date()
    this.currentDate = now.getDate()
    now.setDate(1)
    this.firstDay = now.getDay()
    now.setMonth(now.getMonth() + 1, 0)
    for (let index = 1; index <= now.getDate(); index++) {
      this.days.push(index)
    }
  }

  @Builder
  DotBuilder(active: boolean) {
    Text()
      .width(4)
      .aspectRatio(1)
      .borderRadius(2)
      .backgroundColor(!active ? '#dbdae0' : Color.White)
      .border(active ? { width: 1, color: 'green' } : {})
  }

  build() {
    GridRow({ columns: 7, gutter: 4 }) {
      ForEach(this.days, (item: number) => {
        GridCol(item === 1 ? { offset: this.firstDay } : {}) {
          this.DotBuilder(this.currentDate === item)
        }
      })
    }
    .width(59)
    .margin({ right: 20 })
  }
}