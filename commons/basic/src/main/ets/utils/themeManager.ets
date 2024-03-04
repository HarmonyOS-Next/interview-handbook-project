/**
 * 1. 主题设置
 * 2. 沉浸式设置
 * 3. 通知栏设置
 */
import { ConfigurationConstant } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'

class ThemeManager {
  windowStage: window.Window | null = null

  async getWindowStage() {
    if (this.windowStage) {
      return this.windowStage
    } else {
      return await window.getLastWindow(getContext())
    }
  }

  constructor() {
    this.initThemeSetting()
  }

  initThemeSetting() {
    const app = getContext().getApplicationContext()
    app.on('environment', {
      onConfigurationUpdated: (config) => {
        AppStorage.set('colorMode', config.colorMode)
        if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
          this.settingStatusBarBlack()
        }
        if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) {
          this.settingStatusBarWhite()
        }
        if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET) {
          // TODO
        }
      },
      onMemoryLevel: (_level) => {
        // TODO
      }
    })
    // 默认浅色模式
    const initColorMode = AppStorage.get<ConfigurationConstant.ColorMode>('initColorMode')
    PersistentStorage.persistProp('colorMode', initColorMode)
    const currentColorMode = AppStorage.get<ConfigurationConstant.ColorMode>('colorMode')
    app.setColorMode(currentColorMode)
  }

  settingStatusBarWhite() {
    this.settingStatusBar({ statusBarContentColor: '#FFFFFF' })
  }

  settingStatusBarBlack() {
    this.settingStatusBar({ statusBarContentColor: '#000000' })
  }

  settingStatusBar(config: window.SystemBarProperties) {
    this.getWindowStage().then((windowStage: window.Window) => {
      windowStage.setWindowSystemBarProperties(config)
    })
  }

  enableFullScreen() {
    this.getWindowStage().then((windowStage: window.Window) => {
      windowStage.setWindowLayoutFullScreen(true)
      const topArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      AppStorage.setOrCreate('topHeight', px2vp(topArea.topRect.height))
      const bottomArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      AppStorage.setOrCreate('bottomHeight', px2vp(bottomArea.bottomRect.height))
    })
  }

  disableFullScreen() {
    this.getWindowStage().then((windowStage: window.Window) => {
      windowStage.setWindowLayoutFullScreen(false)
      AppStorage.setOrCreate('topHeight', 0)
      AppStorage.setOrCreate('bottomHeight', 0)
    })
  }
}

export const themeManager = new ThemeManager()