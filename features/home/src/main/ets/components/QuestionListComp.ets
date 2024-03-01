import { authStore, HdList, HdListController } from '@itcast/basic/Index'
import { QuestionItem, QuestionItemModel } from '../models/QuestionItemModel'
import { QuestionItemComp } from './QuestionItemComp'
import promptAction from '@ohos.promptAction'
import { QuestionService } from '../services/QuestionService'

export interface DetailParams {
  item: QuestionItem,
  list: QuestionItem[]
}

@Component
export struct QuestionListComp {
  @Prop
  typeId: number
  @Prop
  keyword: string = ''
  @Prop
  activeIndex: number = -1
  @Prop
  @Watch('reLoad')
  difficult: number = -1
  @Prop
  @Watch('reLoad')
  sort: number = -1
  @State
  page: number = 1
  @State
  list: QuestionItemModel[] = []
  // self index
  selfIndex: number = -1
  timer: number = 0
  controller = new HdListController()

  onLoad() {
    QuestionService.findQuestionList({
      questionBankType: 10,
      type: this.typeId,
      page: this.page,
      sort: this.sort,
      keyword: this.keyword
    }).then(res => {
      this.list.push(...res.data.rows)
      this.controller.loaded()
      if (this.page < res.data.pageTotal) {
        this.page++
      } else {
        this.controller.finished()
      }
    })

  }

  onRefresh() {
    this.page = 1
    Promise.all([
      new Promise<void>((resolve, reject) => {
        setTimeout(() => {
          resolve()
        }, 1000)
      }),
      QuestionService.findQuestionList({
        questionBankType: 10,
        type: this.typeId,
        page: this.page,
        sort: this.sort,
        keyword: this.keyword
      })
    ]).then(arr => {
      this.list = arr[1].data.rows
      this.controller.refreshed()
      promptAction.showToast({ message: '已更新' })
      if (this.page < arr[1].data.pageTotal) {
        this.page++
      } else {
        this.controller.finished()
      }
    })
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
          QuestionItemComp({
            item,
            onClickItem: () => {
              const params: DetailParams = { item, list: this.list }
              authStore.checkAuth({
                url: 'pages/QuestionDetailPage',
                params: params
              })
            }
          })
        }
      })
    }
  }
}
