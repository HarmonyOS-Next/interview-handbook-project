import promptAction from '@ohos.promptAction'
import request from '@ohos.request'
import picker from '@ohos.file.picker'
import fs from '@ohos.file.fs'
import { UserInfo } from '../models'
import { requestGet, requestPost } from '../utils/request'
import logger from '../utils/logger'
import { vp2vp } from '../utils/base'

@Entry
@Component
struct ProfileEditPage {
  @StorageProp('user')
  @Watch('setUser')
  userJson: string = '{}'
  @State
  user: UserInfo = undefined
  URI: string = null
  @State
  loading: boolean = false

  setUser() {
    this.user = JSON.parse(this.userJson)
  }

  aboutToAppear() {
    this.setUser()
  }

  updateNickName() {
    requestPost('userInfo/profile', {
      nickName: this.user.nickName
    }).then(res => {
      promptAction.showToast({ message: '更新昵称成功' })
      AppStorage.Set('user', JSON.stringify(this.user))
    })
  }

  getUserInfo() {
    requestGet<{ avatar: string }>('userInfo').then(res => {
      this.user.avatar = res.data.avatar
      AppStorage.Set('user', JSON.stringify(this.user))
      this.loading = false
      promptAction.showToast({ message: '更新头像成功' })
    })
  }

  uploadAvatar() {
    try {
      this.loading = true
      // 2. 拷贝到应用沙箱中
      const context = getContext(this)
      const type = 'jpg'
      const filename = Date.now() + '.' + type
      const newFilePath = context.cacheDir + '/' + filename
      fs.open(this.URI, fs.OpenMode.READ_ONLY).then(file => {
        fs.copyFile(file.fd, newFilePath).then(() => {
          logger.info('copy success', newFilePath)
          // 3. 上传
          const config = {
            url: 'https://api-harmony-teach.itheima.net/hm/userInfo/avatar',
            method: 'POST',
            header: {
              'Accept': '*/*',
              'Authorization': `Bearer ${this.user.token}`,
              'Content-Type': 'multipart/form-data'
            },
            files: [{ name: 'file', uri: `internal://cache/` + filename, type, filename }],
            data: []
          }
          request.uploadFile(context, config, (err, data) => {
            if (err) return promptAction.showToast({ message: '更新头像失败' })
            data.on('progress', (size) => {
              logger.info(size.toString())
            })
            data.on('complete', (states) => {
              this.getUserInfo()
            })
          })
        }).catch(err => {
          logger.error('copy', JSON.stringify(err))
        })
      }).catch(err => {
        logger.error('open', JSON.stringify(err))
      })
    } catch (err) {
      logger.error(JSON.stringify(err))
    }
  }

  pickerAvatar() {

    const photoSelectOptions = new picker.PhotoSelectOptions()
    photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
    photoSelectOptions.maxSelectNumber = 1

    const photoViewPicker = new picker.PhotoViewPicker()
    photoViewPicker.select(photoSelectOptions).then(result => {
      // 1. 得到文件路径
      this.URI = result.photoUris[0]
      this.uploadAvatar()
    })
  }

  build() {
    Navigation() {
      Stack() {
        List() {
          ListItem() {
            Row() {
              Text('头像')
              Image(this.user.avatar || $rawfile('avatar.png'))
                .width(vp2vp(40))
                .width(vp2vp(40))
                .borderRadius(vp2vp(40))
                .border({ width: 0.5, color: '#e4e4e4' })
                .onError(() => {
                  this.user.avatar = $rawfile('avatar.png') as unknown as string
                })
                .onClick(() => {
                  this.pickerAvatar()
                })
            }.width('100%').height(vp2vp(60)).justifyContent(FlexAlign.SpaceBetween)
          }

          ListItem() {
            Row() {
              Text('昵称')
              TextInput({ text: this.user.nickName })
                .textAlign(TextAlign.End)
                .layoutWeight(1)
                .padding(0)
                .height(vp2vp(60))
                .backgroundColor(Color.White)
                .borderRadius(0)
                .onChange((value) => this.user.nickName = value)
                .onSubmit(() => {
                  this.updateNickName()
                })
            }.width('100%').height(60).justifyContent(FlexAlign.SpaceBetween)
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: vp2vp(45), right: vp2vp(45), top: vp2vp(15), bottom: vp2vp(15) })
        .divider({ strokeWidth: 0.5, color: '#f5f5f5' })

        if (this.loading) {
          Column() {
            LoadingProgress().width(vp2vp(100)).height(vp2vp(100)).color('#fff')
          }.width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('rgba(0,0,0,0.5)')
        }

      }.width('100%')
      .height('100%')
    }.title('完善个人信息').titleMode(NavigationTitleMode.Mini).mode(NavigationMode.Stack)
  }
}