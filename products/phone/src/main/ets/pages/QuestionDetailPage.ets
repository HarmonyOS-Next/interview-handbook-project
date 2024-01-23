@Entry
@Component
struct QuestionDetailPage {
  @StorageProp('topHeight')
  topHeight: number = 0

  build() {
    Column() {
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.topHeight })
  }
}