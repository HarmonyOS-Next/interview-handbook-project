import { HdList, HdListController } from '@itcast/basic/Index'
import { QuestionItemModel, questionListData } from '../models/QuestionItemModel'
import { QuestionItemComp } from './QuestionItemComp'
import promptAction from '@ohos.promptAction'

@Component
export struct QuestionListComp {
  @Prop
  typeId: number
  @Prop
  activeIndex: number = -1
  @Prop
  @Watch('reLoad')
  difficult: number = -1
  @Prop
  @Watch('reLoad')
  sort: number = -1
  @State
  list: QuestionItemModel[] = []
  // self index
  selfIndex: number = -1
  timer: number = 0
  controller = new HdListController()

  onLoad() {
    setTimeout(() => {
      const data = questionListData.sort(() => Math.random() > 0.5 ? -1 : 1)
      this.list = [...this.list, ...data.map(item => new QuestionItemModel(item))]
      this.controller.loaded()
      if (this.list.length >= 50) {
        this.controller.finished()
      }
    }, 500)
  }

  onRefresh() {
    setTimeout(() => {
      const data = questionListData.sort(() => Math.random() > 0.5 ? -1 : 1)
      this.list = [...data.map(item => new QuestionItemModel(item))]
      this.controller.refreshed()
      promptAction.showToast({ message: '已更新' })
    }, 500)
  }

  reLoad() {
    if (this.list.length && this.activeIndex === this.selfIndex) {
      if (this.timer) clearTimeout(this.timer)
      this.timer = setTimeout(() => {
        this.controller.reload()
        this.onRefresh()
      })
    }
  }

  build() {
    HdList({
      controller: this.controller,
      onLoad: () => {
        this.onLoad()
      },
      onRefresh: () => {
        this.onRefresh()
      }
    }) {
      ForEach(this.list, (item: QuestionItemModel) => {
        ListItem() {
          QuestionItemComp({ item })
        }
      })
    }
  }
}
