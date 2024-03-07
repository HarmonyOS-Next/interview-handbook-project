import { QuestionTypeModel } from '../models/QuestionTypeModel'
import { QuestionListComp } from './QuestionListComp'
import { FilterParams, QuestionFilterComp } from './QuestionFilterComp'
import { QuestionService } from '../services/QuestionService'
import { emitter } from '@kit.BasicServicesKit'
import { ConfigurationConstant } from '@kit.AbilityKit'
import { HdSkeleton } from '@itcast/basic/Index'


@Component
export struct HomeCategoryComp {
  @StorageProp('colorMode')
  colorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET
  @State
  params: FilterParams = new FilterParams()
  @State
  questionTypeList: QuestionTypeModel[] = []
  @State
  barWidth: number = 0
  @State
  show: boolean = false

  aboutToAppear(): void {
    QuestionService.findQuestionTypeList().then(res => {
      this.questionTypeList = res.data
    })
    emitter.on({ eventId: 100401 }, () => {
      this.questionTypeList = []
      QuestionService.findQuestionTypeList().then(res => {
        this.questionTypeList = res.data
      })
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
          .fontColor(this.params.index === index ? $r('app.color.black') : $r('app.color.common_gray_01'))
        Text()
          .width(this.params.index === index ? 20 : 0)
          .height(2)
          .backgroundColor($r('app.color.black'))
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
      if (this.questionTypeList.length) {
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
              .backgroundColor($r('app.color.white'))
            }
            .tabBar(this.TabItemBuilder(item, index))
          })
        }
        .divider({ strokeWidth: $r('app.float.common_border_width'), color: $r('app.color.common_gray_border') })
        .barMode(BarMode.Scrollable)
        .barHeight(44)
        .barBackgroundColor($r('app.color.white'))
        .onTabBarClick(i => this.params.index = i)
        .layoutWeight(1)
        .scrollable(false)
      } else {
        Column({ space: 30 }) {
          HdSkeleton().width('100%')
          HdSkeleton({ rows: 2 }).width('100%')
          HdSkeleton({ rows: 2 }).width('100%')
          HdSkeleton({ rows: 2 }).width('100%')
        }
        .padding(15)
      }

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
        colors: [
          [this.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK ? 'rgba(0,0,0,0.2)' : 'rgba(255,255,255,0.2)', 0],
          [$r('app.color.white'), 0.3]
        ]
      })
      .onClick(() => {
        this.show = true
      })
      .bindSheet($$this.show, this.SheetBuilder(), {
        showClose: false,
        dragBar: false,
        detents: [SheetSize.FIT_CONTENT],
        backgroundColor: $r('app.color.white'),
      })
    }
    .width('100%')
    .backgroundColor($r('app.color.white'))
  }
}