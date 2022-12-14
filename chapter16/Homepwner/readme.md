# chap16 오토레이아웃: 프로그래밍으로 제약조건 만들기


## 제약조건을 만드는 다른 방법 
제약조건을 비주얼 포맷 문자열로 만들 수 없는 경우가 있다. 예를 들어, 비율 기반의 제약조건을 만들 때는 비주얼포맷언어를 사용할 수 없다. 날짜 라벨의 높이를 이름 라벨의 높이에 두 배가 되게 하거나 이미지뷰의 너비를 항상 그 높이의 1.5배가 되도록 하는 경우처럼..   
이러한 경우에는 NSLayoutConstraint인스턴스를 만들 수 있다. 
+ (id) constraintWithItem: (id)view1
                attribute:(NSLayoutAttribute)attr1
                relatedBy:(NSLayoutRelation)relation
                   toItem:(id)view2
                attribute:(NSLayoutAttribute)attr2
                multiplier:(CGFloat)multiplier
                constant:(CGFloat)c   
이 메소드는 두 뷰 객체의 두 레이아웃 속성을 이용해 하나의 제약조건을 만든다. multipiler인자가 비율 기반의 제약조건을 만드는 핵심이다. constant는 간격 제약조건에서 사용했던 것처럼 고정된 포인트 숫자이다. 
