import { ClockedComp } from '@itcast/mine'

@Entry
@Component
struct ClockedPage {
  build() {
    Column() {
      ClockedComp()
    }
  }
}