import { InterviewDetailComp } from '@itcast/interview/Index';

@Entry
@Component
struct InterviewDetailPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      InterviewDetailComp()
    }
  }
}