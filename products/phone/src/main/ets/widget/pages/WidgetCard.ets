const shard = LocalStorage.getShared()

export interface BtnItem {
  src: ResourceStr
  text?: ResourceStr
  onClick?: () => void
}

@Entry(shard)
@Component
struct WidgetCard {
  @LocalStorageProp('formId')
  formId: string = ''
  @LocalStorageProp('clockinNumbers')
  clockinNumbers: number = 0
  @LocalStorageProp('token')
  token: string = ''

  @Builder
  BtnBuilder(item: BtnItem) {
    Column({ space: 6 }) {
      Row() {
        Image(item.src)
          .width(24)
          .aspectRatio(1)
          .fillColor($r('app.color.common_main_color'))
      }
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.white'))
      .width(40)
      .aspectRatio(1)
      .borderRadius(20)

      Text(item.text)
        .fontSize(12)
        .fontColor($r('app.color.white'))
    }
    .onClick(() => {
      item.onClick && item.onClick()
    })
  }

  build() {
    Stack() {
      Image($r('app.media.card_bg'))
        .width('100%')
        .height('100%')
        .opacity(0.4)
        .objectFit(ImageFit.Cover)
      Column({ space: 12 }) {
        Row({ space: 6 }) {
          Image($r('app.media.icon'))
            .width(20)
            .height(20)
            .borderRadius(4)
          Text('面试通')
            .fontSize(16)
            .fontColor($r('app.color.white'))
        }

        Text('搞定企业面试真题')
          .fontSize(13)
          .fontColor($r('app.color.white'))
          .opacity(0.6)

        Row({ space: 36 }) {
          this.BtnBuilder({
            src: this.token && this.clockinNumbers > 0
              ? $r('app.media.ic_questionnaire_filled')
              : $r('app.media.ic_public_calendar_filled'),
            text: '打卡',
            onClick: () => {
              console.log('INTERVIEW_LOGGER', this.formId)
              postCardAction(this, {
                action: 'call',
                abilityName: 'PhoneAbility',
                params: {
                  formId: this.formId,
                  method: 'clock_in'
                }
              })
            }
          })
          this.BtnBuilder({
            src: $r('app.media.ic_public_file_filled'),
            text: '面经',
            onClick: () => {
              postCardAction(this, {
                action: 'router',
                abilityName: 'PhoneAbility',
                params: {
                  page: 'interview',
                }
              })
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .height('100%')
      .padding(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.common_main_color'))
  }
}