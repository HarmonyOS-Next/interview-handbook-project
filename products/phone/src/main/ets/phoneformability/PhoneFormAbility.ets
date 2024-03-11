import { formBindingData, FormExtensionAbility, formInfo } from '@kit.FormKit';
import { Want } from '@kit.AbilityKit';
import { authStore } from '@itcast/basic';

export interface CardData {
  formId: string
  token: string
  clockinNumbers: number
}

export default class PhoneFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    // Called to return a FormBindingData object.
    const user = authStore.getUser()
    const formId = want.parameters?.[formInfo.FormParam.IDENTITY_KEY]
    const data: CardData = {
      formId: formId ? formId.toString() : '',
      token: user.token || '',
      clockinNumbers: user.clockinNumbers || 0
    }
    return formBindingData.createFormBindingData(data);
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.

  }

  onChangeFormVisibility(newStatus: Record<string, number>) {
    // Called when the form provider receives form events from the system.
  }

  onFormEvent(formId: string, message: string) {
    // Called when a specified message event defined by the form provider is triggered.
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
};