import { hdHttp, HdNav } from '@itcast/basic'
import { HmCalendar, HmCalendarSelectedDay } from '@ohmos/calendar'

interface DayBuilderParams {
  day: number
  text: string
}

interface RequestParams {
  year: string,
  month: string
}

interface ClockInItem {
  id: string,
  createdAt: string
}

interface ClockInfo {
  flag: boolean
  clockinNumbers: number
  totalClockinNumber: number
  clockins: ClockInItem[]
}

@Component
export struct ClockedComp {
  @State
  clockInfo: ClockInfo = {
    clockinNumbers: 0,
    totalClockinNumber: 0,
    flag: false,
    clockins: []
  }
  @State
  selectedDays: HmCalendarSelectedDay[] = []

  aboutToAppear() {
    hdHttp.get<ClockInfo>('clockinInfo').then((res) => {
      this.clockInfo = res.data
      this.selectedDays = res.data.clockins.map(item => ({ date: item.createdAt } as HmCalendarSelectedDay))
    })
  }

  getData(month: string) {
    const arr: string[] = month.split('-')
    hdHttp.get<ClockInfo>('clockinInfo', {
      year: arr[0],
      month: arr[1]
    } as RequestParams).then((res) => {
      this.clockInfo = res.data
      this.selectedDays = res.data.clockins.map(item => ({ date: item.createdAt } as HmCalendarSelectedDay))
    })
  }

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
        this.dayBuilder({ day: this.clockInfo.totalClockinNumber, text: '累计打卡' })
        this.dayBuilder({ day: this.clockInfo.clockinNumbers, text: '连续打卡' })
      }
      .padding({ top: 10, bottom: 25, left: 16, right: 16 })
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Row() {
        HmCalendar({
          selectedDays: this.selectedDays,
          onChangeMonth: (month: string) => {
            this.getData(month)
          }
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