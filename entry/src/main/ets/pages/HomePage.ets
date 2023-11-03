import { QuestionType, ResponseData } from '../models'
import { QuestionList } from '../components/QuestionList'
import { requestGet } from '../utils/request'
import router from '@ohos.router'
import { PAGE_MAP } from '../constants'
import logger from  '../utils/logger'

@Styles function pd15() {
  .padding({ left: 15, right: 15 })
}

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

  aboutToAppear() {
    requestGet('question/type').then((res: ResponseData<Array<QuestionType>>) => {
      this.questionTypes = res.data
      this.activeQuestionTypeId = this.questionTypes[this.activeIndex].id
    }).catch(err=>{
      logger.error('HomePage:aboutToAppear', JSON.stringify(err))
      AlertDialog.show({
        title: '温馨提示',
        message: '网络请求失败'
      })
    })
  }

  build() {
    Column() {
      Row() {
        Stack() {
          TextInput({ placeholder: '请输入关键词' })
            .placeholderColor($r('app.color.ih_gray_color'))
            .placeholderFont({ size: 14 })
            .padding({ left: 30 })
            .height(30)
          Image($r("app.media.icon_public_search"))
            .size({ width: 16, height: 16 })
            .margin({ left: 7 })
            .fillColor($r('app.color.ih_gray_color'))
        }
        .alignContent(Alignment.Start)
        .layoutWeight(1)

        Stack() {
          Image($r('app.media.unclock'))
            .size({ width: 80, height: 28 })
            .margin({ left: 12 })
          Text('打卡')
            .margin({ left: 36, bottom: 4 })
            .fontSize(18)
            .fontColor($r('app.color.ih_text_color'))
        }.onClick(() => {
          router.pushUrl({
            url: PAGE_MAP.login
          })
        })
      }.height(52).pd15()

      Row() {
        Swiper() {
          Flex(){
            Image($rawfile('banner_qa.png')).objectFit(ImageFit.Fill)
          }.pd15()
          Flex(){
            Image($rawfile('banner_pj.png')).objectFit(ImageFit.Fill)
          }.pd15()
          Flex(){
            Image($rawfile('banner_ai.png')).objectFit(ImageFit.Fill)
          }.pd15()
        }
        .autoPlay(true)
        .indicator(false)
      }.height(132)

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
        .barMode(BarMode.Scrollable).margin({ top: 4 })
        .onChange((index) => {
          this.activeIndex = index
          this.activeQuestionTypeId = this.questionTypes[this.activeIndex].id
        })
      }.layoutWeight(1)
    }
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}