import webview from '@ohos.web.webview';

@Entry
@Component
struct PreviewWebPage {
  webController: webview.WebviewController = new webview.WebviewController()

  build() {
    Navigation() {
      Scroll() {
        Web({
          src: $rawfile('index.html'),
          controller: this.webController
        })
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .title('隐私协议')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}