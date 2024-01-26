import { windowManager } from '@itcast/basic/Index'
import { WordComp } from '@itcast/mine'

@Entry
@Component
struct WordPage {
  onPageShow(): void {
    windowManager.settingStatusBarDark()
  }

  build() {
    Column() {
      WordComp()
    }
  }
}