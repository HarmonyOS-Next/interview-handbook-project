import { TabBarModel } from '../models/TabBarModel'

export const TabBarItems: TabBarModel[] = [
  // {
  //   defaultIcon: $r('app.media.ic_tabbar_home'),
  //   activeIcon: $r('app.media.ic_tabbar_home_select'),
  //   label: '首页'
  // },
  // {
  //   defaultIcon: $r('app.media.ic_tabbar_project'),
  //   activeIcon: $r('app.media.ic_tabbar_project_select'),
  //   label: '项目'
  // },
  // {
  //   defaultIcon: $r('app.media.ic_tabbar_interview'),
  //   activeIcon: $r('app.media.ic_tabbar_interview_select'),
  //   label: '面经'
  // },
  // {
  //   defaultIcon: $r('app.media.ic_tabbar_mine'),
  //   activeIcon: $r('app.media.ic_tabbar_mine_select'),
  //   label: '我的'
  // }
  {
    defaultIcon: $r('app.media.tabbar_home'),
    activeIcon: $r('app.media.tabbar_home_fill'),
    label: '首页'
  },
  {
    defaultIcon: $r('app.media.tabbar_project'),
    activeIcon: $r('app.media.tabbar_project_fill'),
    label: '项目'
  },
  {
    defaultIcon: $r('app.media.tabbar_interview'),
    activeIcon: $r('app.media.tabbar_interview_fill'),
    label: '面经'
  },
  {
    defaultIcon: $r('app.media.tabbar_mine'),
    activeIcon: $r('app.media.tabbar_mine_fill'),
    label: '我的'
  }
]