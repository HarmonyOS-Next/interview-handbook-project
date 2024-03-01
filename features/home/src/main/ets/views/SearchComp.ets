import { HdSearch } from '@itcast/basic'
import { InterviewListComp } from '@itcast/interview'
import { router } from '@kit.ArkUI'
import { QuestionListComp } from '../components/QuestionListComp'
import { SearchHistoryComp } from '../components/SearchHistoryComp'
import { historyStore } from '../utils/history'

interface TabItem {
  name: string
  value: 9 | 10
  onAreaChange?: (area: Area) => void
}

interface RouterParams {
  type?: number
  questionBankType: 9 | 10
}

@Component
export struct SearchComp {
  @StorageProp('topHeight')
  topHeight: number = 0
  @State
  left: number = 15
  @State
  questionBankType: 9 | 10 = 10
  @State
  isSearching: Boolean = false
  @State
  keyword: string = ''

  aboutToAppear(): void {
    const params = (router.getParams() || {}) as RouterParams
    this.questionBankType = params.questionBankType
  }

  // 设置线位置
  setLineLeft(area: Area) {
    const width = area.width as number
    const x = area.position.x as number
    this.left = x + (width - 20) / 2
  }

  @Builder
  tabBuilder(tab: TabItem) {
    Text(tab.name)
      .fontSize(15)
      .fontColor(this.questionBankType === tab.value ? $r('app.color.common_blue') : '#979797')
      .animation({
        duration: 300
      })
      .onClick((e) => {
        this.setLineLeft(e.target.area)
        this.questionBankType = tab.value
      })
      .onAreaChange((_o, n) => tab.onAreaChange && tab.onAreaChange(n))
  }

  build() {
    Column() {
      Row({ space: 15 }) {
        HdSearch({
          ph: '请输入关键词',
          readonlyMode: false,
          bg: '#f3f4f5',
          val: this.keyword,
          onSubmit: () => {
            if (this.keyword) {
              this.isSearching = true
              historyStore.setItem(this.keyword)
            }
          },
          onChange: (val: string) => {
            this.keyword = val
            if (!val) {
              this.isSearching = false
            }
          }
        })
          .layoutWeight(1)
        Text('取消')
          .fontSize(15)
          .fontColor($r('app.color.common_blue'))
          .onClick(() => router.back())
      }
      .padding({ top: 15, left: 15, right: 15, bottom: 2 })

      // 标签页
      Row() {
        Row({ space: 20 }) {
          this.tabBuilder({
            name: '试题', value: 10,
            onAreaChange: (area) => {
              if (this.questionBankType === 10) this.setLineLeft(area)
            }
          })
          this.tabBuilder({
            name: '面经', value: 9,
            onAreaChange: (area) => {
              if (this.questionBankType === 9) this.setLineLeft(area)
            }
          })
        }
        .width('100%')
        .padding({ left: 15, right: 15 })
        .height(40)
        .border({
          width: { bottom: $r('app.float.common_border_width') },
          color: $r('app.color.common_gray_border')
        })

        Text()
          .width(20)
          .height(2)
          .backgroundColor($r('app.color.common_blue'))
          .position({ x: this.left, y: 38 })
          .animation({
            duration: 300
          })
      }

      if (this.isSearching) {
        if (this.questionBankType === 10) {
          QuestionListComp({
            keyword: encodeURIComponent(this.keyword),
            sort: 0
          })
            .layoutWeight(1)
        }
        if (this.questionBankType === 9) {
          InterviewListComp({
            keyword: encodeURIComponent(this.keyword)
          })
        }
      } else {
        SearchHistoryComp({
          onSearch: (text: string) => {
            this.keyword = text
            this.isSearching = true
          }
        })
      }
    }
    .padding({ top: this.topHeight })
  }
}