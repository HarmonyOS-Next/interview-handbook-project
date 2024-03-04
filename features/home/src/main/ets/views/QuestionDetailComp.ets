import { hdHttp, HdLoadingDialog, HdNav, HdTag, HdWeb, logger } from '@itcast/basic'
import { QuestionDetail } from '../models/QuestionItemModel'
import { promptAction, router } from '@kit.ArkUI'
import { webview } from '@kit.ArkWeb'
import { DetailParams } from '../components/QuestionListComp'

export interface OptPrams {
  id: string,
  type: number,
  optType: 1 | 2
}

interface RecordItem {
  questionId: string
  startTime: number
  endTime: number
}

interface RecordParams {
  timeList: RecordItem[]
}

@Component
export struct QuestionDetailComp {
  @State
  item: QuestionDetail = {} as QuestionDetail
  @State
  list: QuestionDetail[] = []
  @State
  index: number = 0
  @State
  loadingHtml: boolean = false
  webController = new webview.WebviewController()
  // 埋点
  startTime: number = Date.now()
  records: RecordItem[] = []

  recordPoint(isVisible: boolean) {
    if (isVisible) {
      this.startTime = Date.now()
    } else {
      this.records.push({
        questionId: this.item.id,
        startTime: this.startTime,
        endTime: Date.now()
      })
      hdHttp.post<null>('time/tracking', { timeList: this.records } as RecordParams)
        .then(res => {
          this.records = []
        })
    }
  }

  aboutToAppear() {
    const params = router.getParams() as DetailParams
    if (params) {
      this.item = params.item as QuestionDetail
      this.list = params.list as QuestionDetail[]
      this.index = this.list.findIndex(item => item.id === this.item.id)
      this.getData()
    }
  }

  getData() {
    this.dialog.open()
    return hdHttp.get<QuestionDetail>(`question/${this.item.id}`)
      .then(res => {
        this.item = res.data
        this.list[this.index] = res.data
        this.webController.runJavaScript(`writeContent(\`${this.item.answer || ''}\`)`)
        this.dialog.close()
      })
      .catch(() => {
        this.dialog.close()
      })
  }

  dialog: CustomDialogController = new CustomDialogController({
    builder: HdLoadingDialog({ message: '加载中...' }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  async toggleData() {
    // 埋点
    this.records.push({
      questionId: this.item.id,
      startTime: this.startTime,
      endTime: Date.now()
    })
    this.startTime = Date.now()
    // 切换
    const newItem = this.list[this.index]
    this.item.id = newItem.id
    if (!newItem.answer) {
      await this.getData()
    } else {
      this.item = newItem
      this.webController.runJavaScript(`writeContent(\`${this.item.answer || ''}\`)`)
    }
  }

  async prev() {
    if (this.index <= 0) return promptAction.showToast({ message: '没有更多题了' })
    this.index--
    this.toggleData()
  }

  async next() {
    if (this.index >= this.list.length - 1) return promptAction.showToast({ message: '没有更多题了' })
    this.index++
    this.toggleData()
  }

  /**
   * 操作:点赞、收藏
   * @param type = 1 | 2
   */
  async opt(optType: 1 | 2, flag: 0 | 1) {
    try {
      let data: OptPrams = {
        id: this.item.id,
        type: 0,
        optType
      }
      await hdHttp.post<null>(flag === 1 ? 'question/opt' : 'question/unOpt', data)
      if (optType === 1) {
        this.item.likeFlag = flag
        return promptAction.showToast({ message: flag === 1 ? '点赞成功' : '取消点赞' })
      }
      if (optType === 2) {
        this.item.collectFlag = flag
        return promptAction.showToast({ message: flag === 1 ? '收藏成功' : '取消收藏' })
      }
    } catch (err) {
      logger.error(err.message)
      promptAction.showToast({ message: '操作失败' })
    }
  }

  @Builder
  TitleBuilder(text: string) {
    Row() {
      Text()
        .width(2)
        .height(12)
        .backgroundColor('#121826')
        .margin({ right: 13 })
      Text(text)
        .fontWeight(700)
    }
    .width('100%')
    .padding({ top: 10 })
    .height(32)
  }

  @Builder
  MenuBuilder() {
    Menu() {
      MenuItem({ content: this.item.likeFlag === 0 ? '点赞' : '取消点赞' })
        .onClick(() => {
          this.opt(1, this.item.likeFlag === 1 ? 0 : 1)
        })
      MenuItem({ content: this.item.collectFlag === 0 ? '收藏' : '取消收藏' })
        .onClick(() => {
          this.opt(2, this.item.collectFlag === 1 ? 0 : 1)
        })
      MenuItem({ content: '点我反馈' })
      MenuItem({ content: '试题分享' })
    }
    .width(108)
  }

  build() {
    Column() {
      HdNav({ title: '试题详情', showRightIcon: false })
      this.TitleBuilder('题目：')
      Text(this.item.stem.trim())
        .width('100%')
        .padding(15)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Row() {
        ForEach(this.item.stage, (tag: string) => {
          HdTag({ text: tag })
            .margin({ right: 5 })
        })
        Blank()
        Image($r("app.media.ic_home_more"))
          .width(20)
          .aspectRatio(1)
          .bindMenu(this.MenuBuilder())
      }
      .width('100%')
      .padding({ bottom: 15, left: 15, right: 15 })

      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))
      // 内容
      this.TitleBuilder('答案：')
      HdWeb({
        controller: this.webController, onLoad: () => {
          this.webController.runJavaScript(`writeContent(\`${this.item.answer || ''}\`)`)
        }
      })
        .layoutWeight(1)
        .padding({ top: 15, bottom: 15 })

      Row({ space: 50 }) {
        Row() {
          Image($r('sys.media.ohos_ic_public_arrow_left'))
            .width(20)
            .aspectRatio(1)
            .fillColor(this.index <= 0 ? $r('app.color.common_gray_01') : $r('app.color.common_gray_03'))
          Text(' 上一题')
            .fontColor(this.index <= 0 ? $r('app.color.common_gray_01') : $r('app.color.common_gray_03'))
        }
        .onClick(() => {
          this.prev()
        })

        Row() {
          Text('下一题 ')
            .fontColor(this.index >= this.list.length - 1 ? $r('app.color.common_gray_01') : $r('app.color.common_gray_03'))
          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(20)
            .aspectRatio(1)
            .fillColor(this.index >= this.list.length - 1 ? $r('app.color.common_gray_01') : $r('app.color.common_gray_03'))
        }
        .onClick(() => {
          this.next()
        })
      }
      .height(44)
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .onVisibleAreaChange([0, 1], (isVisible) => {
      this.recordPoint(isVisible)
    })
  }
}