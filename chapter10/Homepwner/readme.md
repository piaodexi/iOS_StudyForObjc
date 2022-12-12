# chap10 UINavigationController 
앱에서 여러 정보 화면을 나타낼 때 UINavigationCotroller가 그 화면들의 스택을 관리한다. 각 화면 UIViewController의 view이고 그 스택은 뷰 컨트롤러의 배열이다. UIViewController가 스택 꼭대기에 있을 때 그 컨트롤러의 view가 보여진다.   
UINavigationController의 인스턴스를 초기화할 때 그 인스턴스에 UIViewController를 전해줘야 한다. 이 UIViewController가 내비게이션 컨트롤러의 루트 뷰 컨트롤러이다. 루트 뷰 컨트롤러는 항상 스택의 맨 바닥에 놓인다. 프로그램 실행 중에 더 많은 뷰 컨트롤러를 UINavigationController의 스택 꼭대기에 푸시할 수 있다.   
UIViewController가 스택에 푸시되면 그 컨트롤러의 view가 오른쪽에서부터 화면에 나타난다. 스택이 팝 되면 맨위의 뷰컨트롤러가 스택에서 제거되고 그 view는 오른쪽으로 사라진다. 그리고 스택의 다음 뷰 컨트롤러의 view가 나타난다. 

- UINavigationController는 UITabBarController와 마찬가지로 viewControllers 배열을 가진다. 루트 뷰 컨트롤러는 이 배열의 첫 번째 객체이다. 뷰 컨트롤러들을 스택에 더 넣을 때마다 이 배열의 끝에 추가된다. 따라서 배열의 마지막 뷰 컨트롤러는 스택의 꼭대기가 된다. UINavigationController의 topViewController 프로퍼티는 스택의 꼭대기를 가리키는 포인터이다.   
- UINavigationController는 UIViewController의 하위 클래스이기 때문에 자기 소유의 view를 가진다. 그 view는 항상 두 개의 하위뷰를 가진다. UINavigationBar와 topViewController의 뷰이다 . 탑뷰컨트롤러의 뷰를 윈도우의 하위뷰로 만들기 위해 내비게이션 컨트롤러를 윈도우의 루트뷰 컨트롤러로 설정할 수 있다. 

## 추가적인 UIViewController 

## 뷰 컨트롤러 간에 데이터 전달하기 

## 뷰 나타내기와 숨기기 
UINavigationController가 뷰를 교체하기 직전에 viewWillDisappear:와 viewWillAppear: 라는 두 개의 메시지를 보낸다. 그리고 유아이뷰 컨트롤러가 스택에서 사라질때 뷰윌디사어피어 메시지를 보낸다. 스택 꼭대기에 있는 유아이뷰컨트롤러가 뷰윌어필어 메시지를 받는다.   
디테이뷸컨트롤러가 스택에서 나올 때 item의 프로퍼티들을 텍스트 필드의 내용으로 설정할 것이다. 뷰가 나타나거나 사라질 때 호출되는 메소드를 구현할때 상위 클래스의 구현을 호출하는것은 중요하다. 

