import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it } from '@ohos/hypium';
import JsonBigInt from '../main/ets';

export default function localUnitTest() {
  describe('localUnitTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    });
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    });
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    });
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });
    it('assertContain', 0, () => {
      // Defines a test case. This API supports three parameters: test case name, filter parameter, and test case function.
      // let a = 'abc';
      // let b = 'b';
      // // Defines a variety of assertion methods, which are used to declare expected boolean conditions.
      // expect(a).assertContain(b);
      // expect(a).assertEqual(a);
      interface User {
        id: number
        name: string
      }

      const str = `{ "id": 9489483248329483284, "name": "jack" }`
      const obj = JsonBigInt.parse(str) as User
      expect(obj.id.toString()).assertEqual('9489483248329483284')
      expect(obj.name).assertEqual('jack')
    });
  });
}