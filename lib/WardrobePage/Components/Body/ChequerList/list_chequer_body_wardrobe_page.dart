import 'package:flutter/material.dart';
import '../Chequer/chequer_body_wardrobe_page.dart';
import '../../../ViewModel/wardrobe_page_viewmodel.dart';
import '../Util/util_body.dart';
import '../../../../Config/config_chequer_position.dart';
import '../ChequerInit/init_chequer_body_wardrobe_page.dart';
import '../Chequer/dragcontroller_body_wardrobe_page.dart';

class ChequerList extends StatefulWidget {

  final int boxIndex;
  final int boxId;
  final WardrobePageViewModel viewModel;
  final BodyUtil bodyUtil;
  final AnimationController animationController;
  final DragController dragController;
    final AnimationController chequerMoveAnimationController;
  final Animation<double> chequerMoveAnimation;
  const ChequerList({ Key? key , required this.viewModel, required this.bodyUtil,
   required this.boxId,required this.animationController, required this.dragController,
    required this.boxIndex,required this.chequerMoveAnimation, required this.chequerMoveAnimationController}) : super(key: key);

  @override
  State<ChequerList> createState() => _ChequerListState();
}

class _ChequerListState extends State<ChequerList> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  ScrollController? controller;
  List<Widget> chequerList = [];

  bool _isInitedUtil = false;
  bool get isInitedUtil => _isInitedUtil;
  void setIsInitedUtil(bool i){
    _isInitedUtil = i;
  }

  double _widgetHeight = 0;
  double get widgetHeight => _widgetHeight;
  void setWidgetHeight(){
    _widgetHeight = 24 + maxColumn * (24 + ChequerPosition.boxWidth) + 100;
  }

  int _maxColumn = 0;
  int get maxColumn => _maxColumn;
  void setMaxColumn (int i){
    _maxColumn = i;
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    buildItemList();
    setWidgetHeight();
    //print('boxListinit');
    widget.bodyUtil.setFuncSubListRefreshChequer([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetIsInDrag([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetIsSpace([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetItemId([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetPosition([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetSortIndex([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetCurrentOffset([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetTargetOffset([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetStartOffset([], widget.boxId);
    widget.bodyUtil.setFuncSubListGetCurrentOffset([], widget.boxId);
    widget.bodyUtil.setFuncSubListGetSortIndex([], widget.boxId);
    widget.bodyUtil.setFuncSubListSetBoxId([], widget.boxId);
    widget.bodyUtil.setFuncSubListGetBoxId([], widget.boxId);
    /*widget.bodyUtil.setFuncSubListStartAnimation([], widget.boxId);
    widget.bodyUtil.setFuncSubListStopAnimation([], widget.boxId);
    widget.bodyUtil.setFuncSubListResetAnimation([], widget.boxId);*/

    //widget.bodyUtil.addRefreshListInBox(refreshUi);
    widget.bodyUtil.setSubRefreshListInBox(refreshUi, widget.boxId);
    widget.bodyUtil.setSubBoxListScrollControllers(controller!, widget.boxId);
    //
    //widget.bodyUtil.setChequerTargetOffsetByBoxNull(widget.boxId);
  }

 

  /*void buildItemList(){
    //print('buildItemList');
    widget.bodyUtil.setFuncRefreshChequer([]);
    widget.bodyUtil.setFuncSetIsInDrag([]);
    widget.bodyUtil.setFuncSetIsSpace([]);
    widget.bodyUtil.setFuncSetItemId([]);

    chequerList = [];
    int maxPosition = widget.bodyUtil.getMaxPosition(widget.boxId, widget.viewModel);
    setMaxColumn((maxPosition + 1) % 3 == 0? (maxPosition + 1) ~/3 : (maxPosition + 1) ~/ 3 + 1);
    Wardrobe wardrobe = widget.bodyUtil.sortItemPosition(widget.boxId, widget.viewModel);

    chequerList.add(const SizedBox(height: 24,));
    int index = 0;
    
    for(int i = 0 ; i <= maxColumn - 1 ; i++){

      List<Widget> rowTemp = [];

      for(int j = 0; j < 3 ; j ++){
        
        Item? item;
        for(int k = 0; k < wardrobe.items!.length; k++) {
          item = index == wardrobe.items![k].itemPosition? wardrobe.items![k]:null;
          if(item != null){
            break;
          }
        }
        Widget chequer ;

        //Widget chequer;
        if(item == null){
          //print( index);
          if(isInitedUtil){
            if(widget.bodyUtil.listSetIsSpace[widget.boxIndex].length - 1 >= index){
               widget.bodyUtil.listSetIsSpace[widget.boxIndex][index]!(true);
              widget.bodyUtil.listSetIsInDrag[widget.boxIndex][index]!(false);
            }
            
          }
          
          chequer = Chequer(
            //path: '', 
            boxId: widget.boxId,
            bodyUtil: widget.bodyUtil, 
            buildAnimationController: widget.animationController, 
            itemId: -1, 
            animation: 
            Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: 
                  Interval((0 / 200) * 1, 1.0,
                 //Interval(0, 1.0,
                    curve: Curves.fastOutSlowIn
                  )
                )
            )
          );
          rowTemp.add(chequer);
        }else{
          if(isInitedUtil){
            if(widget.bodyUtil.listSetIsSpace[widget.boxIndex].length - 1 >= index){
              widget.bodyUtil.listSetIsSpace[widget.boxIndex][index]!(false);
              widget.bodyUtil.listSetIsInDrag[widget.boxIndex][index]!(false);
            }
          }
          chequer = Chequer(
            
            path: item.itemImage, 
            boxId: widget.boxId,
            bodyUtil: widget.bodyUtil, 
            buildAnimationController: widget.animationController, 
            itemId: item.itemId!, 
            animation: 
            Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: 
                  Interval((0 / 200) * 1, 1.0,
                    curve: Curves.fastOutSlowIn
                  )
                )
            )
          );
          rowTemp.add(chequer);
        }
        if(j != 2){
          rowTemp.add(const SizedBox(width: 24,height: 24,));
        }
        
        index ++;
      }

      Widget row = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowTemp,
        );
      chequerList.add(row);
      chequerList.add(const SizedBox(height: 24,));
    }

  }*/


  void buildItemList(){
    //print('buildItemList');
    widget.bodyUtil.setFuncRefreshChequer([]);
    widget.bodyUtil.setFuncSetIsInDrag([]);
    widget.bodyUtil.setFuncSetIsSpace([]);
    widget.bodyUtil.setFuncSetItemId([]);
    chequerList = [];

    int maxPosition = widget.bodyUtil.getMaxPosition(widget.boxId, widget.viewModel);
    setMaxColumn((maxPosition + 1) % 3 == 0? (maxPosition + 1) ~/3 : (maxPosition + 1) ~/ 3 + 1);
    Wardrobe wardrobe = widget.bodyUtil.sortItemPosition(widget.boxId, widget.viewModel);

    int index = 0;
    
    for(int i = 0 ; i <= maxColumn - 1 ; i++){
      for(int j = 0; j < 3 ; j ++){
        Item? item;
        for(int k = 0; k < wardrobe.items!.length ; k++) {
          item = index == wardrobe.items![k].itemPosition? wardrobe.items![k]:null;
          if(item != null){
            break;
          }
        }
        Widget chequer ;
        if(item == null){
          if(isInitedUtil){
            if(widget.bodyUtil.listSetIsSpace[widget.boxId].length - 1 >= index){
              widget.bodyUtil.listSetIsSpace[widget.boxId][index]!(true);
              widget.bodyUtil.listSetIsInDrag[widget.boxId][index]!(false);
            }
          }
          chequer = ChequerInit(
            //isInDrag: widget.bodyUtil.allDragStatus == 0?false:true,
            chequerMoveAnimationController: widget.chequerMoveAnimationController,
            chequerMoveAnimation: widget.chequerMoveAnimation,
            dragController: widget.dragController,
            chequerIndex: index,
            startOffset: ChequerPosition.chequerOffset[index],
            targetOffset: ChequerPosition.chequerOffset[index],
            boxId: widget.boxId,
            bodyUtil: widget.bodyUtil, 
            buildAnimationController: widget.animationController, 
            itemId: -1, 
            buildAnimation: 
            Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: 
                  Interval((0 / 200) * 1, 1.0,
                    curve: Curves.fastOutSlowIn
                  )
                )
            )
          );
         // rowTemp.add(chequer);
         chequerList.add(chequer);
        }else{
          if(isInitedUtil){
            if(widget.bodyUtil.listSetIsSpace[widget.boxId].length - 1 >= index){
              widget.bodyUtil.listSetIsSpace[widget.boxId][index]!(false);
              widget.bodyUtil.listSetIsInDrag[widget.boxId][index]!(false);
            }
          }
          chequer = ChequerInit(
            //isInDrag: widget.bodyUtil.allDragStatus == 0? false: true,
            chequerMoveAnimationController: widget.chequerMoveAnimationController,
            chequerMoveAnimation: widget.chequerMoveAnimation,
            dragController: widget.dragController,
            chequerIndex: index,
            startOffset: ChequerPosition.chequerOffset[index],
            targetOffset: ChequerPosition.chequerOffset[index],
            path: item.itemImage, 
            boxId: widget.boxId,
            bodyUtil: widget.bodyUtil, 
            buildAnimationController: widget.animationController, 
            itemId: item.itemId!, 
            buildAnimation: 
            Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: 
                  Interval((0 / 200) * 1, 1.0,
                    curve: Curves.fastOutSlowIn
                  )
                )
            )
          );
          //rowTemp.add(chequer);
          chequerList.add(chequer);
        }
        index ++;
      }
    }
    
  }

  
  void refreshUi(){
    buildItemList();
    setWidgetHeight();
    if(mounted){
      setState(() {
      });
    }
    
  }

  


  @override
  Widget build(BuildContext context) {
    
    //print('sdddddd');
    super.build(context);
    
    
      WidgetsBinding.instance.addPostFrameCallback((e){
        //print(widget.boxId);
        //widget.bodyUtil.setFuncSubListRefreshChequer(widget.bodyUtil.refreshChequer, widget.boxId);
        //widget.bodyUtil.setFuncSubListSetIsInDrag(widget.bodyUtil.setIsInDrag, widget.boxId);
        //widget.bodyUtil.setFuncSubListSetIsSpace(widget.bodyUtil.setIsSpace, widget.boxId);
        //widget.bodyUtil.setFuncSubListSetItemId(widget.bodyUtil.setItemId, widget.boxId);
        setIsInitedUtil(true);
      });
    

    return Container(
      child: ListView(
        controller: controller,
        shrinkWrap: true,
        children: [SizedBox(
          height: widgetHeight,
          child: Stack(
            children:  chequerList,
          ),
        )],
      ),
    );


  }
}