@Component
export struct DetailRichText {
  @Prop
  content: string
  @State
  loading: boolean = true

  build() {
    Stack() {
      RichText(`
        <!doctype html>
        <html>
          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <style>
              body {
                background: 'pink';
              }
            </style>
          </head>
          <body>
            ${this.content}
          </body>
        </html>
      `).width("100%").height("100%")
        .onComplete(() => {
          this.loading = false
        })
      if (this.loading) {
        Column() {
          LoadingProgress().width(50).height(50).color('#979797')
        }
        .width("100%")
        .height("100%")
        .backgroundColor('#ffffff')
        .padding({ top: 50 })
      }
    }
    .width("100%")
    .height("100%")
  }
}