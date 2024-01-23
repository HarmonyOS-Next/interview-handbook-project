import { preferences } from '@kit.ArkData'

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
    await this.store.put(this.KEY, JSON.stringify(user))
    await this.store.flush()
    AppStorage.setOrCreate(this.KEY, user)
  }

  async delUser() {
    await this.store.put(this.KEY, '{}')
    await this.store.flush()
    AppStorage.setOrCreate(this.KEY, {})
  }

  getUser() {
    return AppStorage.get<HdUser>(this.KEY) || {} as HdUser
  }
}

export const authStore = new AuthStore()