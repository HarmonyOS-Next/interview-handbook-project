import router from '@ohos.router'
import { QuestionList } from '../components/QuestionList'
import SearchWrapper from '../components/SearchWrapper'
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
      Row() {
        SearchWrapper({
          bg: 'rgba(246,247,249,0.64)',
          textColor: '#ffffff'
        })
      }.padding({ left: 15, right: 15, top: 10, bottom: 30 })

      Column() {
        Row(){
          Text(`${this.projectName}常见面试题`)
            .fontWeight(FontWeight.Bold)
          Image($r('app.media.icon_project_tit'))
            .size({ width: 14, height: 14 })
            .margin({ left: 2 })
        }
        .width('100%')
        .padding({ top: 20, bottom: 15 })

        QuestionList({
          questionTypeId: this.projectId,
          activeQuestionTypeId: this.projectId
        })
      }
      .padding({ left: 15, right: 15 })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#fff')
      .borderRadius({
        topLeft: 16,
        topRight: 16
      })
    }
    .title('面试必考')
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [['#4a9fef', 0], ['#5c78f0', 1]]
    })
    .titleMode(NavigationTitleMode.Mini)
  }
}