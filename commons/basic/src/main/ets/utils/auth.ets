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

export const AUTH_STORE_KEY = 'authStore'

class AuthStore {
  store: preferences.Preferences | null = null

  getStore() {
    if (!this.store) {
      this.store = preferences.getPreferencesSync(getContext(), { name: AUTH_STORE_KEY })
    }
    return this.store
  }

  async setUser(user: HdUser) {
    AppStorage.setOrCreate('user', user)
    await this.getStore().put(AUTH_STORE_KEY, JSON.stringify(user))
    await this.getStore().flush()
  }

  async delUser() {
    AppStorage.setOrCreate('user', {})
    await this.getStore().put(AUTH_STORE_KEY, '{}')
    await this.getStore().flush()
  }

  initUser() {
    const json = this.getStore().getSync(AUTH_STORE_KEY, '{}') as string
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