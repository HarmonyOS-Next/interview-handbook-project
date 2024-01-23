import { windowManager } from '@itcast/basic/Index'
import { ClockedComp } from '@itcast/mine'

@Entry
@Component
struct ClockedPage {
  onPageShow(): void {
    windowManager.settingStatusBarDark()
  }

  build() {
    Column() {
      ClockedComp()
    }
  }
}