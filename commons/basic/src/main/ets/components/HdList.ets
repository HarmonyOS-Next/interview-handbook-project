import { BasicConstant } from '../constants/BasicConstant'

export class HdListController {
  loaded: () => void = () => {
  }
  finished: () => void = () => {
  }
  refreshed: () => void = () => {
  }
  reload: () => void = () => {
  }
}

@Component
export struct HdList {
  @State
  refreshing: boolean = false
  @State
  finished: boolean = false
  @State
  loading: boolean = false
  // options
  lw: number = 0

  @Builder
  defaultListContent() {
  }

  @BuilderParam
  listContent: () => void = this.defaultListContent
  // function
  onLoad: () => void = () => {
  }
  onRefresh: () => void = () => {
  }
  // controller
  controller: HdListController = new HdListController()
  scroller: Scroller = new Scroller()

  aboutToAppear() {
    if (this.controller) {
      this.controller.loaded = () => this.loading = false
      this.controller.finished = () => this.finished = true
      this.controller.refreshed = () => this.refreshing = false
      this.controller.reload = () => {
        this.finished = false
        this.refreshing = true
      }
    }
  }

  @Builder
  loadMoreBuilder() {
    ListItem() {
      if (this.finished) {
        Row() {
          Text($r('app.string.hd_list_finished'))
            .fontColor(Color.Gray)
            .fontSize($r('app.float.hd_list_load_font'))
        }
        .height($r('app.float.hd_list_load_height'))
        .width('100%')
        .justifyContent(FlexAlign.Center)
      } else if (this.loading && !this.finished) {
        Row() {
          LoadingProgress()
            .width($r('app.float.hd_list_load_icon'))
          Text($r('app.string.hd_list_loading'))
            .fontColor(Color.Gray)
            .fontSize($r('app.float.hd_list_load_font'))
        }
        .height($r('app.float.hd_list_load_height'))
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .height($r('app.float.hd_list_load_height'))
  }

  build() {
    Refresh({ refreshing: $$this.refreshing }) {
      List({ scroller: this.scroller }) {
        this.listContent()
        this.loadMoreBuilder()
      }
      .width('100%')
      .height('100%')
      .padding({ left: BasicConstant.SPACE_LG, right: BasicConstant.SPACE_LG })
      .divider({
        strokeWidth: $r('app.float.common_border_width'),
        color: $r('app.color.common_gray_border')
      })
      .onReachEnd(() => {
        if (this.loading || this.refreshing || this.finished) return;
        this.loading = true
        this.onLoad()
      })
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .height('100%')
    .layoutWeight(this.lw)
    .onRefreshing(() => {
      if (this.loading || this.refreshing) return;
      this.finished = false
      this.onRefresh()
      // tip: must next tick
    })
  }
}
