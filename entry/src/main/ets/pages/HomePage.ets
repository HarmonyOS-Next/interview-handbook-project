import { QuestionType, ResponseData } from '../models'
import { QuestionList } from '../components/QuestionList'
import { Skeleton } from '../components/Skeleton'
import { ClockIn } from '../components/ClockIn'
import SearchWrapper from '../components/SearchWrapper'
import { requestGet } from '../utils/request'
import logger from '../utils/logger'

@Preview
@Component
export struct HomePage {
  @State
  questionTypes: Array<QuestionType> = [
  //   { id: 1, name: '前端基础' },
  //   { id: 2, name: '移动web' },
  //   { id: 3, name: 'JS基础', displayNewestFlag: 1 },
  //   { id: 4, name: 'WebAPI' },
  //   { id: 5, name: 'Ajax' },
  //   { id: 6, name: 'Git' },
  //   { id: 7, name: '数据可视化' },
  //   { id: 8, name: 'Node.js' },
  //   { id: 9, name: 'Vue2' },
  //   { id: 10, name: 'Vue3' },
  //   { id: 11, name: '小程序' },
  //   { id: 12, name: 'uni-app' },
  //   { id: 13, name: 'TypeScript' },
  //   { id: 14, name: 'React' }
  ]
  @State
  activeIndex: number = 0
  @State
  activeQuestionTypeId: number = -1
  @State
  clockInCount: number = 0

  aboutToAppear() {
    requestGet('question/type').then((res: ResponseData<Array<QuestionType>>) => {
      this.questionTypes = res.data
      this.activeQuestionTypeId = this.questionTypes[this.activeIndex].id
    }).catch(err => {
      logger.error('HomePage:aboutToAppear', JSON.stringify(err))
      AlertDialog.show({
        title: '温馨提示',
        message: '网络请求失败'
      })
    })

  }

  @Builder
  TabHeadBuilder(item: QuestionType, index: number) {
    Row() {
      Stack() {
        Text(item.name)
          .fontSize(15)
          .height(44)
          .fontColor(this.activeIndex === index ? '#121826' : $r('app.color.ih_gray_color'))
        Text()
          .width(this.activeIndex === index ? 20 : 0)
          .height(2)
          .backgroundColor('#121826')
          .animation({ duration: this.activeIndex === index ? 200 : 0 })
      }.alignContent(Alignment.Bottom)

      if (item.displayNewestFlag === 1) {
        Image($r('app.media.new'))
          .width(34)
          .height(14)
          .margin({ left: 4 })
      }
    }
    .padding({ left: index === 0 ? 15 : 10, right: index === this.questionTypes.length - 1 ? 54 : 10 })
    .onClick(() => {
      this.activeIndex = index
      this.activeQuestionTypeId = this.questionTypes[index].id
    })
  }

  @Builder
  skeletonBuilder() {
    Column() {
      Row() {
        ForEach([1, 2, 3, 4], (item) => {
          Skeleton({ w: 50 + item % 3 * 10 }).margin({ right: 10 })
        })
      }
      .height(60)
      .width('100%')
      .justifyContent(FlexAlign.Start)

      List() {
        ForEach([1, 2, 3, 4, 5, 6], () => {
          ListItem() {
            Column() {
              Row() {
                Skeleton({ w: 40 }).margin({ right: 10 })
                Skeleton({ w: '100%' }).layoutWeight(1)
              }
              .width('100%')
              .margin({ bottom: 10 })

              Skeleton({ w: 120 })
            }.alignItems(HorizontalAlign.Start)
          }
          .height(80)
        })
      }
      .width('100%')
      .height('100%')
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.ih_bg_color')
      })
    }
    .padding({ left: 15, right: 15 })
    .layoutWeight(1)
    .justifyContent(FlexAlign.Start)
  }

  build() {
    Column() {
      Row() {
        Row() {
          SearchWrapper()
        }
        .layoutWeight(1)
        .margin({ right: 5 })

        ClockIn()
      }.padding(15)

      Row() {
        Swiper() {
          Flex() {
            Image($rawfile('banner_qa.png')).objectFit(ImageFit.Fill)
          }.padding({ left: 15, right: 15 })

          Flex() {
            Image($rawfile('banner_pj.png')).objectFit(ImageFit.Fill)
          }.padding({ left: 15, right: 15 })

          Flex() {
            Image($rawfile('banner_ai.png')).objectFit(ImageFit.Fill)
          }.padding({ left: 15, right: 15 })
        }
        .autoPlay(true)
        .indicator(false)
      }.height(132)

      if (this.questionTypes.length) {
        Row() {
          Tabs({
            index: this.activeIndex
          }) {
            ForEach(this.questionTypes, (item, index) => {
              TabContent() {
                QuestionList({
                  questionTypeId: item.id,
                  activeQuestionTypeId: this.activeQuestionTypeId
                })
              }.tabBar(this.TabHeadBuilder(item, index)).height('100%')
            })
          }
          .barMode(BarMode.Scrollable)
          .margin({ top: 4 })
          .onChange((index) => {
            this.activeIndex = index
            this.activeQuestionTypeId = this.questionTypes[this.activeIndex].id
          })
        }.layoutWeight(1)
      } else {
        this.skeletonBuilder()
      }
    }
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}