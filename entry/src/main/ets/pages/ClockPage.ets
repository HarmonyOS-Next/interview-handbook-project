import promptAction from '@ohos.promptAction'
import EasyCalendar from '../components/MiniCalendar'
import dayjs from 'dayjs'
import { requestGet } from '../utils/request'
import { ClockInfo } from '../models'
import { vp2vp } from '../utils/base'

@Entry
@Component
struct ClockPage {
  @State
  clockInfo: ClockInfo = {
    clockinNumbers: 0,
    totalClockinNumber: 0,
    flag: false,
    clockins: []
  }
  @State
  selectedDays: string[] = []

  aboutToAppear() {
    requestGet<ClockInfo>('clockinInfo').then((res) => {
      this.clockInfo = res.data
      this.selectedDays = res.data.clockins.map(item => item.createdAt)
    })
  }

  @Builder
  dayBuilder(params: {
    day: number,
    text: string
  }) {
    Column() {
      Row() {
        Text(params.day.toString()).fontSize(vp2vp(40)).fontWeight(FontWeight.Bold)
        Text('天').fontSize(vp2vp(10)).fontColor('#7C86A2').margin({ bottom: vp2vp(8), left: vp2vp(10) })
      }.alignItems(VerticalAlign.Bottom)

      Text(params.text).fontSize(vp2vp(10)).fontColor('#7C86A2')
    }.margin({ right: vp2vp(36) })
  }

  build() {
    Column() {
      Navigation() {
        Column() {
          Row() {
            Text('今日已打卡').fontSize(vp2vp(20)).margin({ right: vp2vp(5) })
            Image($r('app.media.icon_clock_card')).width(vp2vp(20)).height(vp2vp(20)).objectFit(ImageFit.Fill)
          }.width('100%')

          Row() {
            this.dayBuilder({ day: this.clockInfo.totalClockinNumber, text: '累计打卡' })
            this.dayBuilder({ day: this.clockInfo.clockinNumbers, text: '连续打卡' })
          }
          .padding({ top: vp2vp(10), bottom: vp2vp(25) })
          .width('100%')
          .justifyContent(FlexAlign.Start)

          Row() {
            EasyCalendar({
              currentDate: dayjs().format('YYYY-MM-DD'),
              selectedDays: $selectedDays,
              onClickItem: (date: string) => {
                promptAction.showToast({ message: date })
              }
            })
          }.margin({ bottom: vp2vp(50) })

          Image($rawfile('clock_btn.png')).width(vp2vp(145)).height(vp2vp(38)).objectFit(ImageFit.Fill)

        }
        .padding(vp2vp(15))
        .layoutWeight(1)
      }
      .title('每日打卡')
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Stack)
      .backgroundImage($rawfile('clock_bg.png'))
      .backgroundImageSize(ImageSize.Contain)
      .backgroundImagePosition(Alignment.Top)
    }.backgroundColor('#f6f7f9')
  }
}