@Entry
@Component
struct LoginPage {
  @State
  mobile: string = ''
  @State
  code: string = ''

  @Styles
  inputStyle() {
    .margin({ bottom: 15 })
    .height(44)
    .borderRadius(2)
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
    .padding({ left: 0 })
  }

  build() {
    Navigation() {
      Scroll() {
        Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
          Column() {
            Image($r('app.media.icon')).width(120).height(120)
            Text('面试宝典').fontSize(28).margin({ bottom: 15 })
            Text('搞定企业面试真题，就用面试宝典').fontSize(14).fontColor($r('app.color.ih_gray_color'))
          }.padding(20)

          Column() {
            TextInput({ placeholder: '请输入手机号', text: this.mobile })
              .inputStyle()
              .placeholderColor('#C3C3C5')
              .caretColor('#fa711d')
              .onChange(val => this.mobile = val)
            TextInput({ placeholder: '请输入验证码', text: this.code })
              .inputStyle()
              .placeholderColor('#C3C3C5')
              .caretColor('#fa711d')
              .onChange(val => this.code = val)
            Row() {
              Checkbox().selectedColor('#fa711d').size({ width: 14, height: 14 })
              Text('已阅读并同意')
                .fontSize(14)
                .fontColor($r('app.color.ih_gray_color'))
                .padding({ right: 4 })
              Text('用户协议')
                .fontSize(14)
                .padding({ right: 4 })
              Text('和')
                .fontSize(14)
                .fontColor($r('app.color.ih_gray_color'))
                .padding({ right: 4 })
              Text('隐私政策')
                .fontSize(14)
            }.width('100%').margin({ bottom: 15 })

            Button('立即登录', { type: ButtonType.Normal })
              .width('100%')
              .margin({ bottom: 15 })
              .backgroundColor('none')
              .borderRadius(4)
              .height(44)
              .linearGradient({
                direction: GradientDirection.Right,
                colors: [['#fc9c1c', 0], ['#fa711d', 1]]
              })
              .stateEffect(false)
          }.padding(30)

          Column() {
            Text('其他登录方式')
              .fontSize(14)
              .fontColor($r('app.color.ih_gray_color'))
          }.padding({ top: 70, bottom: 100 })
        }
      }
    }
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}