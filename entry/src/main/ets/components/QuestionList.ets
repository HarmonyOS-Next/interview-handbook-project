import { QuestionItem } from '../models/Index'
import { DIFFICULTY_MAP, PAGE_MAP } from '../constants'
import router from '@ohos.router'

@Styles function pd15() {
  .padding({ left: 15, right: 15 })
}

const mockList = [
  {
    id: '1',
    stem: 'Vue2响应式原理？',
    likeCount: 120,
    views: 236,
    difficulty: 2,
  },
  {
    id: '2',
    stem: '你都使用过哪些Vue3的组合式API？',
    likeCount: 87,
    views: 540,
    difficulty: 1,
  },
  {
    id: '3',
    stem: '描述下Css选择器优先级',
    likeCount: 10,
    views: 29,
    difficulty: 0,
  }
]

@Component
export struct QuestionList {
  @Prop
  questionTypeId: number
  @Prop
  @Watch('initQuestionList')
  activeQuestionTypeId: number
  @State
  loading: boolean = false
  @State
  finished: boolean = false
  @State
  questionList: Array<QuestionItem> = []
  @State
  params: { page: number } = { page: 1 }

  aboutToAppear() {
    this.initQuestionList()
  }

  initQuestionList() {
    if (this.activeQuestionTypeId === this.questionTypeId && this.questionList.length === 0) {
      this.loadQuestionList()
    }
  }

  loadQuestionList() {
    if (this.loading || this.finished) return;
    this.loading = true
    setTimeout(() => {
      const list = []
      for (let index = 0; index < 10; index++) {
        const element = mockList[index % 3];
        list.push(element)
      }
      this.questionList.push(...list)
      if (this.params.page === 5) {
        this.finished = true
      } else {
        this.params.page++
      }
      this.loading = false
    }, 1500)
  }

  @Builder
  ListFooterBuilder() {
    if (this.finished) {
      Row() {
        Text('没有更多了~').fontColor($r('app.color.ih_gray_color')).fontSize(14)
      }.width('100%').height(50).justifyContent(FlexAlign.Center)
    } else {
      if (this.loading) {
        Row() {
          LoadingProgress().width(24).margin({ right: 5 })
          Text('加载中...').fontColor($r('app.color.ih_gray_color')).fontSize(14)
        }.width('100%').height(50).justifyContent(FlexAlign.Center)
      }
    }
  }

  build() {
    List() {
      ForEach(this.questionList, (item: QuestionItem) => {
        ListItem() {
          Column() {
            Row() {
              Text(DIFFICULTY_MAP[item.difficulty].text)
                .fontColor(DIFFICULTY_MAP[item.difficulty].color)
                .fontSize(10)
                .width(34)
                .height(18)
                .backgroundColor($r('app.color.ih_bg_color'))
                .borderRadius(2)
                .textAlign(TextAlign.Center)
                .margin({ right: 7 })
              Text(item.stem + this.questionTypeId)
                .fontSize(16)
                .onClick(() => {
                  router.pushUrl({
                    url: PAGE_MAP.question_detail,
                    params: {
                      id: item.id,
                      stem: item.stem
                    }
                  })
                })
            }.width('100%')

            Row() {
              Text(`点赞 ${item.likeCount}`).fontColor('#C3C3C5').fontSize(13)
              Text('|').width(30).textAlign(TextAlign.Center).fontColor('#C3C3C5').fontSize(13)
              Text(`浏览 ${item.views}`).fontColor('#C3C3C5').fontSize(13)
            }
            .width('100%')
            .margin({ top: 10 })
          }
        }
        .height(80)
        .width('100%')
      })
      this.ListFooterBuilder()
    }
    .divider({
      strokeWidth: 1,
      color: $r('app.color.ih_bg_color')
    })
    .pd15()
    .height('100%')
    .width('100%')
    .edgeEffect(EdgeEffect.None)
    .onReachEnd(() => {
      this.loadQuestionList()
    })
  }
}
