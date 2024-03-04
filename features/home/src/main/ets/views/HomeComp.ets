import { authStore, BasicConstant, HdClockIn, hdHttp, HdSearch, HdUser } from '@itcast/basic'
import { HomeCategoryComp } from '../components/HomeCategoryComp'
import { HomeDayQuestionComp } from '../components/HomeDayQuestionComp'
import { HomeQuestionCardComp } from '../components/HomeQuestionCardComp'
import { promptAction, router } from '@kit.ArkUI'

@Component
export struct HomeComp {
  @StorageProp('topHeight')
  topHeight: number = 0
  @StorageProp('user')
  user: HdUser = {} as HdUser
  scroller = new Scroller()
  @State
  isVisible: boolean = false
  @State
  opacityValue: number = 0
  @State
  areaHeight: number = 0

  @Builder
  SwiperItemBuilder(src: ResourceStr) {
    Flex() {
      Image(src)
        .objectFit(ImageFit.Fill)
    }
    .padding({ left: BasicConstant.SPACE_LG, right: BasicConstant.SPACE_LG })
    .aspectRatio(2.8)
  }

  scrollStatusBar(y: number) {
    if (y < this.areaHeight) {
      this.opacityValue = y / this.areaHeight
    } else {
      this.opacityValue = 1
    }
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Row()
        .height(this.topHeight)
        .width('100%')
        .backgroundColor($r('app.color.white'))
        .opacity(this.opacityValue)
        .zIndex(1)
      Scroll(this.scroller) {
        Column() {
          Column() {

            Row({ space: BasicConstant.SPACE_LG }) {
              HdSearch()
                .layoutWeight(1)
                .onClick(() => {
                  interface Params {
                    questionBankType: 9 | 10
                  }

                  authStore.checkAuth({
                    url: 'pages/SearchPage',
                    params: ({ questionBankType: 10 }) as Params
                  })
                })
              HdClockIn({ clockCount: this.user.clockinNumbers })
                .onClick(() => {
                  if (this.user?.token) {
                    if (this.user.clockinNumbers) {
                      router.pushUrl({ url: 'pages/ClockedPage' })
                    } else {
                      // 打卡
                      hdHttp.post<Record<string, number>>('clockin').then(async (res) => {
                        promptAction.showToast({ message: '打卡成功' })
                        this.user.clockinNumbers = res.data.clockinNumbers
                        await authStore.setUser(this.user)
                        router.pushUrl({ url: 'pages/ClockedPage' })
                      })
                    }
                  } else {
                    router.pushUrl({ url: 'pages/LoginPage' })
                  }
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
          }
          .onAreaChange((_o, n) => {
            this.areaHeight = n.height as number
          })

          HomeCategoryComp()
        }
        .backgroundColor($r('app.color.common_gray_bg'))
        .alignItems(HorizontalAlign.Start)
        .padding({ top: this.topHeight })
      }
      .width('100%')
      .scrollBar(BarState.Off)
      .onScroll(() => {
        // if (this.isVisible) {
        //   windowManager.scrollStatusBar(this.scroller.currentOffset().yOffset)
        // }
        this.scrollStatusBar(this.scroller.currentOffset().yOffset)
      })

      // .onVisibleAreaChange([0, 1], (isVisible) => {
      //   this.isVisible = isVisible
      //   windowManager.scrollStatusBar(isVisible ? this.scroller.currentOffset().yOffset : 0)
      // })
    }
    .height('100%')
    .backgroundColor($r('app.color.white'))
  }
}