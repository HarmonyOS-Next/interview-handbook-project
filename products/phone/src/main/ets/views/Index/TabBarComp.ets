import { HomeComp } from '@itcast/home'
import { ProjectComp } from '@itcast/project'
import { InterviewComp } from '@itcast/interview'
import { MineComp } from '@itcast/mine'
import { BasicConstant } from '@itcast/basic'
import mediaquery from '@ohos.mediaquery'
import { TabBarItems } from '../../contants'
import { TabBarModel } from '../../models/TabBarModel'

@Component
export struct TabBarComp {
  @StorageProp('bottomHeight')
  bottomHeight: number = 0
  @Link
  activeIndex: number
  @State
  isLandscape: boolean = false
  listenerScreen = mediaquery.matchMediaSync('(orientation: landscape) and (device-type: tablet)')

  aboutToAppear() {
    this.listenerScreen.on('change', (mediaQueryResult) => {
      this.isLandscape = mediaQueryResult.matches
    })
  }

  @Builder
  TabBarBuilder(item: TabBarModel, index: number) {
    Column({ space: BasicConstant.SPACE_SM }) {
      Image(this.activeIndex === index ? item.activeIcon : item.defaultIcon)
        .width($r('app.float.tab_bar_item_icon_size'))
      Text(item.label)
        .fontSize($r('app.float.tab_bar_item_font_size'))
        .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.common_gray_01'))
        .animation({ duration: 300 })
    }
  }

  build() {
    Tabs({
      index: this.activeIndex
    }) {
      ForEach(TabBarItems, (item: TabBarModel, index: number) => {
        TabContent() {
          if (index === 0) HomeComp()
          else if (index === 1) ProjectComp()
          else if (index === 2) InterviewComp()
          else MineComp()
        }
        .tabBar(this.TabBarBuilder(item, index))
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      })
    }
    .divider({ strokeWidth: $r('app.float.common_border_width'), color: $r('app.color.common_gray_border') })
    .vertical(this.isLandscape)
    .barPosition(this.isLandscape ? BarPosition.Start : BarPosition.End)
    .onTabBarClick((index) => {
      this.activeIndex = index
    })
    .barHeight(this.isLandscape ? $r('app.float.tab_bar_item_height_lg') : $r('app.float.tab_bar_item_height_sm'))
    .scrollable(false)
    .margin({ bottom: this.bottomHeight })
  }
}