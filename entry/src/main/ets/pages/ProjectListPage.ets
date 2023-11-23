import router from '@ohos.router'
import { QuestionList } from '../components/QuestionList'
import SearchWrapper from '../components/SearchWrapper'
import { vp2vp } from '../utils/base'
import page from '../utils/router'
@Entry
@Component
struct ProjectListPage {

  @State
  projectId: number = undefined
  @State
  projectName: string = undefined

  aboutToAppear() {
    const params = router.getParams()
    this.projectId = params['id']
    this.projectName = params['name']
  }

  build() {
    Navigation() {
      Flex({ direction: FlexDirection.Column }){
        Row() {
          SearchWrapper({
            bg: 'rgba(246,247,249,0.64)',
            textColor: '#ffffff'
          })
        }.padding({ left: vp2vp(15), right: vp2vp(15), top: vp2vp(15), bottom: vp2vp(30) })

        Column() {
          Row(){
            Text(`${this.projectName}常见面试题`)
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.icon_project_tit'))
              .size({ width: vp2vp(14), height: vp2vp(14) })
              .margin({ left: vp2vp(2) })
          }
          .width('100%')
          .padding({ top: vp2vp(20), bottom: vp2vp(15) })

          QuestionList({
            questionTypeId: this.projectId,
            activeQuestionTypeId: this.projectId
          })
        }
        .padding({ left: vp2vp(15), right: vp2vp(15) })
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#fff')
        .borderRadius({
          topLeft: vp2vp(16),
          topRight: vp2vp(16)
        })
      }
    }
    .mode(NavigationMode.Stack)
    .title('面试必考')
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [['#4a9fef', 0], ['#5c78f0', 1]]
    })
    .titleMode(NavigationTitleMode.Mini)
  }
}