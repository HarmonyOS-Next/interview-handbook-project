import { router } from '@kit.ArkUI'

@Component
export struct BootView {
  @StorageProp('topHeight')
  topHeight: number = 0
  @State
  time: number = 2
  timer: number | null = null

  aboutToAppear(): void {
    this.timer = setInterval(() => {
      this.time--
      if (this.time <= 0) {
        router.replaceUrl({ url: 'pages/Index' })
      }
    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  build() {
    Column() {
      Text(this.time + 's')
        .width(50)
        .height(24)
        .borderRadius(12)
        .textAlign(TextAlign.Center)
        .fontSize(14)
        .backgroundColor('#33000000')
        .fontColor($r('app.color.white'))
        .alignSelf(ItemAlign.End)
        .margin({ right: 20, top: this.topHeight + 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.boot'))
    .backgroundImageSize(ImageSize.Cover)
    .geometryTransition("boot")
    .transition(TransitionEffect.OPACITY)
  }
}