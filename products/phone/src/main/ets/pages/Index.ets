import { TabBarComp } from '../views/Index/TabBarComp';
import { windowManager } from '@itcast/basic';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';


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
    let atManager = abilityAccessCtrl.createAtManager();
    let context: Context = getContext(this) as common.UIAbilityContext;
    atManager.requestPermissionsFromUser(context, [
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION",
      "ohos.permission.ACCESS_BLUETOOTH",
    ])
    setTimeout(() => {
      animateTo({ duration: 1000 }, () => {
        this.show = !this.show
      })
    }, 2000)
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


// 1. 接口 (人：名字 年龄 体重)
interface Person {
  name: string
  age: number
  weight: number
}

// 2. 定义对象
let person: Person = {
  name: '杨幂',
  age: 37,
  weight: 90
}

// 3. 访问对象数据
console.log('名字', person.name)
console.log('年龄', person.age)