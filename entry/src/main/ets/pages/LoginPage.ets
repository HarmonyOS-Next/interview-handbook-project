import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { PAGE_MAP } from '../constants';
import { ResponseData, UserInfo } from '../models/index';
import { vp2vp } from '../utils/base';
import { requestPost } from '../utils/request';

@Entry
@Component
struct LoginPage {
  @State
  mobile: string = 'hmheima'
  @State
  code: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false

  login() {
    if(this.loading) return;

    if (!this.mobile) {
      return promptAction.showToast({ message: '请输入用户名' })
    }
    if (!this.code) {
      return promptAction.showToast({ message: '请输入密码' })
    }
    if (!this.isAgree) {
      return promptAction.showToast({ message: '请勾选已阅读并同意' })
    }

    this.loading = true
    requestPost('login', {
      username: this.mobile,
      password: this.code
    }).then((res: ResponseData<UserInfo>) => {
      AppStorage.Set('user', JSON.stringify(res.data))

      promptAction.showToast({ message: '登录成功', duration: 2000 })

      const params = router.getParams() as Record<string, any> || {}

      if (params.to) {
        const backUrl = params.to
        delete params.to
        router.replaceUrl({
          url: backUrl,
          params
        })
      } else {
        router.clear()
        router.back({
          url: 'pages/Index'
        })
      }

      this.loading = false
    })

  }

  @Styles
  inputStyle() {
    .margin({ bottom: vp2vp(15) })
    .height(vp2vp(44))
    .borderRadius(vp2vp(2))
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
    .padding({ left: 0 })
  }

  build() {
    Navigation() {
      Scroll() {
        Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
          Column() {
            Image($r('app.media.icon')).width(vp2vp(120)).height(vp2vp(120))
            Text('面试宝典').fontSize(vp2vp(28)).margin({ bottom: vp2vp(15) })
            Text('搞定企业面试真题，就用面试宝典').fontSize(vp2vp(14)).fontColor($r('app.color.ih_gray_color'))
          }.padding(20)

          Column() {
            TextInput({ placeholder: '请输入用户名', text: this.mobile })
              .inputStyle()
              .placeholderColor('#C3C3C5')
              .caretColor('#fa711d')
              .onChange(val => this.mobile = val)
            TextInput({ placeholder: '请输入密码', text: this.code, })
              .type(InputType.Password)
              .showPasswordIcon(false)
              .inputStyle()
              .placeholderColor('#C3C3C5')
              .caretColor('#fa711d')
              .onChange(val => this.code = val)
            Row() {
              Checkbox()
                .selectedColor('#fa711d')
                .size({ width: vp2vp(14), height: vp2vp(14) })
                .select(this.isAgree)
                .onChange((val) => {
                  this.isAgree = val
                })
              Text('已阅读并同意')
                .fontSize(vp2vp(14))
                .fontColor($r('app.color.ih_gray_color'))
                .padding({ right: vp2vp(4) })
              Text('用户协议')
                .fontSize(vp2vp(14))
                .padding({ right: vp2vp(4) })
              Text('和')
                .fontSize(vp2vp(14))
                .fontColor($r('app.color.ih_gray_color'))
                .padding({ right: vp2vp(4) })
              Text('隐私政策')
                .fontSize(vp2vp(14))
                .onClick(() => {
                  router.pushUrl({
                    url: PAGE_MAP.preview_web
                  })
                })
            }.width('100%').margin({ bottom: vp2vp(15) })

            Button({ type: ButtonType.Normal }) {
              Row(){
                if (this.loading) {
                  LoadingProgress()
                    .color('#ffffff')
                    .width(vp2vp(24))
                    .height(vp2vp(24))
                    .margin({ right: vp2vp(10) })
                }
                Text('立即登录').fontColor('#ffffff')
              }
            }
            .width('100%')
            .backgroundColor('none')
            .borderRadius(vp2vp(4))
            .height(vp2vp(44))
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [['#fc9c1c', 0], ['#fa711d', 1]]
            })
            .stateEffect(false)
            .onClick(() => {
              this.login()
            })
          }.padding(vp2vp(30))

          Column() {
            Text('其他登录方式')
              .fontSize(vp2vp(14))
              .fontColor($r('app.color.ih_gray_color'))
          }.padding({ top: vp2vp(70), bottom: vp2vp(100) })
        }
      }
    }
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .mode(NavigationMode.Stack)
  }
}