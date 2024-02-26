import { authStore, HdNav } from '@itcast/basic';
import { bundleManager } from '@kit.AbilityKit';
import { storageStatistics } from '@kit.CoreFileKit';
import fs from '@ohos.file.fs';
import { promptAction, router } from '@kit.ArkUI';

export interface Tool {
  icon?: ResourceStr
  name: string
  value?: string
  onClick?: () => void
}

@Component
export struct SettingsComp {
  @State
  version: string = ''
  @State
  cache: string = ''

  aboutToAppear(): void {
    bundleManager.getBundleInfoForSelf(
      bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
      bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA
    ).then((res) => {
      this.version = 'v' + res.versionName
    })
    this.calcCache()
  }

  calcCache() {
    storageStatistics.getCurrentBundleStats().then(res => {
      this.cache = (res.cacheSize / (1024 * 1024)).toFixed(2) + 'MB'
    })
  }

  clearCache() {
    const dir = getContext().cacheDir
    const listDir = fs.listFileSync(dir)
    listDir.forEach(item => {
      const filePath = dir + '/' + item
      const stat = fs.statSync(filePath)
      if (stat.isDirectory()) {
        fs.rmdirSync(filePath)
      }
      if (stat.isFile()) {
        fs.unlinkSync(filePath)
      }
    })
    promptAction.showToast({ message: '清理完毕' })
    this.calcCache()
  }

  @Builder
  toolsBuilder(tool: Tool) {
    Row() {
      if (tool.icon) {
        Image(tool.icon)
          .width(16)
          .aspectRatio(1)
          .margin({ right: 12 })
      }
      Text(tool.name)
        .fontSize(16)
      Blank()
      if (tool.value) {
        Text(tool.value)
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
          .margin({ right: 10 })
      }
      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(18)
        .aspectRatio(1)
        .fillColor($r('app.color.common_gray_01'))
    }
    .height(50)
    .width('100%')
    .backgroundColor(Color.White)
    .padding({ left: 16, right: 10 })
    .onClick(() => {
      tool.onClick && tool.onClick()
    })
  }

  build() {
    Column() {
      HdNav({ title: '设置', showRightIcon: false, hasBorder: true })
      Column({ space: 0.5 }) {
        Blank().height(10)
        this.toolsBuilder({ name: '编辑资料' })
        this.toolsBuilder({ name: '账号设置' })
        this.toolsBuilder({ name: '消息设置' })
        Blank().height(10)
        this.toolsBuilder({ name: '深色模式', value: '已关闭' })
        this.toolsBuilder({
          name: '清除应用缓存', value: this.cache, onClick: () => {
            this.clearCache()
          }
        })
        this.toolsBuilder({ name: '检查更新', value: this.version })
        Blank().height(10)
        Text('退出账号')
          .height(50)
          .fontColor($r('app.color.common_main_color'))
          .opacity(0.6)
          .onClick(() => {
            authStore.delUser()
            router.back()
          })
      }
      .layoutWeight(1)
      .backgroundColor($r('app.color.common_gray_bg'))
    }
  }
}