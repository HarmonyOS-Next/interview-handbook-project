import { InterviewItemComp } from './InterviewItemComp'
import { InterviewItemModel, interviewListData } from '../models/InterviewItemModel'
import { HdList, HdListController } from '@itcast/basic/Index'
import promptAction from '@ohos.promptAction'

@Component
export struct InterviewListComp {
  @State
  list: InterviewItemModel[] = []
  controller = new HdListController()

  build() {
    HdList({
      lw: 1,
      controller: this.controller,
      onRefresh: () => {
        setTimeout(() => {
          this.list = interviewListData.sort(item => Math.random() - 0.5 > 0 ? 1 : -1)
          this.controller.refreshed()
          promptAction.showToast({ message: '已更新' })
        }, 500)
      },
      onLoad: () => {
        setTimeout(() => {
          this.list = [...this.list, ...interviewListData]
          this.controller.loaded()
          if (this.list.length > 10) {
            this.controller.finished()
          }
        }, 500)
      }
    }) {
      ForEach(this.list, (item: InterviewItemModel) => {
        ListItem() {
          InterviewItemComp({ item })
        }
      })
    }

    // .width('100%')
    // .layoutWeight(1)

    // .divider({
    //   strokeWidth: 8,
    //   color: $r('app.color.common_gray_bg'),
    // })
  }
}