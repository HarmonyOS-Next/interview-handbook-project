import { HdTag } from '@itcast/basic/Index'
import router from '@ohos.router'
import { InterviewItem, InterviewItemModel } from '../models/InterviewItemModel'

@Component
export struct InterviewDetailComp {
  @State
  show: boolean = false
  //
  item: InterviewItemModel = new InterviewItemModel({} as InterviewItem)
  //
  scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    this.item = new InterviewItemModel((router.getParams() || {}) as InterviewItem)
  }

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '取消点赞' })
      MenuItem({ content: '收藏' })
      MenuItem({ content: '分享' })
    }
    .radius(12)
    .width(108)
  }

  build() {
    Column() {
      // nav
      Row({ space: 16 }) {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .size({ width: 24, height: 24 })
          .onClick(() => router.back())
        Text(this.item.stem)
          .fontWeight(600)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontSize(18)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .opacity(this.show ? 1 : 0)
          .animation({ duration: 300 })
        Image($r('sys.media.ohos_ic_public_more'))
          .size({ width: 24, height: 20 })
          .objectFit(ImageFit.Contain)
          .bindMenu(this.menuBuilder())
      }
      .padding({ left: 16, right: 16 })
      .height(56)
      .width('100%')

      Scroll(this.scroller) {
        Column({ space: 16 }) {
          Text(this.item.stem)
            .fontWeight(600)
            .fontSize(18)

          Row({ space: 4 }) {
            Image(this.item.creatorAvatar)
              .width(36)
              .aspectRatio(1)
            Column({ space: 4 }) {
              Text(this.item.creatorName)
                .fontSize(14)
              Text() {
                Span('浏览 ' + this.item.views)
                Span(' · ')
                Span('点赞 ' + this.item.likeCount)
                Span(' · ')
                Span(this.item.createdAt)
              }
              .width('100%')
              .fontSize($r('app.float.common_font12'))
              .fontColor('#bdbdbd')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }

          Row({ space: 4 }) {
            ForEach(this.item.tags, (tag: string) => {
              HdTag({ text: tag })
            })
          }
          .width('100%')

          // con
          ForEach([1, 2, 3], () => {
            Text(this.item.content)
              .fontSize(14)
              .lineHeight(24)
          })

          // ref
          Row({ space: 4 }) {
            Text('相关题目：')
              .fontSize(14)
            Column({ space: 10 }) {
              ForEach([1, 2, 3, 4], () => {
                Row() {
                  Image($r('app.media.ic_interview_file'))
                    .size({ width: 14, height: 14 })
                    .fillColor($r('app.color.common_blue'))
                  Text(' Vue 生命周期总共分为几个阶段？')
                    .fontSize(12)
                    .fontColor($r('app.color.common_blue'))
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
                .width('100%')
              })
            }
            .layoutWeight(1)
          }
          .alignItems(VerticalAlign.Top)
          .padding(16)
          .backgroundColor($r('app.color.common_gray_bg'))
          .borderRadius(8)

          Text('© 著作权归作者所有')
            .fontSize(12)
            .fontColor($r('app.color.common_gray_01'))
            .height(60)
        }
        .padding({ left: 16, right: 16 })
      }
      .onScroll(() => {
        this.show = this.scroller.currentOffset().yOffset > 30
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}