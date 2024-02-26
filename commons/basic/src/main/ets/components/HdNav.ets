import { router } from '@kit.ArkUI'

@Component
export struct HdNav {
  @StorageProp('topHeight')
  topHeight: number = 0
  @Prop
  title: string = ''
  @Prop
  hasBorder: boolean = false
  @Prop
  leftIcon: ResourceStr = $r('app.media.ic_common_back')
  @Prop
  rightIcon: ResourceStr = $r('sys.media.ohos_ic_public_more')
  @Prop
  showRightIcon: boolean = true
  @BuilderParam
  titleBuilder: () => void
  @BuilderParam
  menuBuilder: () => void

  build() {
    Row({ space: 16 }) {
      Image(this.leftIcon)
        .size({ width: 24, height: 24 })
        .onClick(() => router.back())
      Row() {
        if (this.title) {
          Text(this.title)
            .fontWeight(600)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        } else if (this.titleBuilder) {
          this.titleBuilder()
        }
      }
      .height(56)
      .layoutWeight(1)

      if (this.showRightIcon) {
        Image(this.rightIcon)
          .size({ width: 24, height: 24 })
          .objectFit(ImageFit.Contain)
          .bindMenu(this.menuBuilder)
      } else {
        Blank()
          .width(24)
      }
    }

    .padding({ left: 16, right: 16, top: this.topHeight })
    .height(56 + this.topHeight)
    .width('100%')
    .border({
      width: { bottom: this.hasBorder ? $r('app.float.common_border_width') : 0 },
      color: $r('app.color.common_gray_bg')
    })
  }
}