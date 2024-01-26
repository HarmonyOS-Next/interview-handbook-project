import { BasicConstant, HdClockIn, HdSearch } from '@itcast/basic'
import { HomeCategoryComp } from '../components/HomeCategoryComp'
import { HomeDayQuestionComp } from '../components/HomeDayQuestionComp'
import { HomeQuestionCardComp } from '../components/HomeQuestionCardComp'
import { router } from '@kit.ArkUI'

@Component
export struct HomeComp {
  @StorageProp('topHeight')
  topHeight: number = 0

  @Builder
  SwiperItemBuilder(src: ResourceStr) {
    Flex() {
      Image(src)
        .objectFit(ImageFit.Fill)
    }
    .padding({ left: BasicConstant.SPACE_LG, right: BasicConstant.SPACE_LG })
    .aspectRatio(2.8)
  }

  build() {
    Scroll() {
      Column() {
        Row({ space: BasicConstant.SPACE_LG }) {
          HdSearch()
          HdClockIn({ clockCount: 10 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ClockedPage'
              })
            })
        }
        .padding($r('app.float.common_gutter'))

        Row() {
          Swiper() {
            this.SwiperItemBuilder($r('app.media.banner_qa'))
            this.SwiperItemBuilder($r('app.media.banner_pj'))
            this.SwiperItemBuilder($r('app.media.banner_ai'))
          }
          .autoPlay(true)
          .indicator(DotIndicator.dot()
            .selectedColor(Color.White)
            .bottom(BasicConstant.SPACE_SM)
            .itemHeight(BasicConstant.SPACE_SM)
            .selectedItemHeight(BasicConstant.SPACE_SM)
            .itemWidth(BasicConstant.SPACE_MD)
            .selectedItemWidth(BasicConstant.SPACE_MD))
        }

        HomeDayQuestionComp()

        Text('热门题库')
          .width('100%')
          .fontWeight(500)
          .padding({ left: BasicConstant.SPACE_LG, bottom: BasicConstant.SPACE_MD })
        Scroll() {
          Row({ space: BasicConstant.SPACE_MD }) {
            HomeQuestionCardComp({ linearColor: 0, title: '鸿蒙NEXT', subTitle: '面通热门题单' })
            HomeQuestionCardComp({ linearColor: 1, title: '企业题库', subTitle: '2000+ 企业面试题' })
            HomeQuestionCardComp({ linearColor: 2, title: '程序员面试经典', subTitle: '独家授权' })
            HomeQuestionCardComp({ linearColor: 3, title: '前端题单', subTitle: '面通热门题单' })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .padding({ left: 16, right: 16, bottom: 12 })
        .edgeEffect(EdgeEffect.Spring)

        HomeCategoryComp()
      }
      .backgroundColor($r('app.color.common_gray_bg'))
      .alignItems(HorizontalAlign.Start)
      .padding({ top: this.topHeight })
    }
    .width('100%')
    .scrollBar(BarState.Off)
  }
}