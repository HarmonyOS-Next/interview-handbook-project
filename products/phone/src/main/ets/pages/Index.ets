import { TabBarComp } from '../views/Index/TabBarComp';

@Entry
@Component
struct Index {
  @State
  show: boolean = false

  aboutToAppear(): void {
    setTimeout(() => {
      this.show = !this.show
    }, 2000)
  }

  build() {
    if (this.show) {
      Flex() {
        TabBarComp()
      }
      .transition(TransitionEffect.OPACITY.animation({ duration: 1000 }))
    } else {
      Column()
        .width('100%')
        .height('100%')
        .backgroundImage($r('app.media.boot'))
        .backgroundImageSize(ImageSize.Cover)

    }
  }
}