# chap11 카메라 

## 이미지 표시하기와 UIImageView

## 사진 찍기와 UIImagePickerController
takePicture: 메소드는 UIImagePickerController의 인스턴스를 만들고 그것을 화면에 나타낸다. UIImagePickercontroller의 인스턴스를 만들때 sourceType 프로퍼티를 설정해야 한다. 그리고 UIImagePickerController의 델리게이트도 할당해야 한다.   
이미지 피커의 sourceType 설정하기 
sourceType은 이미지 피커에게 어디서 이미지를 얻을지 알려주는 상수이다. 다음과 같은 3가지 값이 있다.   
UIImagePckercontrollerSourceTypeCamera   
tkdydwkrk to tkwlsdmf Wlrdmf rjtdlek.   
   
UIImagePckerControllerSourceTypePhotoLibrary   
사용자에게 앨범을 선택하는 화면과 그 앨범에서 사진을 선택하는 화면이 나타난다.   
   
UIImagePickerControllerSourceTypeSavePhotosAlbum   
사용자가 최근에 찍은 사진을 선택한다.   

첫번째 소스 타입인 UIImagePickerControllerSourceTypeCamera는 카메라가 없는 장치에서는 동작하지 않는다. 따라서 이 타입을 사용하기전에 UIImagePickercontroller 클래스에서 isSourceTypeAvailable 메시지를 보내 카메라 유무를 확인해야 한다.   
+ (BOOL)isSourceTypeAvailable:(UIImagePckerControllerSourceType) sourceType;   
이 메시지를 보내면 전달된 소스타입을 해당 장비가 지원하는지 여부를 Boolean 값으로 반환한다.   
DetailViewController.m에서 takePicture: 스텁을 찾아 이미지 피커를 만들고 sourceType을 설정하도록 다음 코드를 추가한다. 

## 이미지 피커의 델리게이트 설정하기 
UIImagePIckerController 인스턴스는 소스 타입 외에 추가로 델리게이트가 필요하다. 사용자가 UIImagePickerController의 인터페이스에서 이미지를 선택하면 그 델리게이트에 의해 imagePickercontroller:didFinishPickingMediaWithInfo: 메시지가 보내진다. ( 만약 취소 버튼을 누르면 델리게이트는 imagePickerControllerDidCancel: 메시지를 받는다.) 여기서 이미지 피커의 델리게이트는 DetailViewController의 인스턴스가 될 것이다. 

## 이미지 피커 모달로 띄우기 
유아이이미지피커컨트롤러가 소스타입과 델리게이트를 가졌다면, 이제 화면에 뷰를 얻을 차례이다. 이전에 사용했던 유아이뷰컨트롤러의 하위 클래스들과 달리 유아이이미지 ㅍ피커컨트롤러의 인스턴스는 모달 방식으로 나타낸다. 모달 뷰 컨트롤러는 그 작업이 끝날 때까지 화면 전체를 사용한다. 뷰컨트롤러를 모달로 나타내려면 presentViewController:animated:completion 메시지를 화면에 나타낼 view의 UIViewController에 보내야 한다. 나타낼 뷰 컨트롤러를 전달하면 그 뷰 컨트롤러의 뷰가 화면 아래에서 슬라이드 하면서 나타날 것이다. 

- This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.   
위와 같은 에러가 발생한다. 오래된 버전에서 작성된 내용이라 당시엔 뭐 잘됫나 본데 ..지금은 안되나 보다. info.plist에서 NSCameraUsageDescription를 추가해주면 된다. 

## 이미지 저장하기 

이미지를 하나 선택하면 UIImagePIckerController가 사라지고 다시 상세뷰로 돌아간다. 일단 이미지 피커가 사리지고 나면 더 이상 그 사진에 대해 참조하지 못한다. 이문제를 해결하기위해 imagePickercontroller:didFinishPickingMediaWithInfo: 델리게이트 메소드를 구현할 것이다. 이 메시지는 사진을 선택할 때 이미지 피커의 델리게이트에 보내진다. 
