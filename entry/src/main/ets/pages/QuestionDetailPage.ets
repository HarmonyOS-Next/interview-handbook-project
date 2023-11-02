import router from '@ohos.router'

@Entry
@Component
struct QuestionDetailPage {
  questionId: number
  stem: string
  html: string = `
          <div style="font-size: 14px">
            <ul style="margin: 0; padding: 0">
              <li>一、vue作为一款轻量级框架，门槛低，上手快，简单易学。</li>
              <li>二、vue可以进行组件化开发，数据与结构相分离，使代码量减少，从而提升开发效率，易于理解</li>
              <li style="color:green;">三、vue最突出的优势在于对数据进行双向绑定，使用虚拟DOM</li>
              <li>四、相较于传统页面通过超链接实现页面跳转，vue会使用路由跳转不会刷新页面</li>
              <li>五、vue是单页面应用，页面局部刷新，不用每次跳转都请求数据，加快了访问速度，提升了用户体验</li>
            </ul>
          </div>
          `

  aboutToAppear() {
    const params = router.getParams()
    this.questionId = params['id']
    this.stem = params['stem']
  }

  @Builder
  titleBuilder(text: string) {
    Row() {
      Text().width(2).height(12).backgroundColor('#121826').margin({ right: 13 })
      Text(text).fontWeight(600)
    }
    .width('100%')
    .padding({ top: 10 })
  }

  @Builder
  tagBuilder(text: string, color: string = '#41B883') {
    Text(text)
      .fontSize(10)
      .padding(5)
      .backgroundColor($r('app.color.ih_bg_color'))
      .borderRadius(2)
      .fontColor(color)
      .margin({ right: 5 })
  }

  @Builder
  toggleBuilder() {
    Row(){
      Image($r("app.media.prev_black")).width(80)
      Image($r("app.media.next_black")).width(80)
    }.width('100%').justifyContent(FlexAlign.SpaceAround)
  }

  build() {
    Navigation() {
      Flex({ direction: FlexDirection.Column }) {
        Column() {
          this.titleBuilder('题目:')
          Column() {
            Text(this.stem).width('100%')
            Row() {
              this.tagBuilder('简单')
              this.tagBuilder('移动端布局')
            }
            .width('100%')
            .padding({ top: 15})
          }.padding(15)
        }

        Column()
          .width('100%')
          .height(8)
          .backgroundColor($r('app.color.ih_bg_color'))

        Column() {
          this.titleBuilder('答案:')
          Flex(){
            RichText(this.html)
          }.padding(15)
        }.layoutWeight(1)
      }
    }
    .title('题目详情')
    .titleMode(NavigationTitleMode.Mini)
    .toolBar(this.toggleBuilder())
  }
}