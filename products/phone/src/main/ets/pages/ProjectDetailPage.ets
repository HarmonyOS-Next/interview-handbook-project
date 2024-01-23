import { ProjectDetailComp } from '@itcast/project/Index'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct ProjectPage {
  onPageShow(): void {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      windowStage.setWindowSystemBarProperties({
        statusBarContentColor: '#ffffff',
      })
    })
  }

  onPageHide(): void {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      windowStage.setWindowSystemBarProperties({
        statusBarContentColor: '#000000',
      })
    })
  }

  build() {
    Column() {
      ProjectDetailComp()
    }
  }
}