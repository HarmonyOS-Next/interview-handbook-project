import emitter from '@ohos.events.emitter'
import promptAction from '@ohos.promptAction'
import { EVENT_MAP, PAGE_MAP } from '../constants'
import { ClockInfo, UserInfo } from '../models'
import { requestGet, requestPost } from '../utils/request'
import router from '../utils/router'
import { vp2vp } from '../utils/base'

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
    if (user.token) {
      requestPost<{ clockinNumbers: number }>('clockin').then((res) => {
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
          Text('连续打卡').fontSize(vp2vp(9))
          Text() {
            Span(`${this.clockInCount} `).fontSize(vp2vp(10)).fontWeight(600)
            Span('天').fontSize(vp2vp(9))
          }
        }
        .width('100%')
        .padding({ left: vp2vp(26) })
      } else {
        Image($r('app.media.unclock'))
          .objectFit(ImageFit.Fill)
        Text('打卡')
          .fontSize(vp2vp(18))
          .fontWeight(600)
          .position({ x: vp2vp(28), y: vp2vp(2) })
      }

    }
    .width(vp2vp(70))
    .height(vp2vp(28))
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