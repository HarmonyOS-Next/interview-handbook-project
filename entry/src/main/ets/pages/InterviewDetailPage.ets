@Entry
@Component
struct InterviewDetailPage {

  build() {
    Column(){
      Image($rawfile('avatar.png')).width(200).height(200)
        .sharedTransition('image', { duration: 100, curve: Curve.Linear })
    }
  }
}