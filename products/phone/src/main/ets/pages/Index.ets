import { TabBarComp } from '../views/Index/TabBarComp';
import { authStore, windowManager } from '@itcast/basic';


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
    authStore.initUser()

    // let atManager = abilityAccessCtrl.createAtManager();
    // let context: Context = getContext(this) as common.UIAbilityContext;
    // atManager.requestPermissionsFromUser(context, [
    //   "ohos.permission.LOCATION",
    //   "ohos.permission.APPROXIMATELY_LOCATION",
    //   "ohos.permission.ACCESS_BLUETOOTH",
    // ])
    setTimeout(() => {
      animateTo({ duration: 1000 }, () => {
        this.show = !this.show
      })
    }, 1000)
  }

  onPageShow(): void {
    windowManager.enableFullScreen()
    this.onChangeIndex()
  }

  onPageHide(): void {
    this.onChangeIndex()
    windowManager.settingStatusBarDark()
  }

  build() {
    if (this.show) {
      Flex() {
        TabBarComp({ activeIndex: this.activeIndex })
      }
      .geometryTransition("boot")
      .transition(TransitionEffect.OPACITY)
    } else {
      Column()
        .width('100%')
        .height('100%')
        .backgroundImage($r('app.media.boot'))
        .backgroundImageSize(ImageSize.Cover)
        .geometryTransition("boot")
        .transition(TransitionEffect.OPACITY)
    }
  }
}