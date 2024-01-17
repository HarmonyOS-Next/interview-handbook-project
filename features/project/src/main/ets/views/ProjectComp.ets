import { BasicConstant, HdTag } from '@itcast/basic'
import { ProjectItemData, ProjectItemModel } from '../models/ProjectItemModel'
import router from '@ohos.router'

@Component
export struct ProjectComp {
  list: ProjectItemModel[] = ProjectItemData

  @Builder
  ProjectItemBuilder(item: ProjectItemModel) {
    Row({ space: BasicConstant.SPACE_MD }) {
      Image(item.icon)
        .size({ width: 60, height: 80 })
        .sharedTransition(item.id.toString(), { duration: 300 })
      Column({ space: BasicConstant.SPACE_SM }) {
        Text(item.name)
          .fontWeight(500)
        Text(item.describeInfo)
          .fontSize($r('app.float.common_font12'))
          .fontColor($r('app.color.common_gray_02'))
        Blank()
        Row() {
          ForEach(item.tags, (tag: string) => {
            HdTag({ text: tag })
          })
        }
      }
      .layoutWeight(1)
      .height(80)
      .alignItems(HorizontalAlign.Start)
    }
    .padding({
      top: $r('app.float.common_gutter'),
      bottom: $r('app.float.common_gutter')
    })
    .alignItems(VerticalAlign.Top)
    .onClick(() => {
      router.pushUrl({ url: 'pages/ProjectDetailPage', params: item })
    })
  }

  build() {
    Column() {
      Text('项目')
        .height(44)
        .width('100%')
        .fontWeight(500)
        .textAlign(TextAlign.Center)
        .border({
          width: { bottom: $r('app.float.common_border_width') },
          color: $r('app.color.common_gray_border')
        })

      List() {
        ForEach(this.list, (item: ProjectItemModel) => {
          ListItem() {
            this.ProjectItemBuilder(item)
          }
        })
      }
      .divider({
        strokeWidth: $r('app.float.common_border_width'),
        color: $r('app.color.common_gray_border')
      })
      .padding({
        left: $r('app.float.common_gutter'),
        right: $r('app.float.common_gutter')
      })

      Blank()

      Stack() {
        Text()
          .width('100%')
          .height($r('app.float.common_border_width'))
          .backgroundColor($r('app.color.common_gray_01'))
        Text('其他项目正在赶来的路上…')
          .padding($r('app.float.common_space10'))
          .backgroundColor(Color.White)
          .fontColor($r('app.color.common_gray_01'))
          .fontSize($r('app.float.common_font12'))
      }
      .width('80%')
      .padding($r('app.float.common_gutter'))
    }
    .width('100%')
    .height('100%')
  }
}