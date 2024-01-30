@CustomDialog
export struct WordSoundDialog {
  controller: CustomDialogController
  wordEn: string = ''
  wordZh: string = ''
  @State
  isGreen: boolean = false
  timer: number = -1

  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        Text(this.wordEn)
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(500)
        Image($r('sys.media.ohos_ic_public_sound'))
          .width(20)
          .aspectRatio(1)
          .fillColor(this.isGreen ? $r('app.color.common_green') : Color.White)
          .onAppear(() => {
            clearInterval(this.timer)
            this.timer = setInterval(() => {
              this.isGreen = !this.isGreen
            }, 500)
          })
          .onDisAppear(() => {
            clearInterval(this.timer)
          })
          .animation({ duration: 300 })
      }

      Text(this.wordZh)
        .fontColor(Color.White)
    }
    .constraintSize({ minWidth: 175 })
    .padding({ left: 16, right: 16 })
    .height(90)
    .borderRadius(45)
    .backgroundColor('#8f000000')
    .justifyContent(FlexAlign.Center)
  }
}