import { TabBarComp } from '../views/Index/TabBarComp';
import { themeManager } from '@itcast/basic';
import { emitter } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State
  @Watch('onChangeIndex')
  activeIndex: number = 0

  aboutToAppear(): void {
    emitter.on({ eventId: 10000 }, (e) => {
      if (e.data && e.data.activeIndex) {
        this.activeIndex = e.data.activeIndex
      }
    })
  }

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
    this.backTimes = 0
  }

  backTimes: number = 0

  onBackPress(): boolean | void {
    this.backTimes++
    if (this.backTimes <= 1) {
      promptAction.showToast({ message: '再按一次将退出应用' })
    }
    if (this.backTimes >= 2) {
      const ctx = getContext() as common.UIAbilityContext
      ctx.terminateSelf()
    }


    return true
  }

  build() {
    Flex() {
      TabBarComp({ activeIndex: this.activeIndex })
    }
    .backgroundColor($r('app.color.white'))
  }
}