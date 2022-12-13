//
//  ItemsViewController.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "ItemsViewController.h"
#import "BNRItem.h"
#import "ItemStore.h"
#import "DetailViewController.h"
@interface ItemsViewController ()
/**
 headerView가 strong 프로퍼티 인것은 xib 파일에서 상위 레벨 객체가 되기 때문이다. 객체에 약한 참조를 사용하면 그 상위레벨 객체에 의해 직간접적으로 소유된다.
 */
@property (nonatomic, strong) IBOutlet UIView *headerView;
@end

@implementation ItemsViewController
/**
  이 게터 메소드는 단순히 해당 객체를 가져오는 것보다 더많은 일을함. 이것은 흔히 사용되는 패턴인 지역인스턴스화 (lazy instantiation)이다. 이 패턴은 실제로 객체가 필요할 때까지 그 객체의 생성을 미룬다. 일부 경우에 이러한 접근은 앱의 일반적인 메모리 사용량을 현저히 줄일 수 있다.
 코드를 보면 파일명에 확장자를 사용하지 않았다. 이것은 NSBundle이 알아내기 때문이다. 또한 self를 xib파일의 소유자로 전달한다. 이것은 실행 시에 메인 NSBundle이 nib파일을 분석할때 ItemsViewController 인스턴스를 xib 파일의 File's Owner로 설정한다.
 ItemsViewController가 처음 headerview 메시지를 받으면 headerview.xib을 로드하고 headerview 인스턴스 변수에서 뷰 객체에 대한 포인터를 유지하게 된다. 버튼들은 사용자가 탭할 때 itemsviewcontroller에 메시지를 보낸다.
 */
- (UIView *)headerView
{
    //headerView가 아직 로드되지 않았다면
    if (!_headerView) {
        //headerView.xib을 로드한다.
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    return _headerView;
}
// 다른 메소드
- (IBAction)addNewItem:(id)sender
{
    //0번 섹션의 마지막 행의 인덱스 패스를 만든다 .
    /**
     에러가 난다. 궁극적으로 UITableView의 dataSource가 테이블뷰에 표시할 행의 수를 결정한다는 사실을 기억해야한다. 새로운 행을 삽입한 후에 테이블뷰는 총 6개의 행을 가진다 (5개에서 1개를 더한것이다) 그러고 나서 다시 dataSource에 표시할 행의 갯수를 요청한다. itemsviewcontroller는 저장소에 물러 다섯 행을 반환하게 된다. 그러면 uitableview는 잘못됫다고 예외를 던진다. uitableview와 그 dataSource가 행의 수에 동의하는지 확인해야한다.
     */
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[ItemStore sharedStore] createItem];
    
    //배열에서 이 항목의 위치를 계산한다.
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //테이블에 새로운 행을 삽입한다.
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}
- (IBAction)toggleEditingMode:(id)sender
{
    //현재 편집 모드에 있다면 ...
    if (self.isEditing) {
        //사용자에게 상태를 알리기 위해 버튼 텍스트를 변경한다.
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // 편집 모드를 닫는다
        [self setEditing:NO animated:YES];
    } else {
        //사용자에게 상태를 알리기 위해 버튼 텍스트를 변경한다.
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        //편집 모드로 들어간다.
        [self setEditing:YES animated:YES];
    }
}
- (instancetype) init
{
    //상위 클래스의 지정 초기화 메소드를 호출한단
    self = [super initWithStyle:UITableViewStylePlain];
    //ItemStore에 임의의 품목 5개를 추가함
    if (self != nil) {
        //navigationItem의 title을 Homepwner로 설정하다록한다.
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        //ItemViewController에 addNewItem: 메시지를 보낼 새 바 버튼 아이템을 만든다.
        /**
         액션은 SEL 타입의 값으로 전달된다. SEL 데이터 타입은 셀렉터의 포인터이고 셀렉터는 콜론을 포함한 메시지 전체이름이다. @selector()는 반환 타입, 인자 타입, 인자 이름을 신경 쓰지 않는다는 것에 주의 해야 한다.
         */
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
    target:self
    action:@selector(addNewItem:)];
    // 이 바 버튼 아이템을 navigationItem의 오른쪽 아이템으로 설정한다.
        navItem.rightBarButtonItem = bbi;
        
    //네비게이션바에서 편집 버튼을 얻는데 필요한 코드
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //테이블뷰에 헤더뷰를 알린다.
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc] init];
    /**
     루트 뷰 컨트롤러에서 모든 데이터를 가지고 다음 UIViewController에 그 데이터의 하위셋을 전달하는 것이 ㅇ깔끔한 방법이다. 
     */
    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    //상세뷰 컨트롤러에 선택된 item 객체에 대한 포인터를 준다.
    dvc.item = selectedItem;
    
    //네비게이션 컨트롤러 스택 꼭대기에 방금 생성한 컨트롤러를 푸시한다.
    [self.navigationController pushViewController:dvc animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//UITableView에 표시할 행의 개수를 나타내는 정수값을 반환함.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[ItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //기본 모양을 가진 UITableViewCell 인스턴스를 만든다.
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    // 새로운 셀 혹은 재활용 셀을 얻어온다.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //셀에 allItems 배열 n번째 항목의 description을 텍스트로 설정한다.
    //이 셀은 테이블뷰의 n번째 행에 나탄다.
    NSArray *items = [[ItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    
    return cell;
}
//uitableviewDataSource 프로토콜의 commitEditingStyle 메소드는 itemsViewcontroller에 보내진다 그리고 itemStore가 데이터를 보관하는동안 뷰컨트롤러는 데이블뷰의 데이터소스임을 명심해야한다.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //테이블뷰가 삭제 명령을 보내도록 요청하면..
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
        //에니메이션과 함깨 테이블뷰에서 해당 행을 삭제한다.
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
