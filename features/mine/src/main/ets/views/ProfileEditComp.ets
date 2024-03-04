import { authStore, hdHttp, HdLoadingDialog, HdNav, HdUser, logger } from '@itcast/basic/Index'
import { promptAction } from '@kit.ArkUI'
import { fileIo, picker } from '@kit.CoreFileKit'
import { request } from '@kit.BasicServicesKit'

@Component
export struct ProfileEditComp {
  @StorageProp('user')
  user: HdUser = {} as HdUser
  dialog: CustomDialogController = new CustomDialogController({
    builder: HdLoadingDialog({ message: '更新中...' }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  updateAvatar() {
    const photoSelectOptions = new picker.PhotoSelectOptions()
    photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
    photoSelectOptions.maxSelectNumber = 1

    const photoViewPicker = new picker.PhotoViewPicker()
    photoViewPicker.select(photoSelectOptions).then(result => {
      // 1. 得到文件路径
      const URI = result.photoUris[0]
      // 2. 存储到沙箱中
      const context = getContext(this)
      const fileType = 'jpg'
      const fileName = Date.now() + '.' + fileType
      const copyFilePath = context.cacheDir + '/' + fileName
      const file = fileIo.openSync(URI, fileIo.OpenMode.READ_ONLY)
      fileIo.copyFileSync(file.fd, copyFilePath)
      // 3. 准备请求配置
      const config: request.UploadConfig = {
        url: hdHttp.baseURL + 'userInfo/avatar',
        method: 'POST',
        header: {
          'Accept': '*/*',
          'Authorization': `Bearer ${this.user.token}`,
          'Content-Type': 'multipart/form-data'
        },
        files: [
          { name: 'file', uri: `internal://cache/` + fileName, type: fileType, filename: fileName }
        ],
        data: []
      }
      // 4. 开始上传
      this.dialog.open()
      request.uploadFile(context, config, (err, data) => {
        if (err) return logger.error('UPLOAD', err.message)
        data.on('complete', () => {
          // 5. 更新头像
          hdHttp.get<HdUser>('userInfo').then(res => {
            this.user.avatar = res.data.avatar
            authStore.setUser(this.user)
            promptAction.showToast({ message: '更新头像成功' })
            this.dialog.close()
          })
        })
      })
    })
  }

  updateNickName() {
    hdHttp.post<null>('userInfo/profile', {
      nickName: this.user.nickName
    } as HdUser).then(res => {
      promptAction.showToast({ message: '更新昵称成功' })
      authStore.setUser(this.user)
    })
  }

  build() {
    Column() {
      HdNav({ title: '编辑资料', showRightIcon: false })
      List() {
        ListItem() {
          Row() {
            Text('头像')
            Image(this.user.avatar || $r('app.media.ic_mine_avatar'))
              .alt($r('app.media.ic_mine_avatar'))
              .width(40)
              .aspectRatio(1)
              .borderRadius(20)
              .border({ width: $r('app.float.common_border_width'), color: $r('app.color.common_gray_border') })
              .onClick(() => {
                this.updateAvatar()
              })
          }
          .width('100%')
          .height(60)
          .justifyContent(FlexAlign.SpaceBetween)
        }

        ListItem() {
          Row() {
            Text('昵称')
            TextInput({ text: this.user.nickName })
              .fontColor($r('app.color.common_gray_03'))
              .textAlign(TextAlign.End)
              .layoutWeight(1)
              .padding(0)
              .height(60)
              .backgroundColor($r('app.color.white'))
              .borderRadius(0)
              .onChange((value) => this.user.nickName = value)
              .onSubmit(() => {
                this.updateNickName()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
      .width('100%')
      .height('100%')
      .padding({
        left: 35,
        right: 35,
        top: 15,
        bottom: 15
      })
      .divider({ strokeWidth: $r('app.float.common_border_width'), color: $r('app.color.common_gray_bg') })
    }
  }
}