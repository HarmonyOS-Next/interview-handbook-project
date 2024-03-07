import { TabBarComp } from '../views/Index/TabBarComp';
import { themeManager } from '@itcast/basic';


@Entry
@Component
struct Index {
  @State
  @Watch('onChangeIndex')
  activeIndex: number = 0

  onChangeIndex() {
    if (this.activeIndex === 3) themeManager.settingStatusBarWhite()
    else themeManager.settingStatusBarBlack()
  }

  onPageShow(): void {
    this.onChangeIndex()
  }

  onPageHide(): void {
    this.onChangeIndex()
    themeManager.settingStatusBarBlack()
  }

  build() {
    Flex() {
      TabBarComp({ activeIndex: this.activeIndex })
    }
    .backgroundColor($r('app.color.white'))
  }
}