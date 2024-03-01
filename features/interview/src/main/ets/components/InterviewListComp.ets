import { InterviewItemComp } from './InterviewItemComp'
import { InterviewItemModel } from '../models/InterviewItemModel'
import { HdList, HdListController } from '@itcast/basic/Index'
import promptAction from '@ohos.promptAction'
import { InterviewService } from '../services/InterviewService'

@Component
export struct InterviewListComp {
  @State
  list: InterviewItemModel[] = []
  controller = new HdListController()
  @State
  page: number = 1
  @State
  keyword: string = ''
  @Prop
  @Watch('onUpdate')
  sort: number = 30
  timer: number = -1

  onUpdate() {
    if (this.timer) clearTimeout(this.timer)
    this.timer = setTimeout(() => {
      this.controller.reload()
      this.onRefresh()
    }, 500)
  }

  onRefresh() {
    this.page = 1
    InterviewService.findInterviewList({
      questionBankType: 9,
      page: this.page,
      sort: this.sort,
      keyword: this.keyword
    }).then(res => {
      this.list = res.data.rows
      this.controller.refreshed()
      if (this.page >= res.data.pageTotal) {
        this.controller.finished()
      } else {
        this.page++
      }
      promptAction.showToast({ message: '已更新' })
    })
  }

  build() {
    HdList({
      lw: 1,
      controller: this.controller,
      onRefresh: () => {
        this.onRefresh()
      },
      onLoad: () => {
        InterviewService.findInterviewList({
          questionBankType: 9,
          page: this.page,
          sort: this.sort,
          keyword: this.keyword
        }).then(res => {
          this.list.push(...res.data.rows)
          this.controller.loaded()
          if (this.page >= res.data.pageTotal) {
            this.controller.finished()
          } else {
            this.page++
          }
        })
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