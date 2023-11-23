import { vp2vp } from '../utils/base'
@CustomDialog
export struct LoadingDialog {
  @State
  message: string = ''
  controller: CustomDialogController

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      LoadingProgress().width(vp2vp(48)).height(vp2vp(48)).color('#fff')
      if (this.message) {
        Text(this.message).fontSize(vp2vp(14)).fontColor('#fff')
      }
    }.width(vp2vp(120)).height(vp2vp(120)).backgroundColor('rgba(0,0,0,0.5)').borderRadius(vp2vp(16))
  }
}