import { QuestionType, ResponseData } from '../models'
import { QuestionList } from '../components/QuestionList'
import { Skeleton } from '../components/Skeleton'
import { ClockIn } from '../components/ClockIn'
import SearchWrapper from '../components/SearchWrapper'
import { requestGet } from '../utils/request'
import logger from '../utils/logger'
import { vp2vp } from '../utils/base'

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
          .fontSize(vp2vp(15))
          .height(vp2vp(44))
          .fontColor(this.activeIndex === index ? '#121826' : $r('app.color.ih_gray_color'))
        Text()
          .width(this.activeIndex === index ? vp2vp(20) : 0)
          .height(vp2vp(2))
          .backgroundColor('#121826')
          .animation({ duration: this.activeIndex === index ? 200 : 0 })
      }.alignContent(Alignment.Bottom)

      if (item.displayNewestFlag === 1) {
        Image($r('app.media.new'))
          .width(vp2vp(34))
          .height(vp2vp(14))
          .margin({ left: vp2vp(4) })
      }
    }
    .padding({ left: index === 0 ? vp2vp(15) : vp2vp(10), right: index === this.questionTypes.length - 1 ? vp2vp(54) : vp2vp(10) })
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
          Skeleton({ w: vp2vp(50) + item % 3 * vp2vp(10) }).margin({ right: vp2vp(10) })
        })
      }
      .height(vp2vp(60))
      .width('100%')
      .justifyContent(FlexAlign.Start)

      List() {
        ForEach([1, 2, 3, 4, 5, 6], () => {
          ListItem() {
            Column() {
              Row() {
                Skeleton({ w: vp2vp(40) }).margin({ right: vp2vp(10) })
                Skeleton({ w: '100%' }).layoutWeight(1)
              }
              .width('100%')
              .margin({ bottom: vp2vp(10) })

              Skeleton({ w: vp2vp(120) })
            }.alignItems(HorizontalAlign.Start)
          }
          .height(vp2vp(80))
        })
      }
      .width('100%')
      .height('100%')
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.ih_bg_color')
      })
    }
    .padding({ left: vp2vp(15), right: vp2vp(15) })
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
        .margin({ right: vp2vp(5) })

        ClockIn()
      }.padding(vp2vp(15))

      Row() {
        Swiper() {
          Flex() {
            Image($rawfile('banner_qa.png')).objectFit(ImageFit.Fill)
          }.padding({ left: vp2vp(15), right: vp2vp(15) })

          Flex() {
            Image($rawfile('banner_pj.png')).objectFit(ImageFit.Fill)
          }.padding({ left: vp2vp(15), right: vp2vp(15) })

          Flex() {
            Image($rawfile('banner_ai.png')).objectFit(ImageFit.Fill)
          }.padding({ left: vp2vp(15), right: vp2vp(15) })
        }
        .autoPlay(true)
        .indicator(false)
      }
      .aspectRatio(2.8)

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
          .margin({ top: vp2vp(4) })
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