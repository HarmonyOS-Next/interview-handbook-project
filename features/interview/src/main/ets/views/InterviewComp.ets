import { authStore, HdSearch } from '@itcast/basic'
import { InterviewListComp } from '../components/InterviewListComp'

interface Company {
  icon: ResourceStr
  count: number
}

interface TabItem {
  name: string
  value?: number
  onAreaChange?: (area: Area) => void
}

@Component
export struct InterviewComp {
  @State
  left: number = 16
  @State
  sort: number | undefined = 30
  @StorageProp('topHeight')
  topHeight: number = 0

  setLineLeft(area: Area) {
    const width = area.width as number
    const x = area.position.x as number
    this.left = x + (width - 16) / 2
  }

  @Builder
  companyBuilder(com: Company) {
    Column({ space: 12 }) {
      Image(com.icon)
        .width(36)
        .aspectRatio(1)
        .margin({ top: 20 })
        .objectFit(ImageFit.Contain)
      Text() {
        Span('热门指数')
        Span(`${com.count}K`)
          .fontColor($r('app.color.common_green'))
      }
      .fontSize(13)
      .fontColor($r('app.color.common_gray_01'))

      Button({ type: ButtonType.Normal }) {
        Text('查看')
          .fontSize(14)
      }
      .backgroundColor($r('app.color.common_gray_bg'))
      .padding(0)
      .height(30)
      .width(80)
      .borderRadius(8)

    }
    .backgroundColor($r('app.color.white'))
    .borderRadius(8)
    .height(140)
    .width(100)
  }

  @Builder
  tabBuilder(tab: TabItem) {
    Text(tab.name)
      .fontSize(14)
      .padding(10)
      .fontColor(this.sort === tab.value ? $r('app.color.black') : $r('app.color.common_gray_01'))
      .animation({
        duration: 300
      })
      .onClick((e) => {
        this.setLineLeft(e.target.area)
        this.sort = tab.value
      })
      .onAreaChange((_o, n) => tab.onAreaChange && tab.onAreaChange(n))
  }

  build() {
    Column() {
      Row({ space: 16 }) {
        Image($r('app.media.ic_interview_text'))
          .width(54)
          .height(20)
        HdSearch({ ph: '请输入关键词', bg: $r('app.color.common_gray_bg') })
          .layoutWeight(1)
          .onClick(() => {
            interface Params {
              questionBankType: 9 | 10
            }

            authStore.checkAuth({
              url: 'pages/SearchPage',
              params: ({ questionBankType: 9 }) as Params
            })
          })
      }
      .padding({ left: 16, right: 16 })
      .height(64)
      .margin({ top: this.topHeight })

      // 热门企业
      Scroll() {
        Row({ space: 10 }) {
          this.companyBuilder({ icon: $r('app.media.ic_company_hw'), count: 1.5 })
          this.companyBuilder({ icon: $r('app.media.ic_company_wr'), count: 2.9 })
          this.companyBuilder({ icon: $r('app.media.ic_company_gg'), count: 3.1 })
          this.companyBuilder({ icon: $r('app.media.ic_company_zj'), count: 5.3 })
          this.companyBuilder({ icon: $r('app.media.ic_company_wy'), count: 3.6 })
        }
      }
      .width('100%')
      .height(160)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .padding(10)

      .edgeEffect(EdgeEffect.Spring)
      .backgroundColor($r('app.color.common_gray_bg'))

      // 标签页
      Row() {
        Row() {
          this.tabBuilder({
            name: '推荐', value: 30,
            onAreaChange: (area) => {
              this.setLineLeft(area)
            }
          })
          this.tabBuilder({ name: '最新' })
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .height(40)
        .border({
          width: { bottom: $r('app.float.common_border_width') },
          color: $r('app.color.common_gray_border')
        })

        Text()
          .width(16)
          .height(2)
          .backgroundColor($r('app.color.black'))
          .position({ x: this.left, y: 38 })
          .animation({
            duration: 300
          })
      }

      // 文章列表
      InterviewListComp({ sort: this.sort })
    }
    .width('100%')
    .height('100%')
  }
}