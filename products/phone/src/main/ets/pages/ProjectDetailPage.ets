import { ProjectDetailComp } from '@itcast/project/Index'

@Entry
@Component
struct ProjectPage {
  build() {
    Column() {
      ProjectDetailComp()
    }
  }
}