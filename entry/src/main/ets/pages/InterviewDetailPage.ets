import router from '@ohos.router'
import { DetailRichText } from '../components/DetailRichText'
import { InterviewItem } from '../models'
import { vp2vp } from '../utils/base'
import logger from '../utils/logger'
import { requestGet, requestPost } from '../utils/request'

@Entry
@Component
struct InterviewDetailPage {
  @State
  interview: InterviewItem = undefined
  @State
  loading: boolean = true

  aboutToAppear() {
    const params = router.getParams()
    this.interview = params as InterviewItem

    this.loading = true
    requestGet<{ content: string }>(`question/${this.interview.id}`)
      .then(res => {
        this.interview.content = res.data.content
        this.loading = false
      })
  }

  build() {
    Navigation() {
      Flex({ direction: FlexDirection.Column }) {
        Column() {
          Text(this.interview.stem)
            .width('100%')
            .fontColor('#121826')
            .fontSize(vp2vp(20))
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: vp2vp(10) })
            .sharedTransition('title' + this.interview.id, { duration: 300, curve: Curve.Linear })
          Row() {
            Text(this.interview.createdAt).fontSize(vp2vp(12)).fontColor('#c3c4c5')
            Text('|').fontSize(vp2vp(12)).fontColor('#c3c4c5').padding({ left: vp2vp(8), right: vp2vp(8) })
            Text(`点赞 ${this.interview.likeCount}`).fontSize(vp2vp(12)).fontColor('#c3c4c5')
            Text('|').fontSize(vp2vp(12)).fontColor('#c3c4c5').padding({ left: vp2vp(8), right: vp2vp(8) })
            Text(`浏览 ${this.interview.views}`).fontSize(vp2vp(12)).fontColor('#c3c4c5')
          }.width('100%').margin({ bottom: vp2vp(10) })

          Row() {
            Image(this.interview.creatorAvatar).width(vp2vp(25)).height(vp2vp(25)).margin({ right: vp2vp(5) })
              .sharedTransition('image' + this.interview.id, { duration: 300, curve: Curve.Linear })
            Text(this.interview.creatorName).fontSize(vp2vp(14)).fontColor('#121826')
          }.width('100%')
        }
        .padding(vp2vp(15))
        .border({ width: { bottom: 0.5 }, color: '#f5f5f5' })

        Column() {
          if (!this.loading) {
            DetailRichText({ content: this.interview.content })
          }
        }
        .width('100%')
        .padding(vp2vp(15))
        .layoutWeight(1)
      }
    }.title('面经详情').titleMode(NavigationTitleMode.Mini).mode(NavigationMode.Stack)
  }
}