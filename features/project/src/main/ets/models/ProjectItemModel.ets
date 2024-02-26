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
    id: 3,
    name: '鸿蒙知识点',
    icon: $r('app.media.project03'),
    describeInfo: '以 ArkTS 与 ArkUI 为主的鸿蒙基础知识点讲解',
    tags: [{ tagName: '鸿蒙应用' }]
  }
]
