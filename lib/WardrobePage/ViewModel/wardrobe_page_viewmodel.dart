
import '../Data/data.dart' as data;
import '../Model/wardrobe_model.dart';

class Wardrobe{
  int? wardrobeId;
  int? sort;
  String? category;
  int? max;
  int? itemCount;
  List<Item>? items;
}

class Item{
   int? itemId;
   String? itemName;
   String? itemCateogry;
   String? itemImage;
   int? itemPosition;

}

class WardrobePageViewModel{

  List<Wardrobe> wardrobes = [];
 
  Future<int> refreshData() async{
    wardrobes = [];
    var qData = data.data;
    WardrobeModel model = WardrobeModel.fromJson(qData);
    for (var e in model.data.wardrobes) {
      Wardrobe w = Wardrobe();
      w.wardrobeId = int.tryParse(e.wardobesId)!;
      w.category = e.category;
      w.sort = int.tryParse(e.sort)!;
      w.itemCount = int.tryParse(e.itemCount)!;
      w.max = int.tryParse(e.max)!;
      w.items = [];
      for(var i in e.items){
        Item d = Item();
        d.itemId = int.tryParse(i.itemId);
        d.itemName = i.itemName;
        d.itemCateogry = i.itemCategory;
        d.itemPosition = int.tryParse(i.itemPosition);
        d.itemImage = i.itemImage;
        w.items!.add(d);
      }
      wardrobes.add(w);
    }
    sortWardrobes();
    return 1;
  }

  //对盒子进行排序
  void sortWardrobes()  {
    Wardrobe temp;
    for(int i = 0 ;i < wardrobes.length - 1 ; i++){
      for(int j = 0 ;j < wardrobes.length - 1 - i; j++){
        if(wardrobes[j].sort! > wardrobes[j + 1].sort!){
          temp = wardrobes[j];
          wardrobes[j] = wardrobes[j + 1];
          wardrobes[j + 1] = temp; 
        }
      }
    }
  }
  
  //修改某个盒子的排序字段，后期需要改成数据库操作 //目标id， 操作的id，目标位置
  void updateWardrobeSort ( int targetId, int controlId, int sort) async{
    Wardrobe boxTemp = Wardrobe();
    //这里需要修改成从数据库获取对象并修改sort字段
    //print(sort);
    //print('targetId--' + targetId.toString());
    //print('controlId--' + controlId.toString());
    //取出操作id的排序和目标排序进行对比
    for(Wardrobe w in wardrobes){
      if(w.wardrobeId == controlId){
        boxTemp = w;
        break;
      }
    }
    
    if(boxTemp.sort == sort){
      }else{
    for(Wardrobe b in wardrobes ){
      if(b.wardrobeId == controlId){
        //temp = w;
        //temp.sort = sort;
        for (Wardrobe t in wardrobes){
          if(t.wardrobeId == targetId){
            if(t.sort! > b.sort!){  //说明是向后拖动
              int curretnSortemp = b.sort!;
              b.sort = sort - 1;
              for(Wardrobe d in wardrobes){
                if(d.wardrobeId == b.wardrobeId){}else{ 
                  if(curretnSortemp  <= d.sort! && sort  > d.sort!){ //在拖动时的位置到达目标位置之间的元素排序都-1
                    d.sort = d.sort! - 1;
                  }else if( d.sort! > sort - 1){
                  //d.sort = d.sort! + 1;
                  }
                }
            
              }
            }else if(t.sort! < b.sort!){  //说明是向前拖动
              int curretnSortemp = b.sort!;
              b.sort = sort;
              for(Wardrobe d in wardrobes){
                if(d.wardrobeId == b.wardrobeId){}else{
                  if(curretnSortemp  > d.sort! && sort  <= d.sort!){ 
                    d.sort = d.sort! + 1;
                  }else if( d.sort! > sort - 1){
                  //d.sort = d.sort! + 1;
                  }
                }
              }
            }
          }
        }
        }
      }
    }
    sortWardrobes();
  }
  
}