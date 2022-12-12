# chap8 UITableView와 UITableViewController

## UITableViewController
UITableView는 뷰 객체이다. iOS 개발자들이 열광적으로 따르는 모델-뷰-컨트롤러 디자인 패턴을 생각해보자 
- 모델 : 데이터를 저장하는 것으로 사용자 인터페이스에 대한 정보를 가지지 않는다.
- 뷰 : 사용자에게 보여지는 것으로 모델 객체에 대한 정보를 가지지 않는다.
- 컨트롤러 : 사용자 인터페이스와 모델 객체 간의 동기화를 위한 것이다. 프로그램의 흐름을 제어한다. 예를 들어, 컨트롤러는 실제로 데이터를 삭제하기 전에 "이 항목을 정말로 삭제합니까?" 와 같은 메시지를 보여주는 역활을 한다. 

## UITableView를 사용할때 테이블을 동작하기 위해 필요한 것들 
1. UITableView는 일반저긍로 화면에 표시되는 것들을 제어하기 위해 뷰 컨트롤러가 필요하다
2. UITableView는 데이터 소스(data source)가 필요하다. UITableView는 표시할 행의 갯수와 각 행에 표시할 데이터, 사용자 인터페이스를 만들기 위한 정보 등을 얻기 위해 데이터 소스를 요청한다. 데이터 소스가 없다면 테이블뷰는 빈 껍데기일 뿐이다.
2.UITableView의 data source는 UITableViewDataSource 프로토콜을 따르는 한 어떤한 objc 객체든 될 수 있다. 

3.UITableView는 일반적으로 UITableView와 관련된ㅇ 이벤트를 다른 객체에 알릴 수 있는 델리게이트가 필요하다. 델리게이트는 UITableViewDelegate 프로토콜을 따르는 한 어떤 객체든 될 수 있다.
4.UITableViewController 클래스의 인스턴스는 뷰 컨트롤러, 데이터 소스, 델리게이트의 세 가지 역활을 다할 수 있다.
5.UITableViewController는 UIViewController의 하위 클래스이기 때문에 view프로퍼티를 가진다. UITableViewController의 view는 언제나 UITableView의 인스턴스이고 UITableViewController는 UITableView의 준비와 표시를 제어한다.
6.UITableViewController가 자신의 뷰를 만들 때, UITableView의 dataSource와 delegate 인스턴스 변수는 자동으로 UITableViewController를 가리키도록 설정된다. 

## UITableViewController 하위 클래스 만들기 
UITableviewController의 지정 초기화 메소드는 테이블뷰의 스타일을 지정하는 상수를 받는 initWithStyle: 이다 이 스타일에는 UITableviewStylePlain과 UITableViewStyleGrouped의 두 가지 옵션이 있다. iOS6에서는 이 두가지 옵션이 매우 다르게 보였지만..
iOS7에서는 그 차이가 거의 줄어듬 (그럼 iOS16...에서는...????)

## 초기화 메서드의 두 가지 규칙 
상위 클래스의 지정 초기화 메소드를 호출.  
상위 클래스의 지정 초기화 메소드가 자신의 메소드를 호출하도록 재정의 함. 
...인데....음.. 이부분은 다시 확인해봐야함.. 

#### UITableViewController는 UIViewcontroller의 하위 클래스로 view 메소드를 상속받는다. 이 메소드는 아무것도 없을 때 빈 뷰 객체를 만들고 로드하는 loadView 메소드를 호출한다. UITableViewController의  view는 항상 UITableView 인스턴스이다. 따라서 UITableViewController에 view 메시지를 보내면 텅 빈 새 테이블뷰를 반환한다. 

## UITableView 데이터 소스 
코코아 터치에서 UITableView에 행을 제공하는 과정은 일반적인 절차형 프로그래밍 방식과 다르다. 절차형 방식에서는 테이블뷰에 무엇을 표시해야 할지 직접 알린다. 반면 코코아 터치에서 테이블뷰는 무엇을 표시해야할지 dataSource라는 별도의 객체에 물어본다. 여기서는 ItemsViewController가 데이터 소스이기 때문에 항목 정보를 저장할 방법이 필요하다 .    
2장에서 BNRItem 인스턴스들을 저장하는 데 NSMutableArray를 사용했다. 이 장에서도 동일하게 사용하지만 약간 복잡해짐. BNRItem 인스턴스들을 가진 NSMutableArray는 BNRItemStore 객체에서 가져올것이다. 왜 배열을 직접 사요ㅗㅇ하지는 않는걸까 ? 결국 BNRItemStore 객체가 항목들의 저장과 로드를 관리할 것이기 때문이다.   
어떤 객체가 모든 항목을 보길 원한다면 BNRItemStore에 그 항목들을 포함한 배열을 요청하게 될 것이다. 이 장 이후의 장들에서 배열의 조작을 책임지는 저장소를 만들 것이다. 항목 추가 및 삭제, 재배열 등의 명령을 처리할 것이다. 또한 디스크에서 항목을 불러오고 저장하는 역활을 할 것이다. 

## ItemStore 만들기 
ItemStore는 싱글톤 클래스이다. 이는 프로그램에서 이 객체에 대한 인스턴스가 오직 하나만 존재함을 뜻함. 이클래스는 다른 인스턴스를 만들려고 하면 조용히 기존 인스턴스를 반환할 것이다. 싱글톤은 여러 객체와 통신하는 객체를 가지고 있을 때 유용함. 그 객체들은 싱글톤클래스에 단일 인스턴스를 요청할수있음.   
ItemStore의 단일 인스턴스를 얻을려면 ItemStore 클래스에 shareStore 메시지를. 보내면 된다. 




