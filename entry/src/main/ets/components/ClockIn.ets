import emitter from '@ohos.events.emitter'
import promptAction from '@ohos.promptAction'
import { EVENT_MAP, PAGE_MAP } from '../constants'
import { ClockInfo, UserInfo } from '../models'
import { requestGet, requestPost } from '../utils/request'
import router from '../utils/router'
import logger from '../utils/logger'

@Component
export struct ClockIn {
  @State
  clockInCount: number = 0

  aboutToAppear() {
    this.updateClockInfo()
    emitter.on({ eventId: EVENT_MAP.clock }, () => {
      this.updateClockInfo()
    })
  }

  updateClockInfo() {
    const user = JSON.parse(AppStorage.Get('user') || '{}') as UserInfo
    if (user.token) {
      // 查询签到信息
      requestGet<ClockInfo>('clockinInfo').then((res) => {
        this.clockInCount = res.data.clockinNumbers
      })
    } else {
      this.clockInCount = 0
    }
  }

  clockIn() {
    const user = JSON.parse(AppStorage.Get('user') || '{}') as UserInfo
    if ( user.token ) {
      requestPost<{ clockinNumbers: number }>('clockin').then((res)=>{
        promptAction.showToast({ message: '打卡成功' })
        this.clockInCount = res.data.clockinNumbers
      })
    } else {
      router.push({
        url: PAGE_MAP.login
      })
    }
  }

  build() {
    Stack() {
      if (this.clockInCount > 0) {
        Image($r('app.media.clocked'))
          .objectFit(ImageFit.Fill)
        Column() {
          Text('连续打卡').fontSize(9)
          Text() {
            Span(`${this.clockInCount} `).fontSize(10).fontWeight(600)
            Span('天').fontSize(9)
          }
        }
        .width('100%')
        .padding({ left: 26 })
      } else {
        Image($r('app.media.unclock'))
          .objectFit(ImageFit.Fill)
        Text('打卡')
          .fontSize(18)
          .fontWeight(600)
          .position({ x: 28, y: 2 })
      }

    }
    .width(70)
    .height(28)
    .onClick(() => {
      if (this.clockInCount > 0) {
        router.push({
          url: PAGE_MAP.clock
        })
      } else {
        this.clockIn()
      }
    })
  }
}