import router from '@ohos.router'
import { DetailRichText } from '../components/DetailRichText'
import { InterviewItem } from '../models'
import logger from '../utils/logger'
import { requestGet } from '../utils/request'

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
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })
          // .sharedTransition('title' + this.interview.id, { duration: 300, curve: Curve.Linear })
          Row() {
            Text(this.interview.createdAt).fontSize(12).fontColor('#c3c4c5')
            Text('|').fontSize(12).fontColor('#c3c4c5').padding({ left: 8, right: 8 })
            Text(`点赞 ${this.interview.likeCount}`).fontSize(12).fontColor('#c3c4c5')
            Text('|').fontSize(12).fontColor('#c3c4c5').padding({ left: 8, right: 8 })
            Text(`浏览 ${this.interview.views}`).fontSize(12).fontColor('#c3c4c5')
          }.width('100%').margin({ bottom: 10 })

          Row() {
            Image(this.interview.creatorAvatar).width(25).height(25).margin({ right: 5 })
              // .sharedTransition('image' + this.interview.id, { duration: 300, curve: Curve.Linear })
            Text(this.interview.creatorName).fontSize(14).fontColor('#121826')
          }.width('100%')
        }
        .padding(15)
        .border({ width: { bottom: 0.5 }, color: '#f5f5f5' })

        Column() {
          if (!this.loading) {
            DetailRichText({ content: this.interview.content })
          }
        }
        .width('100%')
        .padding(15)
        .layoutWeight(1)
      }
    }.title('面经详情').titleMode(NavigationTitleMode.Mini)
  }
}