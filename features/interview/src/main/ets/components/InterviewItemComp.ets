import { authStore, BasicConstant, HdTag } from '@itcast/basic'
import { InterviewItem, InterviewItemModel } from '../models/InterviewItemModel'

@Component
export struct InterviewItemComp {
  item: InterviewItemModel = new InterviewItemModel({} as InterviewItem)

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '屏蔽' }).width(64)
      MenuItem({ content: '举报' }).width(64)
    }
    .radius(12)
  }

  build() {
    Column({ space: 12 }) {
      Row({ space: BasicConstant.SPACE_MD }) {
        Image(this.item.creatorAvatar)
          .width(36)
          .aspectRatio(1)
        Column({ space: BasicConstant.SPACE_SM }) {
          Text(this.item.stem)
            .fontWeight(600)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text() {
            Span(this.item.creatorName)
            Span(' · ')
            Span(this.item.createdAt)
          }
          .fontSize($r('app.float.common_font10'))
          .fontColor('#bdbdbd')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Image($r('app.media.ic_interview_more'))
          .width(20)
          .aspectRatio(1)
          .alignSelf(ItemAlign.Start)
          .bindMenu(this.menuBuilder())
      }

      Text(this.item.content)
        .fontSize($r('app.float.common_font14'))
        .fontColor($r('app.color.common_gray_03'))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .lineHeight(20)
        .width('100%')

      Row({ space: BasicConstant.SPACE_SM }) {
        ForEach(['大厂', '面经'], (tag: string) => {
          HdTag({ text: tag })
        })
      }
      .width('100%')

      Text() {
        Span('点赞 ' + this.item.likeCount)
        Span(' · ')
        Span('浏览 ' + this.item.views)
        if (this.item.likeFlag === 1) {
          Span(' · ')
          Span('已点赞')
        }
      }
      .width('100%')
      .fontSize($r('app.float.common_font12'))
      .fontColor('#bdbdbd')
    }
    .padding({ top: 16, bottom: 16 })
    .onClick(() => {
      authStore.checkAuth({ url: 'pages/InterviewDetailPage', params: this.item })
    })
  }
}