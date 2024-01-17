export interface Tag {
  text: ResourceStr
  color: ResourceColor
}

@Component
export struct HdTag {
  text: string = ''
  difficulty: number = 1

  getTag(): Tag {
    if (this.difficulty === 3 || this.difficulty === 4) {
      return { text: $r('app.string.hd_tag_general'), color: $r('app.color.common_blue') }
    } else if (this.difficulty === 5) {
      return { text: $r('app.string.hd_tag_difficult'), color: $r('app.color.common_main_color') }
    }
    return { text: this.text ? this.text : $r('app.string.hd_tag_simple'), color: $r('app.color.common_green') }
  }

  build() {
    Text(this.getTag().text)
      .fontColor(this.getTag().color)
      .fontSize($r('app.float.common_font10'))
      .padding({ left: $r('app.float.common_space4'), right: $r('app.float.common_space4')})
      .constraintSize({ minWidth: $r('app.float.hd_tag_width') })
      .height($r('app.float.hd_tag_height'))
      .backgroundColor($r('app.color.common_gray_bg'))
      .borderRadius($r('app.float.hd_tag_radius'))
      .textAlign(TextAlign.Center)
  }
}