@CustomDialog
export struct LoadingDialog {
  @State
  message: string = ''
  controller: CustomDialogController

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      LoadingProgress().width(48).height(48).color('#fff')
      if (this.message) {
        Text(this.message).fontSize(14).fontColor('#fff')
      }
    }.width(120).height(120).backgroundColor('rgba(0,0,0,0.5)').borderRadius(16)
  }
}