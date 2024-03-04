import { authStore, BasicConstant, HdSearch } from '@itcast/basic'
import { QuestionListComp } from '@itcast/home'
import { ProjectItem, ProjectItemModel } from '../models/ProjectItemModel'
import router from '@ohos.router'

@Component
export struct ProjectDetailComp {
  @StorageProp('topHeight')
  topHeight: number = 0
  // 0 默认 21 降序 20 升序
  @State
  sort: number = 0
  @State
  projectItem: ProjectItemModel = new ProjectItemModel({} as ProjectItem)
  // 可选排序
  sortArr: number[] = [0, 21, 20]

  aboutToAppear(): void {
    this.projectItem = router.getParams() as ProjectItemModel
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        Image($r('app.media.project_bg'))
          .width('100%')
          .height(236 + this.topHeight)
          .opacity(0.2)
        Column() {
          Row() {
            Image($r('app.media.ic_common_back'))
              .size({ width: 24, height: 24 })
              .fillColor($r('app.color.common_gray_01'))
              .onClick(() => router.back())
            Blank()
            HdSearch({ bg: 'rgba(246, 247, 249, 0.5)', color: '#333333' })
              .width(120)
              .onClick(() => {
                interface Params {
                  type: number
                  questionBankType: 9 | 10
                }

                authStore.checkAuth({
                  url: 'pages/SearchPage',
                  params: ({ questionBankType: 10, type: this.projectItem.id }) as Params
                })
              })
          }
          .height(56)
          .width('100%')

          Row({ space: BasicConstant.SPACE_LG }) {
            Image(this.projectItem.icon)
              .width(86)
              .height(114)
              .sharedTransition(this.projectItem.id.toString(), { duration: 300 })
            Column({ space: BasicConstant.SPACE_LG }) {
              Text(this.projectItem.name)
                .fontWeight(500)
                .fontColor(Color.White)
              Text(this.projectItem.describeInfo)
                .fontSize($r('app.float.common_font14'))
                .fontColor(Color.White)
              Blank()
              Text('学习进度：10%')
                .fontColor($r('app.color.common_gray_01'))
                .fontSize($r('app.float.common_font14'))
            }
            .layoutWeight(1)
            .height(114)
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ top: 20 })
          .alignItems(VerticalAlign.Top)
          .width('100%')
        }
        .padding({ left: $r('app.float.common_space16'), right: $r('app.float.common_space16'), top: this.topHeight })
      }
      .height(210 + this.topHeight)

      Column() {
        Row({ space: BasicConstant.SPACE_MD }) {
          Text('问题列表')
            .fontWeight(500)
          Blank()
          Row() {
            Text('浏览量')
              .fontSize($r('app.float.common_font14'))
              .fontColor(this.sort > 0 ? $r('app.color.common_main_color') : $r('app.color.black'))
            Column() {
              Image($r('sys.media.ohos_ic_public_arrow_up'))
                .size({ width: 16, height: 6 })
                .fillColor(this.sort === 20 ? $r('app.color.common_main_color') : $r('app.color.black'))
              Image($r('sys.media.ohos_ic_public_arrow_down'))
                .size({ width: 16, height: 6 })
                .fillColor(this.sort === 21 ? $r('app.color.common_main_color') : $r('app.color.black'))
            }
            .alignItems(HorizontalAlign.Start)
          }
          .onClick(() => {
            const index = this.sortArr.findIndex(i => i === this.sort)
            this.sort = this.sortArr[(index + 1) % this.sortArr.length]
          })
        }
        .height(44)
        .width('100%')
        .padding({ left: $r('app.float.common_space16'), right: $r('app.float.common_space16') })
        .border({
          width: { bottom: $r('app.float.common_border_width') },
          color: $r('app.color.common_gray_border')
        })

        Column() {
          QuestionListComp({
            typeId: this.projectItem.id,
            sort: this.sort
          })
        }
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .backgroundColor($r('app.color.white'))
      .width('100%')
      .borderRadius({ topLeft: 16, topRight: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#5D2B05')
  }
}