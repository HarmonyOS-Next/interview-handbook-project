import UIAbility from '@ohos.app.ability.UIAbility';
import logger from '../utils/logger';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    logger.info('Ability onCreate');
  }

  onDestroy() {
    logger.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    logger.info('Ability onWindowStageCreate');

    // 设置状态栏
    windowStage.getMainWindow((err, windowClass)=>{
      if (err.code) {
        logger.error('Failed to load the Window. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      windowClass.setWindowSystemBarProperties({
        statusBarColor: '#ffffff',
        statusBarContentColor: '#000000'
      })
    })

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      logger.info('Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    logger.info('Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    logger.info( 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    logger.info('Ability onBackground');
  }
}
