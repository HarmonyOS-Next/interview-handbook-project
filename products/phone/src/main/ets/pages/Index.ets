import { TabBarComp } from '../views/Index/TabBarComp';
import { windowManager } from '@itcast/basic';

@Entry
@Component
struct Index {
  @State
  show: boolean = false
  @State
  @Watch('onChangeIndex')
  activeIndex: number = 0

  onChangeIndex() {
    if (this.activeIndex === 3) windowManager.settingStatusBarLight()
    else windowManager.settingStatusBarDark()
  }

  aboutToAppear(): void {
    setTimeout(() => {
      this.show = !this.show
    }, 2000)
  }

  onPageShow(): void {
    windowManager.enableFullScreen()
    this.onChangeIndex()
  }

  onPageHide(): void {
    this.onChangeIndex()
  }

  build() {
    if (this.show) {

      Flex() {
        TabBarComp({ activeIndex: this.activeIndex })
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