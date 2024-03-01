import { preferences } from '@kit.ArkData'

class HistoryStore {
  KEY = 'historyStore'
  store = preferences.getPreferencesSync(getContext(), { name: this.KEY })

  setItem(keyword: string) {
    this.store.put(keyword, keyword)
  }

  delItem(keyword: string) {
    this.store.deleteSync(keyword)
  }

  clear() {
    this.store.clearSync()
  }

  getAll() {
    const obj = this.store.getAllSync()
    return Object.keys(obj)
  }
}

export const historyStore = new HistoryStore()