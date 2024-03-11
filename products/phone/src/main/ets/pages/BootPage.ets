import { authStore, themeManager } from '@itcast/basic'
import { BootView } from '@itcast/home'

@Entry
@Component
struct BootPage {
  aboutToAppear(): void {
    themeManager.initThemeSetting()
    themeManager.enableFullScreen()
    authStore.initUser()

    getContext().getApplicationContext().getRunningProcessInformation()
  }

  build() {
    Column() {
      BootView()
    }
  }
}