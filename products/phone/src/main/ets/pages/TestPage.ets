import { logger } from '@itcast/basic';
import { ble } from '@kit.ConnectivityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct TestPage {
  @State message: string = 'Hello World';

  onPageShow(): void {
    const onReceiveEvent = (data: Array<ble.ScanResult>) => {
      logger.info('BLE scan device find result = ' + JSON.stringify(data));
    }
    try {
      ble.on("BLEDeviceFind", onReceiveEvent);
      let scanOptions: ble.ScanOptions = {
        interval: 500,
        dutyMode: ble.ScanDuty.SCAN_MODE_LOW_POWER,
        matchMode: ble.MatchMode.MATCH_MODE_AGGRESSIVE,
      }
      ble.startBLEScan(null, scanOptions)
    } catch (err) {
      logger.error('errCode: ' + (err as BusinessError).code + ', errMessage: ' + (err as BusinessError).message);
    }

  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}