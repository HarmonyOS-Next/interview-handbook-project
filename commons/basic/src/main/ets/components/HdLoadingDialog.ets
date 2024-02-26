@CustomDialog
export struct HdLoadingDialog {
  @State
  message: string = ''
  controller: CustomDialogController

  build() {
    Column({ space: 10 }) {
      LoadingProgress()
        .width(48)
        .height(48)
        .color('#ffffff')
      if (this.message) {
        Text(this.message)
          .fontSize(14)
          .fontColor('#ffffff')
      }
    }
    .justifyContent(FlexAlign.Center)
    .width(120)
    .height(120)
    .backgroundColor('rgba(0,0,0,0.6)')
    .borderRadius(16)
  }
}