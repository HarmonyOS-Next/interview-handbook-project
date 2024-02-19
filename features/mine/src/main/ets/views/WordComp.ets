import { HdNav, logger } from '@itcast/basic'
import { webview } from '@kit.ArkWeb'
import { util } from '@kit.ArkTS'
import { promptAction } from '@kit.ArkUI'
import { media } from '@kit.MediaKit'
import { WordSoundDialog } from '../components/WordSoundDialog'

export interface WordItem {
  zh: string
  en: string
  code: string
}

type Words = Record<string, WordItem[]>

@Component
export struct WordComp {
  @State
  showTypeSheet: boolean = false
  @State
  showCodeSheet: boolean = false
  @State
  activeIndex: number = 0
  @State
  loading: boolean = false
  // word
  words: Words = {}
  currentCode: string = ''
  currentWordEn: string = ''
  currentWordZh: string = ''
  scroller = new Scroller()

  aboutToAppear() {
    this.initWords()
  }

  initWords() {
    const uint8Array = getContext().resourceManager.getRawFileContentSync('word.json')
    const textDecoder = new util.TextDecoder()
    const jsonStr = textDecoder.decodeWithStream(uint8Array)
    this.words = JSON.parse(jsonStr) as Words
  }

  @Builder
  typeSheetBuilder() {
    Column() {
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(Object.keys(this.words), (key: string, index) => {
          Button() {
            Text(key)
              .fontSize(14)
              .fontColor(index === this.activeIndex ? $r('app.color.common_green') : $r('app.color.common_gray_01'))
          }
          .backgroundColor($r('app.color.common_gray_bg'))
          .padding({ top: 6, right: 12, bottom: 6, left: 12 })
          .margin({ right: 12, bottom: 12 })
          .onClick(() => {
            this.activeIndex = index
            this.showTypeSheet = false
            this.scroller.scrollTo({ yOffset: 0, xOffset: 0 })
          })
        })
      }
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 34 })
  }

  webController = new webview.WebviewController()

  @Builder
  codeSheetBuilder() {
    Stack() {
      Web({ src: $rawfile('word.html'), controller: this.webController })
        .width('100%')
        .height(400)
        .backgroundColor($r('app.color.common_gray_bg'))
        .javaScriptAccess(true)
        .onPageBegin(() => {
          this.loading = true
        })
        .onPageEnd(() => {
          this.loading = false
          this.webController.runJavaScript(`writeCode(\`${this.currentCode}\`)`)
        })
        .onErrorReceive(event => {
          logger.error(event!.error.getErrorInfo())
        })
        .borderRadius(8)
      if (this.loading) {
        LoadingProgress()
          .width(50)
          .aspectRatio(1)
      }
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 34 })
  }

  dialog = new CustomDialogController({
    builder: WordSoundDialog({ wordEn: this.currentWordEn, wordZh: this.currentWordZh }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column() {
      HdNav({ title: '常用单词', showRightIcon: false })
      Row() {
        Column({ space: 4 }) {
          Text('开发常用词汇')
          Text(`共 ${this.words[Object.keys(this.words)[this.activeIndex]]?.length} 个单词`)
            .fontSize(12)
            .fontColor($r('app.color.common_gray_03'))
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text(Object.keys(this.words)[this.activeIndex])
            .fontSize(12)
            .fontColor($r('app.color.common_gray_01'))
          Image($r('sys.media.ohos_ic_public_arrow_down'))
            .width(16)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_01'))
        }
        .onClick(() => this.showTypeSheet = true)
        .bindSheet($$this.showTypeSheet, this.typeSheetBuilder, {
          detents: [SheetSize.FIT_CONTENT],
          backgroundColor: Color.White,
          title: { title: '选择阶段' }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(16)
      .border({ width: { top: $r('app.float.common_border_width') }, color: $r('app.color.common_gray_bg') })

      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))

      List({ scroller: this.scroller }) {
        ForEach(this.words[Object.keys(this.words)[this.activeIndex]], (wordItem: WordItem) => {

          ListItem() {
            Row({ space: 6 }) {
              Image($r('sys.media.ohos_ic_public_sound'))
                .width(20)
                .aspectRatio(1)
                .alignSelf(ItemAlign.Start)
                .fillColor($r('app.color.common_gray_03'))
                .onClick(() => {
                  // 开启弹框
                  this.currentWordEn = wordItem.en
                  this.currentWordZh = wordItem.zh
                  this.dialog.open()
                })
              Column({ space: 10 }) {
                Text(wordItem.en)
                  .fontWeight(FontWeight.Bold)
                Text(wordItem.zh)
                  .fontSize(14)
                  .fontColor($r('app.color.common_gray_03'))
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Row() {
                Text('详细代码')
                  .fontSize(12)
                  .fontColor(wordItem.code ? $r('app.color.common_gray_01') : '#dddddd')
                Image($r('sys.media.ohos_ic_public_arrow_right'))
                  .width(16)
                  .aspectRatio(1)
                  .fillColor(wordItem.code ? $r('app.color.common_gray_01') : '#dddddd')
              }
              .alignSelf(ItemAlign.End)
              .onClick(() => {
                this.currentCode = wordItem.code
                if (this.currentCode) {
                  this.showCodeSheet = true
                } else {
                  promptAction.showToast({ message: '暂无代码' })
                }
              })
            }
            .padding(16)
          }
        })
      }
      .divider({
        strokeWidth: $r('app.float.common_border_width'),
        color: $r('app.color.common_gray_bg')
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .bindSheet($$this.showCodeSheet, this.codeSheetBuilder, {
      detents: [SheetSize.FIT_CONTENT],
      backgroundColor: Color.White,
      title: { title: '详细代码' }
    })
  }
}
