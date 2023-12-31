import mediaQuery from '@ohos.mediaquery';
import { HomePage } from './HomePage'
import { ProjectPage } from './ProjectPage'
import { MinePage } from './MinePage'
import { InterviewPage } from './InterviewPage'
import emitter from '@ohos.events.emitter';
import { EVENT_MAP } from '../constants';
import logger from '../utils/logger'
import promptAction from '@ohos.promptAction';
import { vp2vp } from '../utils/base';

const storage = LocalStorage.GetShared()

@Entry(storage)
@Component
struct Index {
  @State
  activeIndex: number = 0
  @State
  isLandscape: boolean = false
  listenerScreen = mediaQuery.matchMediaSync('(orientation: landscape) and (device-type: tablet)');
  @State
  backTime: number = Date.now()

  aboutToAppear() {
    // 关联持久化文件
    PersistentStorage.PersistProp('user', '{}')

    this.listenerScreen.on('change', (mediaQueryResult) => {
      this.isLandscape = mediaQueryResult.matches
    })
  }

  onPageShow() {
    emitter.emit({ eventId: EVENT_MAP.clock })
  }

  onBackPress() {
    if ((Date.now() - this.backTime) < 1000) {
      return false
    }

    this.backTime = Date.now()
    return true
  }

  @Builder
  TabBarBuilder(title: string, targetIndex: number, defaultImg: Resource, selectedImg: Resource) {
    Column() {
      Image(this.activeIndex === targetIndex ? selectedImg : defaultImg)
        .size({ width: vp2vp(25), height:vp2vp(25) })
      Text(title)
        .fontColor(this.activeIndex === targetIndex ? $r('app.color.tab_selected_color') : $r('app.color.tab_default_color'))
        .fontSize(vp2vp(12))
        .padding({ top: vp2vp(3) })
        .lineHeight(vp2vp(12))
    }
    .width('100%')
    .height(vp2vp(50))
    .justifyContent(FlexAlign.Center)
    .border({ width: { top: 0.5 }, color: $r('app.color.ih_bg_color'), style: BorderStyle.Solid })
    .onClick(() => {
      this.activeIndex = targetIndex
    })
  }

  build() {
    Tabs({
      barPosition: this.isLandscape ? BarPosition.Start : BarPosition.End,
      index: this.activeIndex
    }) {
      TabContent() {
        HomePage()
      }.tabBar(this.TabBarBuilder('首页', 0, $r('app.media.home'), $r('app.media.home_select')))

      TabContent() {
        ProjectPage()
      }.tabBar(this.TabBarBuilder('项目', 1, $r('app.media.project'), $r('app.media.project_select')))

      TabContent() {
        InterviewPage()
      }.tabBar(this.TabBarBuilder('面经', 2, $r('app.media.interview'), $r('app.media.interview_select')))

      TabContent() {
        MinePage()
      }.tabBar(this.TabBarBuilder('我的', 3, $r('app.media.mine'), $r('app.media.mine_select')))
    }
    .vertical(this.isLandscape)
    .onChange((index) => {
      this.activeIndex = index
    })
    .barHeight(vp2vp(50))
  }
}