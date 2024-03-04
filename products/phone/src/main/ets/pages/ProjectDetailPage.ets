import { themeManager } from '@itcast/basic'
import { ProjectDetailComp } from '@itcast/project'

@Entry
@Component
struct ProjectPage {
  onPageShow(): void {
    themeManager.settingStatusBarWhite()
  }

  onPageHide(): void {
    themeManager.settingStatusBarBlack()
  }

  build() {
    Column() {
      ProjectDetailComp()
    }
  }
}