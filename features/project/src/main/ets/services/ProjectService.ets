import { hdHttp } from '@itcast/basic'
import { ProjectItemModel } from '../models/ProjectItemModel'

export class ProjectService {
  static findProjectList() {
    return hdHttp.get<ProjectItemModel[]>('question/type', new Object({ type: 'items' }))
  }
}