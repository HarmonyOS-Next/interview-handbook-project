import { HmCalendar, HmCalendarType } from '@ohmos/calendar'

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
  today: string = new Date().getDate().toString().padStart(2, '0')

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
        .backgroundColor($r('app.color.white'))
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

        HmCalendar({
          type: HmCalendarType.MONTH_DOT,
          selectedDays: [{ date: new Date().toString() }],
          color: 'green'
        })
          .margin({ right: 20 })
      }
      .width('100%')
      .height(60)
      .backgroundColor($r('app.color.home_gray'))
      .borderRadius(8)
    }
    .padding(16)
  }
}