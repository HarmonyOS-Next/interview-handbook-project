import { HdNav } from '@itcast/basic'
import { HmCalendar } from '@ohmos/calendar'

interface DayBuilderParams {
  day: number
  text: string
}

@Component
export struct ClockedComp {
  @Builder
  dayBuilder(params: DayBuilderParams) {
    Column() {
      Row() {
        Text(params.day.toString())
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
        Text('天')
          .fontSize(10)
          .fontColor($r('app.color.common_gray_01'))
          .margin({ bottom: 8, left: 10 })
      }
      .alignItems(VerticalAlign.Bottom)

      Text(params.text)
        .fontSize(10)
        .fontColor($r('app.color.common_gray_01'))
    }.margin({ right: 36 })
  }

  build() {
    Column({ space: 16 }) {
      HdNav({ title: '每日打卡', showRightIcon: false })
      Row() {
        this.dayBuilder({ day: 40, text: '累计打卡' })
        this.dayBuilder({ day: 15, text: '连续打卡' })
      }
      .padding({ top: 10, bottom: 25, left: 16, right: 16 })
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Row() {
        HmCalendar({
          selectedDays: [{ date: '2024-01-23' }]
        })
          .borderRadius(8)
          .border({ width: 0.5, color: '#ededed' })
          .shadow({ color: '#ededed', radius: 16 })
          .backgroundColor('#FFFFFF')
      }
      .padding({ left: 16, right: 16 })

      Button() {
        Row() {
          Text('分享成就 ')
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('sys.media.ohos_ic_public_share'))
            .width(16)
            .aspectRatio(1)
            .fillColor(Color.White)
        }
      }
      .padding({ top: 8, bottom: 8, left: 16, right: 16 })
      .backgroundColor('#ffaa00')
      .margin({ top: 50 })
      .shadow({ radius: 5, color: '#dddddd', offsetX: 5, offsetY: 5 })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.clocked_bg'))
    .backgroundImageSize({ width: '100%' })
  }
}