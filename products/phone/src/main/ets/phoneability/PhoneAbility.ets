import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { rpc } from '@kit.IPCKit';
import { logger } from '@itcast/basic';
import { emitter } from '@kit.BasicServicesKit';

class MyParcelable implements rpc.Parcelable {
  marshalling(dataOut: rpc.MessageSequence): boolean {
    return true
  }

  unmarshalling(dataIn: rpc.MessageSequence): boolean {
    return true
  }
}

export default class PhoneAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    logger.info('Ability onCreate')
    AppStorage.setOrCreate('initColorMode', this.context.config.colorMode)
    // call form
    try {
      this.callee.on('clock_in', (data: rpc.MessageSequence) => {
        logger.info('clock_in', data.readString())
        return new MyParcelable()
      })
    } catch (e) {
      logger.error('call form', e.message)
    }
    // router form
    emitter.emit({
      eventId: 10000
    }, {
      data: {
        activeIndex: want.parameters?.page === 'interview' ? 2 : 0
      }
    })
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    logger.info('Ability onNewWant')
    // router form
    emitter.emit({
      eventId: 10000
    }, {
      data: {
        activeIndex: want.parameters?.page === 'interview' ? 2 : 0
      }
    })
  }

  onDestroy(): void {
    logger.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info('Ability onWindowStageCreate');

    windowStage.loadContent('pages/BootPage', (err, data) => {
      if (err.code) {
        logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      logger.info('Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');

    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    logger.info('Ability onBackground');
  }
}
