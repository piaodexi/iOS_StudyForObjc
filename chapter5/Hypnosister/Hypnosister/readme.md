
#chap5 뷰 다시 그리기와 UIScrollView

- 여기서는 뷰가 이벤트에 반응하여 어떻게 다시 그려지는지... 특히 Hypnosister 앱을 수정하여 사용자가 HypnosisView 뷰를 터치할 때 그 원의 색상이 바뀌도록 할 것이다. 색상을 변경하면 뷰는 자신을 다시 그리도록 요청받는다. 그리고 이 장 후반부에서 UIScrollView를 Hypnosister의 뷰 계층에 추가할 것이다.   
첫 단계는 색상 프로퍼티를 선언하는 것이다.   

## 런 루프와 뷰 다시 그리기 
iOS 앱이 실행되면 런 루프가 시작된다. 런 루프의 역활은 터치 등의 이벤트를 대기하는 것이다. 런 루프는 이벤트가 발생하면 그 이벤트에 관한 적당한 핸들러 메소드를 찾는다. 그 핸들러 메소드는 해당 기능을 수행하는 다른 메소드들을 부른다. 메소드가 모두 완료 되면 제어는 다시 런 루프로 돌아간다.   
런루프가 다시 제어권을 얻으면 갱신해야 할 뷰 ("dirty view") 목록을 확인한다. 이 뷰들은 가장 최근 이벤트 처리과정해서 발생한 내용들을 기반으로 다시 그려져야 한다. 그래서 런 루프는 뷰 계층의 모든것이 다시 합성되기 전에 이 목록에 있는 뷰들에 drawRect: 메시지를 보낸다.   
필요한 뷰만 다시 그리고 이벤트마다 drawRect:를 보내는 이 두 최적화 작업은 iOS 인터페이스에 즉각적으로 반응하도록 해준다. 만약iOS앱이 이벤트가 처리될때마다 모든 뷰를 다시 그려야 한다면 불필요한 작업에 많은 시간을 낭비하게 된다. 런 루프 사이클의 끝에서 뷰의 갱신을 일괄 처리하는 것은 단일 이벤트에서 그 프로퍼티가 여러 번 바뀌어 불필요하게 여러 번 뷰가 다시 그려지는 것을 막기 위함이다. 

##패닝과 페이징
스크롤뷰의 또 다른 활용법은 여러 뷰 인스턴스 간의 패닝(panning)이다.


