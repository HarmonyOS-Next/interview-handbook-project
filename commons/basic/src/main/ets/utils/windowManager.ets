import { window } from '@kit.ArkUI'

class WindowManager {
  enableFullScreen() {
    window.getLastWindow(getContext()).then((windowStage: window.Window) => {
      windowStage.setWindowLayoutFullScreen(true)
      const topArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      AppStorage.setOrCreate('topHeight', px2vp(topArea.topRect.height))
      const bottomArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      AppStorage.setOrCreate('bottomHeight', px2vp(bottomArea.bottomRect.height))
    })
  }

  disableFullScreen() {
    window.getLastWindow(getContext()).then((windowStage: window.Window) => {
      windowStage.setWindowLayoutFullScreen(false)
      AppStorage.setOrCreate('topHeight', 0)
      AppStorage.setOrCreate('bottomHeight', 0)
    })
  }

  settingStatusBarLight() {
    this.settingStatusBar({ statusBarContentColor: '#FFFFFF' })
  }

  settingStatusBarDark() {
    this.settingStatusBar({ statusBarContentColor: '#000000' })
  }

  settingStatusBar(config: window.SystemBarProperties) {
    window.getLastWindow(getContext()).then((windowStage: window.Window) => {
      windowStage.setWindowSystemBarProperties(config)
    })
  }

  scrollStatusBar(scrollTop: number) {
    if (scrollTop < 40) {
      const opacity = Math.floor(scrollTop / 40 * 255).toString(16)
      this.settingStatusBar({
        statusBarColor: `#${opacity.padStart(2, '0')}ffffff`,
      })
    } else {
      this.settingStatusBar({
        statusBarColor: '#ffffffff',
      })
    }
  }
}


export const windowManager = new WindowManager()