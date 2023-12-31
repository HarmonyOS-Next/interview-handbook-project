import emitter from '@ohos.events.emitter'
import promptAction from '@ohos.promptAction'
import { ClockIn } from '../components/ClockIn'
import { EVENT_MAP, PAGE_MAP } from '../constants'
import { UserInfo } from '../models'
import { getTimeText, vp2vp } from '../utils/base'
import router from '../utils/router'

@Preview
@Component
export struct MinePage {
  @StorageProp('user')
  @Watch('setUser')
  userJson: string = '{}'
  @State
  user: UserInfo = undefined

  setUser() {
    this.user = JSON.parse(this.userJson)
  }

  aboutToAppear() {
    this.setUser()
  }

  logout() {
    promptAction.showDialog({
      title: '温馨提示',
      message: '您确认要退出面试宝典APP吗？',
      buttons: [
        { text: '取消', color: '#c3c4c5' },
        { text: '确认', color: '#333333', }
      ]
    }, (err, {index}) => {
      if (index === 1) {
        AppStorage.Set('user', '{}')
        emitter.emit({ eventId: EVENT_MAP.clock })
        router.push({
          url: PAGE_MAP.login
        })
      }
    })
  }

  @Styles
  boxStyle() {
    .backgroundColor('#ffffff')
    .padding({ top: vp2vp(15), bottom: vp2vp(15) })
    .borderRadius(vp2vp(8))
    .margin({ bottom: vp2vp(15) })
  }

  build() {
    Column() {
      // 头部
      Row() {
        Image(this.user.avatar || $rawfile('avatar.png'))
          .width(vp2vp(55))
          .height(vp2vp(55))
          .borderRadius(vp2vp(30))
          .border({ width: 0.5, color: '#e4e4e4' })
          .onError(() => {
            this.user.avatar =  $rawfile('avatar.png') as unknown as string
          })
        Column() {
          if (this.user.token) {
            Text(this.user.nickName || this.user.username)
              .fontSize(vp2vp(18))
              .fontWeight(600)
              .width('100%')
              .margin({ bottom: vp2vp(5) })
            Row() {
              Text('编辑个人信息')
                .fontColor($r('app.color.ih_gray_color'))
                .fontSize(vp2vp(11))
                .margin({ right: vp2vp(4) })
              Image($r('app.media.icon_edit'))
                .width(vp2vp(10))
                .height(vp2vp(10))
                .fillColor($r('app.color.ih_gray_color'))
            }.onClick(() => {
              router.push({
                url: PAGE_MAP.profile_edit
              })
            })
            .width('100%')
          } else {
            Text('登录/注册')
              .fontSize(vp2vp(18))
              .fontWeight(600)
              .width('100%')
              .onClick(() => {
                router.push({
                  url: PAGE_MAP.login
                })
              })
          }
        }
        .layoutWeight(1)
        .padding({ left: vp2vp(12), right: vp2vp(12) })

        ClockIn()
      }
      .height(vp2vp(100))

      // 导航
      GridRow({ columns: 4 }) {
        GridCol() {
          Column() {
            Image($r('app.media.icon_my_history'))
              .width(vp2vp(30))
              .height(vp2vp(30))
              .margin({ bottom: vp2vp(8) })
              .objectFit(ImageFit.Contain)
            Text('历史记录')
              .fontColor($r('app.color.ih_gray_color'))
              .fontSize(vp2vp(14))
          }
        }

        GridCol() {
          Column() {
            Image($r('app.media.icon_my_favo'))
              .width(vp2vp(30))
              .height(vp2vp(30))
              .margin({ bottom: vp2vp(8) })
              .objectFit(ImageFit.Contain)
            Text('我的收藏')
              .fontColor($r('app.color.ih_gray_color'))
              .fontSize(vp2vp(14))
          }
        }

        GridCol() {
          Column() {
            Image($r('app.media.icon_my_zan'))
              .width(vp2vp(30))
              .height(vp2vp(30))
              .margin({ bottom: vp2vp(8) })
              .objectFit(ImageFit.Contain)
            Text('我的点赞')
              .fontColor($r('app.color.ih_gray_color'))
              .fontSize(vp2vp(14))
          }
        }

        GridCol() {
          Column() {
            Image($r('app.media.icon_my_time'))
              .width(vp2vp(30))
              .height(vp2vp(30))
              .margin({ bottom: vp2vp(8) })
              .objectFit(ImageFit.Contain)
            Text('累计学时')
              .fontColor($r('app.color.ih_gray_color'))
              .fontSize(vp2vp(14))
              .margin({ bottom: vp2vp(2) })
            Row() {
              Text(getTimeText(this.user.totalTime))
                .fontColor('#C3C3C5')
                .fontSize(vp2vp(12))
              Image($r('app.media.icon_my_arrow'))
                .fillColor('#C3C3C5')
                .width(vp2vp(12))
                .height(vp2vp(12))
            }
          }
        }.onClick(()=>{
          router.push({
            url: PAGE_MAP.study_time
          })
        })
      }
      .boxStyle()

      // 单词
      Row() {
        Text()
          .width(vp2vp(3))
          .height(vp2vp(12))
          .backgroundColor('#41B883')
        Text('前端常用词')
          .fontSize(vp2vp(16))
          .fontColor('#121826')
          .layoutWeight(vp2vp(1))
          .padding({ left: vp2vp(12) })
        Image($r('app.media.icon_my_new'))
          .width(vp2vp(53))
          .height(vp2vp(22))
          .margin({ right: vp2vp(10) })
      }
      .boxStyle()

      // 操作
      List() {
        ListItem() {
          Row() {
            Text('推荐分享').fontSize(vp2vp(16))
            Image($r('app.media.icon_my_arrow'))
              .fillColor('#C3C3C5')
              .width(vp2vp(18))
              .height(vp2vp(18))
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: vp2vp(15), right: vp2vp(15) })
        }
        .height(vp2vp(46))

        ListItem() {
          Row() {
            Text('意见反馈').fontSize(vp2vp(16))
            Image($r('app.media.icon_my_arrow'))
              .fillColor('#C3C3C5')
              .width(vp2vp(18))
              .height(vp2vp(18))
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: vp2vp(15), right: vp2vp(15) })
        }
        .height(vp2vp(46))

        ListItem() {
          Row() {
            Text('关于我们').fontSize(vp2vp(16))
            Image($r('app.media.icon_my_arrow'))
              .fillColor('#C3C3C5')
              .width(vp2vp(18))
              .height(vp2vp(18))
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: vp2vp(15), right: vp2vp(15) })
        }
        .height(vp2vp(46))

        if (this.user.token) {
          ListItem() {
            Row() {
              Text('退出登录').fontSize(vp2vp(16))
              Image($r('app.media.icon_my_arrow'))
                .fillColor('#C3C3C5')
                .width(vp2vp(18))
                .height(vp2vp(18))
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: vp2vp(15), right: vp2vp(15) })
            .onClick(() => {
              this.logout()
            })
          }
          .height(vp2vp(46))
        }
      }
      .boxStyle()
    }
    .backgroundColor($r('app.color.ih_bg_color'))
    .width('100%')
    .height('100%')
    .padding(vp2vp(15))
  }
}