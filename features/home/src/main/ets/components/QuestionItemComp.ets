import { HdTag } from '@itcast/basic'
import { QuestionItem, QuestionItemModel } from '../models/QuestionItemModel'

@Component
export struct QuestionItemComp {
  item: QuestionItemModel = {} as QuestionItem
  onClickItem: () => void = () => {
  }

  @Builder
  SplitBuilder() {
    Text('|')
      .width(30)
      .textAlign(TextAlign.Center)
      .fontColor($r('app.color.common_gray_01'))
      .fontSize(13)
  }

  @Builder
  TextBuilder(text: string) {
    Text(text)
      .fontColor($r('app.color.common_gray_01'))
      .fontSize(13)
  }

  build() {
    Column() {
      Row({ space: 5 }) {
        HdTag({ difficulty: this.item.difficulty })
        Text(this.item.stem)
          .fontSize(15)
          .layoutWeight(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(500)
      }.width('100%')

      Row() {
        this.TextBuilder(`点赞 ${this.item.likeCount}`)
        this.SplitBuilder()
        this.TextBuilder(`浏览 ${this.item.views}`)
        if (this.item.readFlag === 1) {
          this.SplitBuilder()
          this.TextBuilder(`已看过`)
        }
      }
      .width('100%')
      .margin({ top: 10 })
    }
    .height(80)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .onClick(e => {
      this.onClickItem()
    })
  }
}