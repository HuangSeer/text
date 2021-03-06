//
//  TrusteeshipViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/6/27.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AddSJViewController.h"
#import "PchHeader.h"
#import "ZYQAssetPickerController.h"
#import "CollectionViewCell.h"
#import "AddsjCollectionReusableView.h"
#import "PchHeader.h"
#import "PWDViewController.h"
#import "BDImagePicker.h"
#import "AFHTTPSessionManager.h"
#import "AddCollectionViewCell.h"

@interface AddSJViewController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSData *imageData;
    NSString *fileName;
    //   UITableView *_tableView;
    NSArray *arrimage;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    AddsjCollectionReusableView *cellheader1;
    NSMutableArray *mutaArray;
    NSString *stringurl;
     NSString *strcookie;
    NSString *hedimg;
}

@property (nonatomic ,strong) UIButton *button;
@property (nonatomic ,strong) ZYQAssetPickerController *pickerController;
@property (nonatomic ,strong) UICollectionView *collectionView;


@property (nonatomic ,strong) NSMutableArray *imageArray;
@property (nonatomic ,strong) NSMutableArray *imageDataArray;

@property (nonatomic ,assign) NSInteger i;
@end

@implementation AddSJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];

    //    [self initTableView];
    //返回按钮
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    self.i = 0;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[AddCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    [self.view addSubview:self.collectionView];
    self.navigationItem.title=@"添加事件详情";
    
    
    // Do any additional setup after loading the view.
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        //        flowLayOut.minimumInteritemSpacing = 11;
        //        flowLayOut.minimumLineSpacing = 11;
        flowLayOut.itemSize = CGSizeMake(55, 55);
        flowLayOut.sectionInset = UIEdgeInsetsMake(11, 11, 0, 11);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-30) collectionViewLayout:flowLayOut];
        [_collectionView registerClass:[AddsjCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddsjCollectionReusableView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
    }
    return _collectionView;
}
- (NSMutableArray *)imageDataArray{
    if (!_imageDataArray) {
        self.imageDataArray = [NSMutableArray array];
    }
    return _imageDataArray;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
        
    }
    return _imageArray;
}

- (ZYQAssetPickerController *)pickerController{
    if (!_pickerController) {
        self.pickerController = [[ZYQAssetPickerController alloc] init];
        _pickerController.maximumNumberOfSelection = 6;
        _pickerController.assetsFilter = ZYQAssetsFilterAllAssets;
        _pickerController.showEmptyGroups=NO;
        _pickerController.delegate=self;
        _pickerController.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([(ZYQAsset*)evaluatedObject mediaType]==ZYQAssetMediaTypeVideo) {
                NSTimeInterval duration = [(ZYQAsset*)evaluatedObject duration];
                return duration >= 5;
            } else {
                return YES;
            }
            
            
        }];
        
    }
    return _pickerController;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        cellheader1 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"AddsjCollectionReusableView" forIndexPath:indexPath];
        cellheader1.frame=CGRectMake(0, 0, Screen_Width, Screen_height/1.55);
        return cellheader1;
        
    }else{
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
        UIButton *TijiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        TijiaoButton.frame = CGRectMake(100, 20, Screen_Width-200, 30);
        [TijiaoButton setTitle:@"提  交" forState:UIControlStateNormal];
        TijiaoButton.backgroundColor =[UIColor redColor];
        [TijiaoButton setFont:[UIFont systemFontOfSize:14.0f]];
        [TijiaoButton.layer setMasksToBounds:YES];
        [TijiaoButton.layer setCornerRadius:5.0];
        TijiaoButton.tag=120;
        [TijiaoButton addTarget:self action:@selector(TijiaoButtonsd) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:TijiaoButton];
        footerView.backgroundColor = [UIColor clearColor];
        return footerView;
    }
    
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(Screen_Width, 40);
    
}
//设置header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(Screen_Width, Screen_height/1.55);
    
    
}
-(void)submitPictureToServer{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选取" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }
}


#pragma mark ---------collectionView代理方法--------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.imageArray.count + 1 ;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    if (self.imageArray.count == 0) {
        return cell1;
    }else{
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        if (indexPath.item + 1 > self.imageArray.count ) {
            return cell1;
        }else{
            cell.imageV.image = self.imageArray[indexPath.item];
            [cell.imageV addSubview:cell.deleteButotn];
            cell.deleteButotn.tag = indexPath.item + 100;
        }
        
        
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item + 1 > self.imageArray.count ) {
        [self submitPictureToServer];
    }else{
        ImageViewController *imageViewC =[[ImageViewController alloc] init];
        //取出存储的高清图片
        imageViewC.imageData = self.imageDataArray[indexPath.item];
        [self presentViewController:imageViewC animated:YES completion:nil];
    }
    
}

#pragma mark --------删除图片-----------

