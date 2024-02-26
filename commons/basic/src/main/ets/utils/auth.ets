import { preferences } from '@kit.ArkData'
import { router } from '@kit.ArkUI'

export interface HdUser {
  id: string
  username: string
  avatar: string
  token: string
  refreshToken: string
  nickName?: string
  totalTime?: number
  clockinNumbers?: number
}

class AuthStore {
  KEY = 'authStore'
  store = preferences.getPreferencesSync(getContext(), { name: this.KEY })

  async setUser(user: HdUser) {
    AppStorage.setOrCreate('user', user)
    await this.store.put(this.KEY, JSON.stringify(user))
    await this.store.flush()
  }

  async delUser() {
    AppStorage.setOrCreate('user', {})
    await this.store.put(this.KEY, '{}')
    await this.store.flush()
  }

  initUser() {
    const json = this.store.getSync(this.KEY, '{}') as string
    AppStorage.setOrCreate('user', JSON.parse(json))
  }

  getUser() {
    return AppStorage.get<HdUser>('user') || {} as HdUser
  }

  checkAuth(options: router.RouterOptions | Function) {
    if (this.getUser().token) {
      if (typeof options === 'function') {
        options()
      } else {
        router.pushUrl(options)
      }
    } else {
      if (typeof options === 'function') {
        router.pushUrl({
          url: 'pages/LoginPage',
        })
      } else {
        const params = options.params as Record<string, string> || {}
        params.return_path = options.url
        router.pushUrl({
          url: 'pages/LoginPage',
          params: params
        })
      }
    }
  }
}

export const authStore = new AuthStore()