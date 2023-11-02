import mediaQuery from '@ohos.mediaquery';
import { HomePage } from './HomePage'

@Entry
@Component
struct Index {
  @State
  activeIndex: number = 0
  @State
  isLandscape: boolean = false
  listenerScreen = mediaQuery.matchMediaSync('(orientation: landscape) and (device-type: tablet)');

  aboutToAppear() {
    this.listenerScreen.on('change', (mediaQueryResult) => {
      this.isLandscape = mediaQueryResult.matches
    })
  }

  @Builder
  TabBarBuilder(title: string, targetIndex: number, defaultImg: Resource, selectedImg: Resource) {
    Column() {
      Image(this.activeIndex === targetIndex ? selectedImg : defaultImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.activeIndex === targetIndex ? $r('app.color.tab_selected_color') : $r('app.color.tab_default_color'))
        .fontSize(12)
        .padding({ top: 3 })
        .lineHeight(12)
    }
    .width('100%')
    .height(50)
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
        Text('项目').fontSize(30)
      }.tabBar(this.TabBarBuilder('项目', 1, $r('app.media.project'), $r('app.media.project_select')))

      TabContent() {
        Text('面经').fontSize(30)
      }.tabBar(this.TabBarBuilder('面经', 2, $r('app.media.interview'), $r('app.media.interview_select')))

      TabContent() {
        Text('我的').fontSize(30)
      }.tabBar(this.TabBarBuilder('我的', 3, $r('app.media.mine'), $r('app.media.mine_select')))
    }
    .vertical(this.isLandscape)
    .onChange((index) => {
      this.activeIndex = index
    })
  }
}