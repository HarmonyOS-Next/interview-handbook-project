export enum HdSkeletonType {
  BASE,
  AVATAR,
  IMAGE
}

@Component
export struct HdSkeleton {
  @BuilderParam
  default: () => void
  // 透明度
  @State
  opacityValue: number = 1
  // 行数
  rows: number = 0
  // 类型
  type: HdSkeletonType = HdSkeletonType.BASE
  // 头像尺寸
  avatarSize: number = 40
  // 图片尺寸
  imageSize: number = 100

  build() {
    Row({ space: 15 }) {
      if (this.default) {
        this.default()
      } else {
        if (this.type === HdSkeletonType.AVATAR) {
          HdSkeletonAvatar({ widthValue: this.avatarSize })
            .alignSelf(ItemAlign.Start)
        }
        if (this.type === HdSkeletonType.IMAGE) {
          HdSkeletonImage({ widthValue: this.imageSize })
            .alignSelf(ItemAlign.Start)
        }
        Column() {
          HdSkeletonRow({ widthValue: '50%' })
            .margin({ top: this.type === HdSkeletonType.AVATAR ? 10 : 0 })
          ForEach(new Array(this.rows).fill(0), (_: number, i) => {
            HdSkeletonRow({ widthValue: i < this.rows - 1 ? '100%' : '75%' })
              .margin({ top: 10 })
          })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .alignSelf(ItemAlign.Start)
      }
    }
    .opacity(this.opacityValue)
    .animation({
      duration: 600,
      playMode: PlayMode.Alternate,
      iterations: -1,
      curve: Curve.EaseInOut
    })
    .onAppear(() => {
      this.opacityValue = 0.5
    })
  }
}


@Component
export struct HdSkeletonRow {
  @Prop
  widthValue: Length = '100%'

  build() {
    Text()
      .height(16)
      .width(this.widthValue)
      .borderRadius(2)
      .backgroundColor($r('app.color.common_gray_bg'))
  }
}

@Component
export struct HdSkeletonAvatar {
  @Prop
  widthValue: number = 40

  build() {
    Text()
      .width(this.widthValue)
      .aspectRatio(1)
      .borderRadius(this.widthValue / 2)
      .backgroundColor($r('app.color.common_gray_bg'))
  }
}

@Component
export struct HdSkeletonImage {
  @Prop
  widthValue: number = 100

  build() {
    Row() {
      Image($r('app.media.ic_public_image'))
        .width(this.widthValue / 2)
        .aspectRatio(1)
        .fillColor($r('app.color.common_gray_border'))
    }
    .justifyContent(FlexAlign.Center)
    .width(this.widthValue)
    .aspectRatio(1)
    .borderRadius(2)
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}