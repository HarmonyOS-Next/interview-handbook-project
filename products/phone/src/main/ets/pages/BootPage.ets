import { authStore, themeManager } from '@itcast/basic'
import { BootView } from '@itcast/home'

@Entry
@Component
struct BootPage {
  aboutToAppear(): void {
    themeManager.enableFullScreen()
    authStore.initUser()
  }

  build() {
    Column() {
      BootView()
    }
  }
}