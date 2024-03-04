import { QuestionTypeModel } from '../models/QuestionTypeModel'

@Component
struct FilterButton {
  @Prop
  isActive: boolean = false
  @Prop
  sortValue: number = 0
  @State
  positionX: number = 0
  text: string = ''
  isNew: boolean = false
  isSort: Boolean = false

  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: 6 }) {
        Text(this.text)
          .fontSize(12)
          .fontColor(this.isActive ? $r('app.color.common_main_color') : $r('app.color.black'))
        if (this.isNew) {
          Image($r('app.media.ic_home_new'))
            .width(32)
            .height(14)
            .objectFit(ImageFit.Contain)
            .alignSelf(ItemAlign.Start)
            .position({ x: this.positionX, y: -5 })
        }
        if (this.isSort) {
          Column() {
            Image($r('sys.media.ohos_ic_public_arrow_up'))
              .size({ width: 12, height: 6 })
              .fillColor(this.sortValue === 20 ? $r('app.color.common_main_color') : Color.Black)
            Image($r('sys.media.ohos_ic_public_arrow_down'))
              .size({ width: 12, height: 6 })
              .fillColor(this.sortValue === 21 ? $r('app.color.common_main_color') : Color.Black)
          }
        }
      }
      .height(30)
      .padding({ left: 10, right: 10 })
      .onAreaChange((_old, now) => {
        this.positionX = Number(now.width) - 24
      })
    }
    .borderRadius(4)
    .padding(0)
    .margin({ right: this.isNew ? 20 : 10, bottom: 10 })
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}

export class FilterParams {
  // 排序：0 默认 20 浏览量↑ 21 浏览量↓
  sort: number = 0
  // 难度：0 全部 1 简单 2 一般 3 困难
  difficult: number = 0
  // 阶段ID
  index: number = 0
}


@Component
export struct QuestionFilterComp {
  // controller: CustomDialogController
  @Prop
  questionTypeList: QuestionTypeModel[] = []
  @Prop
  params: FilterParams = new FilterParams()
  // onSubmit
  onSubmit: (params: FilterParams) => void = () => {
  }

  @Builder
  TitleBuilder(title: string) {
    Text(title)
      .padding({ top: 10, bottom: 10 })
      .fontSize(14)
      .fontWeight(500)
  }

  build() {
    Column() {
      Row() {
        Text('重置')
          .fontWeight(500)
          .onClick(() => {
            this.params = new FilterParams()
          })
        Text('筛选题目')
          .fontWeight(500)
          .fontSize(18)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('完成')
          .fontWeight(500)
          .fontColor($r('app.color.common_main_color'))
          .onClick(() => {
            this.onSubmit(this.params)
            // this.controller.close()
          })
      }
      .width('100%')
      .height(50)

      this.TitleBuilder('题目排序')
      Flex() {
        FilterButton({ text: '默认', isActive: this.params.sort === 0 })
          .onClick(() => this.params.sort = 0)
        FilterButton({ text: '浏览量', isSort: true, isActive: this.params.sort > 0, sortValue: this.params.sort })
          .onClick(() => {
            if (this.params.sort) {
              this.params.sort = this.params.sort === 21 ? 20 : 21
            } else {
              this.params.sort = 21
            }
          })
      }

      this.TitleBuilder('题目难度')
      Flex() {
        ForEach(['全部', '简单', '一般', '困难'], (item: string, index: number) => {
          FilterButton({ text: item, isActive: this.params.difficult === index })
            .onClick(() => this.params.difficult = index)
        })
      }

      this.TitleBuilder('选择阶段')
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.questionTypeList, (item: QuestionTypeModel, index: number) => {
          FilterButton({ text: item.name, isNew: item.displayNewestFlag === 1, isActive: this.params.index === index })
            .onClick(() => this.params.index = index)
        })
      }

    }
    .padding({ left: 16, right: 16, top: 8, bottom: 34 })
    .width('100%')
    .alignItems(HorizontalAlign.Start)

    // .transition(TransitionEffect.move(TransitionEdge.BOTTOM)
    //   .animation({ duration: 300, curve: curves.springMotion(0.6, 0.8) }))
  }
}