import { QuestionTypeModel } from '../models/QuestionTypeModel'
import { QuestionListComp } from './QuestionListComp'
import { FilterParams, QuestionFilterComp } from './QuestionFilterComp'
import { QuestionService } from '../services/QuestionService'


@Component
export struct HomeCategoryComp {
  @State
  params: FilterParams = new FilterParams()
  @State
  questionTypeList: QuestionTypeModel[] = []
  @State
  barWidth: number = 0
  @State
  show: boolean = false

  // dialog: CustomDialogController = new CustomDialogController({
  //   builder: QuestionFilterComp({
  //     questionTypeList: this.questionTypeList,
  //     params: this.params,
  //     onSubmit: (params) => {
  //       this.params = params
  //     }
  //   }),
  //   customStyle: true,
  //   alignment: DialogAlignment.Bottom,
  //   openAnimation: {
  //     duration: 0
  //   }
  // })

  aboutToAppear(): void {
    QuestionService.findQuestionTypeList().then(res => {
      this.questionTypeList = res.data
    })
  }

  @Builder
  SheetBuilder() {
    Column() {
      QuestionFilterComp({
        questionTypeList: this.questionTypeList,
        params: this.params,
        onSubmit: (params) => {
          this.params = params
          this.show = false
        }
      })
    }
  }

  @Builder
  TabItemBuilder(q: QuestionTypeModel, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(q.name)
          .fontSize(15)
          .height(43)
          .fontColor(this.params.index === index ? Color.Black : Color.Gray)
        Text()
          .width(this.params.index === index ? 20 : 0)
          .height(2)
          .backgroundColor(Color.Black)
          .animation({ duration: this.params.index === index ? 300 : 0 })
      }
      .padding({ left: index === 0 ? 16 : 0, })

      if (q.displayNewestFlag === 1) {
        Image($r("app.media.ic_home_new"))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .margin({ left: 4 })
      }
    }
    .padding({ right: this.questionTypeList.length === index + 1 ? 54 : 16 })
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Tabs({ index: this.params.index }) {
        ForEach(this.questionTypeList, (item: QuestionTypeModel, index: number) => {
          TabContent() {
            // 列表组件
            Column() {
              QuestionListComp({
                typeId: item.id,
                sort: this.params.sort,
                difficult: this.params.difficult,
                activeIndex: this.params.index,
                selfIndex: index
              })
            }
            .backgroundColor(Color.White)
          }
          .tabBar(this.TabItemBuilder(item, index))
        })
      }
      .divider({ strokeWidth: $r('app.float.common_border_width'), color: $r('app.color.common_gray_border') })
      .barMode(BarMode.Scrollable)
      .barHeight(44)
      .barBackgroundColor(Color.White)
      .onChange(i => this.params.index = i)
      .layoutWeight(1)

      Row() {
        Image($r("app.media.ic_home_filter"))
          .width(22)
          .height(44)
          .objectFit(ImageFit.Contain)
      }
      .width(54)
      .height(44)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        angle: 90,
        colors: [['rgba(255,255,255,0.2)', 0], [Color.White, 0.3]]
      })
      .onClick(() => {
        this.show = !this.show
      })
      .bindSheet(this.show, this.SheetBuilder(), {
        height: 420,
        dragBar: false,
        maskColor: '#66000000',
        showClose: false,
      })

      // .onClick(() => {
      //   this.dialog.open()
      // })
    }
  }
}