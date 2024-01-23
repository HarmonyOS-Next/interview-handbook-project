export interface ProjectTag {
  tagName: string
}

export interface ProjectItem {
  id: number
  name: string
  icon: ResourceStr
  describeInfo: string | null
  tags: ProjectTag[]
}

export class ProjectItemModel implements ProjectItem {
  id: number
  name: string
  icon: ResourceStr
  describeInfo: string | null
  tags: ProjectTag[]

  constructor(model: ProjectItem) {
    this.id = model.id
    this.name = model.name
    this.icon = model.icon
    this.describeInfo = model.describeInfo
    this.tags = model.tags
  }
}

export const ProjectItemData: ProjectItem[] = [
  {
    id: 1,
    name: '后台管理系统',
    icon: $r('app.media.project02'),
    describeInfo: '以Vue技理后台后台管理系统面试题面试整理',
    tags: [{ tagName: '后台系统' }]
  },
  {
    id: 2,
    name: '在线问医生平台（医疗类）',
    icon: $r('app.media.project01'),
    describeInfo: '通过vue3+ts实现的在线医疗问诊相关技术整理',
    tags: [{ tagName: 'H5项目' }]
  },
  {
    id: 3,
    name: '鸿蒙知识点',
    icon: $r('app.media.project03'),
    describeInfo: '以 ArkTS 与 ArkUI 为主的鸿蒙基础知识点讲解',
    tags: [{ tagName: '鸿蒙应用' }]
  }
]
