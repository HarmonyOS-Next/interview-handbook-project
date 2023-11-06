import router from '@ohos.router'
import { PAGE_MAP } from '../constants';
import { UserInfo } from '../models';


const list = ['pages/Index', 'pages/LoginPage']

const push = (options: router.RouterOptions) => {
  const user = JSON.parse(AppStorage.Get('user') || '{}') as UserInfo
  if (!list.includes(options.url) && !user.token) {
    return router.pushUrl({ url: PAGE_MAP.login, params: { ...options.params, to: options.url } })
  }
  return router.pushUrl(options)
}

export default {
  push
}