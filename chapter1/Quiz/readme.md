#  Quiz

- Quiz 앱 설계하기
 
- 4개의 뷰 객체: UILable 인스턴스 2개 ,UIButton 인스턴스 2개
 
- 2개의 컨트롤러 객체 : AppDelegate 인스턴스와 QuizViewController 인스턴스
 
- 2개의 모델 객체:  NSMutableArray 인스턴스 2개 

NIB파일이란 
xib 파일을 사용하여 프로그램을 빌드하면 xib파일은 nib 파일로 컴파일된다.
nib 파일은 앱에서 해석하는 더 작고 간단한 형태이다.
nib 파일은 앱의 번들(bundle)로 복사된다.
번들은 앱의 실행 파일과 기타 리소스 파일을 가지고 있는 디렉터리이다. 

앱을 실행하면 인터페이스가 필요한 시점에 앱이 nib파일을 읽어들인다. 

quiz 앱은 하나의 xib 파일을 가지고 있기 때문에 번들 안에는 하나의 nib파일만 존재한다.
quiz의 nib 파일은 프로그램이 처음 실행될 때 불러오게 된다.
좀 더 복잡한 프로그램은 여러 nib 파일을 가지며 필요시에 불러오게 된다.

-예제 프로젝트 셋팅방법 
info.plist에서 Application Scene Manifest 항목을 삭제
SceneDelegate.h, SceneDelegate.m 삭제
AppDelegate 클래스에서 configurationForConnectingSceneSession, didDiscardSceneSessions 메서드를 삭제
AppDelegate.h에 프로퍼티를 선언 @property (nonatomic, strong) UIWindow *window;

-AppDelegate란 
앱 델리게이트는 앱을 위해 하나의 최상위 UIWIndow를 관리한다. ( ?? 씬딜리게이트 생기고 나서는 그짝에 프로퍼티가 생성됬는데?? 엣날이야기인가보다)
화면에서 quizviewcontroller를 얻을려면 이 원도우의 루트 뷰 컨트롤러로 만들어야 한다. 

앱이 사용자에게 보여지기 직전 앱 딜리게이트는 application:didFinishLaunchingWithOption: 메시지를 받는다. 이는 프로그램이 동작하기 위한 준비과정이다. 

어찌됫든 일케 하면 앱이 실행할 대마다 QuizViewController의 인스턴스가 만들어질 것임. 
그러고 나서 이 인스턴스는 QuizViewController.xib 파일이 컴파일된 NIB 파일의 로딩이 끝나면 initWithNibName:bundle: 메시지를 받고 모델 객체를 생성한다. 





 

