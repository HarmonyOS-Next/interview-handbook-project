import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { DIFFICULTY_MAP, EVENT_MAP } from '../constants'
import { QuestionDetail, QuestionItem, ResponseData } from '../models'
import { requestGet, requestPost } from '../utils/request'
import emitter from '@ohos.events.emitter'
import { DetailRichText } from '../components/DetailRichText'
import logger from '../utils/logger'
import { vp2vp } from '../utils/base'

const storage = LocalStorage.GetShared()

@Entry(storage)
@Component
struct QuestionDetailPage {
  @State
  questionId: string = undefined
  @State
  stem: string = undefined
  @State
  question: QuestionDetail | undefined = undefined
  @LocalStorageLink('sharedQuestionList')
  sharedQuestionList: Array<QuestionItem> = []
  @State
  loading: boolean = false

  @State
  startTime: number = Date.now()
  @State
  timeList: {questionId: string, startTime: number, endTime: number}[] = []

  aboutToDisappear() {
    this.timeList.push({
      questionId: this.question.id,
      startTime: this.startTime,
      endTime: Date.now()
    })
    requestPost('time/tracking', { timeList: this.timeList })
      .then(res=>{
        // TODO
      })
  }

  onPageHide() {
    this.timeList.push({
      questionId: this.question.id,
      startTime: this.startTime,
      endTime: Date.now()
    })
    requestPost('time/tracking', { timeList: this.timeList })
      .then(res=>{
        this.timeList = []
      })
  }

  onPageShow(){
    this.startTime = Date.now()
  }

  aboutToAppear() {
    const params = router.getParams()
    this.questionId = params['id']
    this.stem = params['stem']
    this.getData()
  }

  getData() {
    this.loading = true
    requestGet(`question/${this.questionId}`)
      .then((res: ResponseData<QuestionDetail>) => {
        this.question = res.data
        // 已看过
        if (this.question.readFlag !== 1) {
          emitter.emit({ eventId: EVENT_MAP.update_question_list }, { data: { id: res.data.id, readFlag: 1 } })
        }
        this.loading = false
        this.startTime = Date.now()
      })
  }

  /**
   * 操作
   * @param type = 1 | 2
   */
  async opt(type: 1 | 2, flag: 0 | 1) {
    try {
      await requestPost(flag === 1 ? 'question/unOpt' : 'question/opt', {
        id: this.question.id,
        type: 0,
        optType: type
      })
      promptAction.showToast({ message: '操作成功' })
    } catch (err) {
      promptAction.showToast({ message: '操作失败' })
      return Promise.reject(err)
    }
  }

  @Builder
  titleBuilder(text: string) {
    Row() {
      Text().width(vp2vp(2)).height(vp2vp(12)).backgroundColor('#121826').margin({ right: vp2vp(13) })
      Text(text).fontWeight(600)
    }
    .width('100%')
    .padding({ top: vp2vp(10) })
    .height(vp2vp(32))
  }

  @Builder
  tagBuilder(text: string, color: string = '#41B883') {
    Text(text)
      .fontSize(vp2vp(10))
      .padding(vp2vp(5))
      .backgroundColor($r('app.color.ih_bg_color'))
      .borderRadius(vp2vp(2))
      .fontColor(color)
      .margin({ right: vp2vp(5) })
  }

  @Builder
  toggleBuilder() {
    Row() {
      Image($r("app.media.prev_black")).width(vp2vp(80)).onClick(() => {
        const index = this.sharedQuestionList.findIndex(item => item.id === this.questionId)
        if (index > 0) {
          const prev = this.sharedQuestionList[index - 1]
          this.questionId = prev.id
          this.stem = prev.stem
          this.getData()
          this.timeList.push({
            questionId: this.question.id,
            startTime: this.startTime,
            endTime: Date.now()
          })
        } else {
          promptAction.showToast({ message: '没有更多题~' })
        }
      })
      Image($r("app.media.next_black")).width(vp2vp(80)).onClick(() => {
        const index = this.sharedQuestionList.findIndex(item => item.id === this.questionId)
        if (index < this.sharedQuestionList.length - 1) {
          const next = this.sharedQuestionList[index + 1]
          this.questionId = next.id
          this.stem = next.stem
          this.getData()
          this.timeList.push({
            questionId: this.question.id,
            startTime: this.startTime,
            endTime: Date.now()
          })
        } else {
          promptAction.showToast({ message: '没有更多题~' })
        }
      })
    }.width('100%').justifyContent(FlexAlign.SpaceAround)
  }

  build() {
    Navigation() {
      Flex({ direction: FlexDirection.Column }) {
        Column() {
          this.titleBuilder('题目:')
          Column() {
            Row() {
              Text(this.stem.trim()).width('100%')
            }

            Row() {
              if (this.question) {
                this.tagBuilder(
                  DIFFICULTY_MAP[this.question.difficulty].text,
                  DIFFICULTY_MAP[this.question.difficulty].color
                )
                ForEach(this.question.stage, stage => {
                  this.tagBuilder(stage)
                })
                Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.End }) {
                  Image($r('app.media.icon_point')).width(24).bindMenu([
                    {
                      value: this.question.collectFlag === 1 ? '取消收藏' : '收藏',
                      action: () => {
                        this.opt(2, this.question.collectFlag).then(() => {
                          this.question.collectFlag = this.question.collectFlag === 1 ? 0 : 1
                        })
                      }
                    },
                    {
                      value: this.question.likeFlag === 1 ? '取消点赞' : '点赞',
                      action: () => {
                        this.opt(1, this.question.likeFlag).then(() => {
                          this.question.likeFlag = this.question.likeFlag === 1 ? 0 : 1
                          const likeCount =
                              this.question.likeFlag === 1
                              ? Number(this.question.likeCount) + 1
                              : Number(this.question.likeCount) - 1
                          emitter.emit({ eventId: EVENT_MAP.update_question_list }, {
                            data: { id: this.question.id, likeCount, }
                          })
                        })
                      }
                    },
                    {
                      value: '分享试题',
                      action: () => {
                        // TODO
                      }
                    },
                  ])
                }
                .layoutWeight(1)
              }
            }
            .height(vp2vp(40))
            .width('100%')
            .padding({ top: vp2vp(15) })
          }.padding(vp2vp(15))
        }

        Divider()
          .strokeWidth(vp2vp(8))
          .color($r('app.color.ih_bg_color'))

        Column() {
          this.titleBuilder('答案:')
          Scroll() {
            if (!this.loading) {
              DetailRichText({ content: this.question.answer })
            }
          }
          .padding(vp2vp(15))
          .layoutWeight(1)
        }.layoutWeight(1)
      }
    }
    .title('题目详情')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .toolBar(this.toggleBuilder())
  }
}