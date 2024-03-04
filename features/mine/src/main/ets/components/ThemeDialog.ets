import { ConfigurationConstant } from '@kit.AbilityKit'
import { promptAction } from '@kit.ArkUI'

@CustomDialog
export struct ThemeDialog {
  controller: CustomDialogController
  @State
  isOn: boolean = false
  @StorageProp('colorMode')
  @Watch('onUpdateIsOn')
  colorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET
  app = getContext().getApplicationContext()

  onUpdateIsOn() {
    this.isOn = this.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET
  }

  aboutToAppear(): void {
    this.isOn = this.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET
  }

  build() {
    Column() {
      Row() {
        Column({ space: 4 }) {
          Text('跟随系统')
          Text('开启后，将跟随系统打开或关闭深色模式')
            .fontSize(12)
            .fontColor($r('app.color.common_gray_01'))
        }
        .alignItems(HorizontalAlign.Start)

        Toggle({ type: ToggleType.Switch, isOn: this.isOn })
          .onChange((val) => {
            this.isOn = val
            this.app.setColorMode(
              this.isOn
                ? ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET
                : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
            )
            if (this.isOn) {
              AppStorage.set('colorMode', ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
              promptAction.showToast({ message: '重启后生效' })
            }
          })
      }
      .width('100%')
      .height(70)
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })

      if (this.colorMode !== ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET) {
        Row() {
          Text('普通模式')
            .fontSize(15)
          Blank()
          if (this.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
            Image($r('app.media.ic_public_ok'))
              .width(16)
              .aspectRatio(1)
              .fillColor($r('app.color.common_green'))
          }
        }
        .width('100%')
        .height(50)
        .onClick(() => {
          getContext().getApplicationContext()
            .setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        })
        .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })


        Row() {
          Text('深色模式')
            .fontSize(15)
          Blank()
          if (this.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) {
            Image($r('app.media.ic_public_ok'))
              .width(16)
              .aspectRatio(1)
              .fillColor($r('app.color.common_green'))
          }
        }
        .width('100%')
        .height(50)
        .onClick(() => {
          getContext().getApplicationContext()
            .setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        })
      }
    }
    .width('100%')
    .padding({ top: 15, bottom: 15, left: 30, right: 30 })
    .backgroundColor($r('app.color.white'))
  }
}