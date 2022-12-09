#chap8 UITableView와 UITableViewController

##UITableViewController
UITableView는 뷰 객체이다. iOS 개발자들이 열광적으로 따르는 모델-뷰-컨트롤러 디자인 패턴을 생각해보자 
- 모델 : 데이터를 저장하는 것으로 사용자 인터페이스에 대한 정보를 가지지 않는다.
- 뷰 : 사용자에게 보여지는 것으로 모델 객체에 대한 정보를 가지지 않는다.
- 컨트롤러 : 사용자 인터페이스와 모델 객체 간의 동기화를 위한 것이다. 프로그램의 흐름을 제어한다. 예를 들어, 컨트롤러는 실제로 데이터를 삭제하기 전에 "이 항목을 정말로 삭제합니까?" 와 같은 메시지를 보여주는 역활을 한다. 

##UITableView를 사용할때 테이블을 동작하기 위해 필요한 것들 
1. UITableView는 일반저긍로 화면에 표시되는 것들을 제어하기 위해 뷰 컨트롤러가 필요하다
2. UITableView는 데이터 소스(data source)가 필요하다. UITableView는 표시할 행의 갯수와 각 행에 표시할 데이터, 사용자 인터페이스를 만들기 위한 정보 등을 얻기 위해 데이터 소스를 요청한다. 데이터 소스가 없다면 테이블뷰는 빈 껍데기일 뿐이다.
2.UITableView의 data source는 UITableViewDataSource 프로토콜을 따르는 한 어떤한 objc 객체든 될 수 있다. 

3.UITableView는 일반적으로 UITableView와 관련된ㅇ 이벤트를 다른 객체에 알릴 수 있는 델리게이트가 필요하다. 델리게이트는 UITableViewDelegate 프로토콜을 따르는 한 어떤 객체든 될 수 있다.
4.UITableViewController 클래스의 인스턴스는 뷰 컨트롤러, 데이터 소스, 델리게이트의 세 가지 역활을 다할 수 있다.
5.UITableViewController는 UIViewController의 하위 클래스이기 때문에 view프로퍼티를 가진다. UITableViewController의 view는 언제나 UITableView의 인스턴스이고 UITableViewController는 UITableView의 준비와 표시를 제어한다.
6.UITableViewController가 자신의 뷰를 만들 때, UITableView의 dataSource와 delegate 인스턴스 변수는 자동으로 UITableViewController를 가리키도록 설정된다. 
