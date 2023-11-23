import { QuestionItem, ResponseData } from '../models'
import { BasicDataSource } from '../models/BasicDatasource'
import { DIFFICULTY_MAP, EVENT_MAP, PAGE_MAP } from '../constants'
import router from '../utils/router'
import { requestGet } from '../utils/request'
import emitter from '@ohos.events.emitter'
import { LoadingWrapper } from './LoadingWrapper'
import { vp2vp } from '../utils/base'

// const mockList = [
//   {
//     id: '1',
//     stem: 'Vue2响应式原理？',
//     likeCount: 120,
//     views: 236,
//     difficulty: 2,
//   },
//   {
//     id: '2',
//     stem: '你都使用过哪些Vue3的组合式API？',
//     likeCount: 87,
//     views: 540,
//     difficulty: 1,
//   },
//   {
//     id: '3',
//     stem: '描述下Css选择器优先级',
//     likeCount: 10,
//     views: 29,
//     difficulty: 0,
//   }
// ]

class QuestionDataSource extends BasicDataSource {
  private questionList: Array<QuestionItem> = []

  public totalCount(): number {
    return this.questionList.length;
  }

  public getData(index: number): QuestionItem {
    return this.questionList[index];
  }

  public reloadData() {
    this.questionList.splice(0, this.questionList.length)
    this.notifyDataReload()
  }

  public addData(index: number, data: QuestionItem): void {
    this.questionList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public updateData(data: Partial<QuestionItem>): void {
    const index = this.questionList.findIndex(item => item.id === data.id)
    if (index > -1) {
      this.questionList.splice(index, 1, { ...this.questionList[index], ...data });
      this.notifyDataChange(index);
    }
  }

  public pushData(data: Array<QuestionItem>): void {
    this.questionList.push(...data);
    this.notifyDataAdd(this.questionList.length - 1);
  }
}

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
  @LocalStorageLink('sharedQuestionList')
  sharedQuestionList: Array<QuestionItem> = []
  @State
  total: number = 0
  @State
  pageTotal: number = 0
  @State
  params: {
    type: number,
    page: number,
    sort?: number,
    keyword?: string
    questionBankType: number
  } = {
    questionBankType: 10,
    type: this.questionTypeId,
    page: 1,
    sort: 0,
    keyword: undefined,
  }
  questionDataSource = new QuestionDataSource()
  @State
  refreshing: boolean = false

  aboutToAppear() {
    this.initQuestionList()

    emitter.on({ eventId: EVENT_MAP.update_question_list }, (e) => {
      this.questionDataSource.updateData(e.data)
    })
  }

  initQuestionList() {
    if (this.activeQuestionTypeId === this.questionTypeId && this.questionDataSource.totalCount() === 0) {
      this.sharedQuestionList = []

      this.loadQuestionList()
    }
  }

  loadQuestionList() {
    if (this.loading || this.finished) return;
    this.loading = true

    requestGet('question/list', this.params)
      .then((res: ResponseData<{
        total: number,
        pageTotal: number
        rows: Array<QuestionItem>
      }>) => {
        // this.questionList.push(...res.data.rows)
        this.questionDataSource.pushData(res.data.rows)
        // 存储 LocalStorage
        this.sharedQuestionList.push(...res.data.rows)
        this.total = res.data.total
        this.pageTotal = res.data.pageTotal
        if (this.params.page >= this.pageTotal) {
          this.finished = true
        } else {
          this.params.page++
        }
        this.loading = false
      })
  }

  @Builder
  ListFooterBuilder() {
    if (this.finished) {
      Row() {
        Text('没有更多了~').fontColor($r('app.color.ih_gray_color')).fontSize(vp2vp(14))
      }.width('100%').height(vp2vp(50)).justifyContent(FlexAlign.Center)
    } else {
      if (this.loading) {
        Row() {
          LoadingProgress().width(vp2vp(24)).margin({ right: vp2vp(5) })
          Text('加载中...').fontColor($r('app.color.ih_gray_color')).fontSize('14fp')
        }.width('100%').height(vp2vp(50)).justifyContent(FlexAlign.Center)
      }
    }
  }

  build() {
    Refresh({ refreshing: $$this.refreshing, offset: 0, friction: 60}) {
      List() {
        LazyForEach(this.questionDataSource, (item: QuestionItem) => {
          ListItem() {
            Column() {
              Row() {
                Text(DIFFICULTY_MAP[item.difficulty]?.text)
                  .fontColor(DIFFICULTY_MAP[item.difficulty]?.color)
                  .fontSize(vp2vp(10))
                  .width(vp2vp(34))
                  .height(vp2vp(18))
                  .backgroundColor($r('app.color.ih_bg_color'))
                  .borderRadius(vp2vp(2))
                  .textAlign(TextAlign.Center)
                  .margin({ right: vp2vp(7) })
                Text(item.stem)
                  .fontSize(vp2vp(16))
                  .layoutWeight(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
              }.width('100%')

              Row() {
                Text(`点赞 ${item.likeCount}`).fontColor('#C3C3C5').fontSize(vp2vp(13))
                Text('|').width(vp2vp(30)).textAlign(TextAlign.Center).fontColor('#C3C3C5').fontSize(vp2vp(13))
                Text(`浏览 ${item.views}`).fontColor('#C3C3C5').fontSize(vp2vp(13))
                if (item.readFlag === 1) {
                  Text('|')
                    .width(vp2vp(30))
                    .textAlign(TextAlign.Center)
                    .fontColor('#C3C3C5')
                    .fontSize(vp2vp(13))
                  Text(`已看过`).fontColor('#C3C3C5').fontSize(vp2vp(13))
                }
              }
              .width('100%')
              .margin({ top: vp2vp(10) })
            }.onClick(() => {
              router.push({
                url: PAGE_MAP.question_detail,
                params: {
                  id: item.id,
                  stem: item.stem
                }
              })
            })
          }
          .height(vp2vp(80))
          .width('100%')
        }, ({id,likeCount,readFlag}) => JSON.stringify({ id, likeCount, readFlag }))
        ListItem() {
          LoadingWrapper({
            loading: this.loading,
            finished: this.finished
          })
        }
      }
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.ih_bg_color')
      })
      .padding({ left: vp2vp(15), right: vp2vp(15) })
      .height('100%')
      .width('100%')
      .onReachEnd(() => {
        this.loadQuestionList()
      })
    }
    .onRefreshing(()=>{
      setTimeout(() => {
        this.refreshing = false
      }, 1000)
    })
  }
}