import { QuestionDetailComp } from '@itcast/home'

@Entry
@Component
struct QuestionDetailPage {
  @StorageProp('bottomHeight')
  bottomHeight: number = 0

  build() {
    Column() {
      QuestionDetailComp()
    }
    .padding({ bottom: this.bottomHeight })
  }
}