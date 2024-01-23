import { window } from '@kit.ArkUI'

class WindowManager {
  enableFullScreen() {
    window.getLastWindow(getContext()).then((windowStage: window.Window) => {
      const area = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      const topHeight = px2vp(area.topRect.height)
      if (topHeight > 0) {
        windowStage.setWindowLayoutFullScreen(true)
        AppStorage.setOrCreate('topHeight', topHeight)
      }
    })
  }

  disableFullScreen() {
    window.getLastWindow(getContext()).then((windowStage: window.Window) => {
      windowStage.setWindowLayoutFullScreen(false)
      AppStorage.setOrCreate('topHeight', 0)
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
}


export const windowManager = new WindowManager()