- (void)deleteImage:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    //    NSLog(@"index=%ld",index);
    //    NSLog(@"+++%ld",self.imageDataArray.count);
    //    NSLog(@"---%ld",self.imageArray.count);
    
    //移除显示图片数组imageArray中的数据
    [self.imageArray removeObjectAtIndex:index];
    //移除沙盒数组中imageDataArray的数据
    [self.imageDataArray removeObjectAtIndex:index];
    
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取Document文件的路径
    NSString *collectPath = filePath.lastObject;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //移除所有文件
    [fileManager removeItemAtPath:collectPath error:nil];
    //重新写入
    for (int i = 0; i < self.imageDataArray.count; i++) {
        NSData *imgData = self.imageDataArray[i];
        [self WriteToBox:imgData];
    }
    
    [self.collectionView reloadData];
    
    
}
///更改图片大小
- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
#pragma mark ------相册回调方法----------

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    mutaArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"assets%@",assets);
    //    [self.imageDataArray addObjectsFromArray:assets];
    //移除显示图片数组imageArray中的数据
    [self.imageArray removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i=0; i<assets.count; i++) {
            ZYQAsset *asset=assets[i];
            [asset setGetFullScreenImage:^(UIImage *result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [self OriginImage:result scaleToSize:CGSizeMake(800, 800)];
                    [self.imageArray addObject:image];
                    //由于iphone拍照的图片太大，直接存入数组中势必会造成内存警告，严重会导致程序崩溃，所以存入沙盒中
                    //压缩图片，这个压缩的图片就是做为你传入服务器的图
                                        if (assets.count > 0. && assets.count < 1.0f) {
                                            imageData = UIImageJPEGRepresentation(result, assets.count*0.5f);
                                        }else{
                                            imageData = UIImageJPEGRepresentation(result, 0.5f);
                                        }
                                        [self.imageDataArray addObject:imageData];
                    //
                    
                    //
                    [self WriteToBox:imageData];
                    //添加到显示图片的数组中
                    [self.collectionView reloadData];
                    
                });
                
            }];
        }
        
    });
    [self dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
        [self intlaod];
    }];
    
}
-(void)intlaod{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    //序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urls=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/uploadEventImg.do"];
    NSDictionary *dics=@{
                         @"Cookie":strcookie,
                         @"Content-Type":@"multipart/form-data"
                         };
    NSURLSessionDataTask *task =[manager POST:urls parameters:dics constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i =0; i <self.imageArray.count; i++) {
            NSLog(@"%ld=====%d",self.imageArray.count,i) ;
            imageData = UIImageJPEGRepresentation(self.imageArray[i] ,1.0f);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            fileName= [NSString stringWithFormat:@"%@.jpg", str];
            NSLog(@"fileName=====%@",fileName);
            [formData appendPartWithFileData:imageData name:@"mFile" fileName:fileName mimeType:@"image/jpg"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *testString =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *jsonData = [testString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        NSString *Status= [jsonDict objectForKey:@"Status"];
        hedimg=[jsonDict objectForKey:@"path"];
        NSLog(@"hedimg=====%@",hedimg);
        NSString *strurls=[NSString stringWithFormat:@"%@%@",URL,hedimg];
        
        [mutaArray addObject:strurls];
        //把数组里的值拼接在一起
        stringurl= [mutaArray componentsJoinedByString:@","];
        
        int aa=[Status intValue];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//选择图片上限提示
-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"到达6张图片上限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark --------存入沙盒------------
- (void)WriteToBox:(NSData *)imageData{
    
    _i ++;
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取Document文件的路径
    NSString *collectPath = filePath.lastObject;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:collectPath]) {
        
        [fileManager createDirectoryAtPath:collectPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    //    //拼接新路径
    NSString *newPath = [collectPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Picture_%ld.png",_i]];
    
    [imageData writeToFile:newPath atomically:YES];
}

#pragma mark -----改变显示图片的尺寸----------
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)TijiaoButtonsd{
   int  lxid= [cellheader1.lxid intValue];
    int  djid= [cellheader1.djid intValue];
    int  lyid= [cellheader1.lyid intValue];
     int  zdid= [cellheader1.zdid intValue];
    if (lxid!=nil&&djid!=nil&&lyid!=nil&&cellheader1.textFile.text.length!=0) {
        [SVProgressHUD showWithStatus:@"加载中"];
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/addNewEventInfo.do?eventLevelId=%d&sourceTypeId=%d&eventTypeId=%d&eventTitle=%@&eventContent=%@&isImportant=%d&eventPic=%@Cookie=%@",lxid,djid,lyid,cellheader1.textFile.text,cellheader1.textView.text,zdid,hedimg,strcookie];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"data========%@",data);
//        NSArray *titles=[data objectForKey:@"data"];
        NSString *strtx=[data objectForKey:@"message"];
        
        [SVProgressHUD  showSuccessWithStatus:strtx];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

    
    }else{
    
      [SVProgressHUD showErrorWithStatus:@"你给的信息有误，请检查"];
    
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
