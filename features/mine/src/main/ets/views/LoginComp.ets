import { authStore, hdHttp, HdResponse, HdUser } from '@itcast/basic'
import { promptAction, router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'

interface LoginParams {
  username: string
  password: string
}

@Component
export struct LoginComp {
  @State
  mobile: string = 'hmheima'
  @State
  code: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false
  @StorageProp('topHeight')
  topHeight: number = 0

  login() {
    if (this.loading) return;
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
    // login request
    hdHttp.post<HdUser>('login', {
      username: this.mobile,
      password: this.code
    } as LoginParams).then(async (res: HdResponse<HdUser>) => {
      await authStore.setUser(res.data)
      promptAction.showToast({ message: '登录成功', duration: 1000 })
      emitter.emit({ eventId: 100401 })
      const params = router.getParams() as Record<string, string>
      if (params && params.return_path) {
        router.replaceUrl({
          url: params.return_path,
          params: params
        })
      } else {
        router.back()
      }
      this.loading = false
    })
  }

  build() {
    Navigation() {
      Column() {
        Column() {
          Image($r('app.media.icon'))
            .width(120)
            .aspectRatio(1)
          Text('面试通')
            .fontSize(28)
            .margin({ bottom: 15 })
          Text('搞定企业面试真题，就用面试通')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
        }

        Column({ space: 15 }) {
          TextInput({ placeholder: '请输入用户名', text: $$this.mobile })
            .customStyle()
          TextInput({ placeholder: '请输入密码', text: $$this.code })
            .type(InputType.Password)
            .showPasswordIcon(false)
            .customStyle()
          Row() {
            Checkbox()
              .shape(CheckBoxShape.ROUNDED_SQUARE)
              .selectedColor('#fa711d')
              .size({ width: 14, height: 14 })
              .select(this.isAgree)
              .onChange((val) => {
                this.isAgree = val
              })
            Text('已阅读并同意')
              .fontSize(14)
              .fontColor($r('app.color.common_gray_01'))
              .padding({ right: 4 })
            Text('用户协议')
              .fontSize(14)
              .padding({ right: 4 })
            Text('和')
              .fontSize(14)
              .fontColor($r('app.color.common_gray_01'))
              .padding({ right: 4 })
            Text('隐私政策')
              .fontSize(14)
          }.width('100%')

          Button({ type: ButtonType.Normal }) {
            Row() {
              if (this.loading) {
                LoadingProgress()
                  .color($r('app.color.white'))
                  .width(24)
                  .height(24)
                  .margin({ right: 10 })
              }
              Text('立即登录').fontColor($r('app.color.white'))
            }
          }
          .width('100%')
          .backgroundColor('none')
          .borderRadius(4)
          .height(44)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#fc9c1c', 0], ['#fa711d', 1]]
          })
          .stateEffect(false)
          .onClick(() => {
            this.login()
          })
        }
        .padding({ left: 20, right: 20, top: 30 })


        Column() {
          Text('其他登录方式')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
        }.padding({ top: 70, bottom: 100 })

      }
      .width('100%')
      .height('100%')
      .padding($r('app.float.common_gutter'))
    }
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .margin({ top: this.topHeight })
  }
}

@Extend(TextInput)
function customStyle() {
  .placeholderColor('#C3C3C5')
  .caretColor('#fa711d')
  .height(44)
  .borderRadius(0)
  .backgroundColor($r('app.color.white'))
  .border({ width: { bottom: $r('app.float.common_border_width') }, color: $r('app.color.common_gray_border') })
}