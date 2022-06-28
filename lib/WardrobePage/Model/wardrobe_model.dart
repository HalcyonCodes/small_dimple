

class WardrobeModel{
  late String message;
  late String code;
  late WardrobeModelData data;

  WardrobeModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    code = json['code'];
    if(json['data'] != null){
      data = WardrobeModelData.fromJson(json['data']);
    }
  }

}



class WardrobeModelData{

  late List<WardrobeModelWardrobe> wardrobes;

  WardrobeModelData.fromJson(Map<String, dynamic> json){
    wardrobes = [];
    if(json['wardrobes'] != null){
      wardrobes = [];
      json['wardrobes'].forEach((e){
         WardrobeModelWardrobe wardrobe = WardrobeModelWardrobe.fromJson(e);
         wardrobes.add(wardrobe);
      });
    }
  }

}


class WardrobeModelWardrobe{

  late String sort;
  late String category;
  late String wardobesId;
  late String max;
  late String itemCount;
  late List<WardrobeModelItem> items;

  WardrobeModelWardrobe.fromJson(Map<String, dynamic> json){
    sort = json['sort'];
    category = json['category'];
    wardobesId = json['wardobesId'];
    max = json['max'];
    itemCount = json['itemCount'];
    items = [];
     if(json['items'] != null){
      json['items'].forEach((e){
         WardrobeModelItem item = WardrobeModelItem.fromJson(e);
         items.add(item);
      });

    }
    
  }

}



class WardrobeModelItem{
  late String itemId;
  late String itemName;
  late String itemCategory;
  late String itemPosition;
  late String itemImage;
  

  WardrobeModelItem.fromJson(Map<String, dynamic> json){
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemCategory = json['itemCategory'];
    itemPosition = json['itemPosition'];
    itemImage = json['itemImage'];

  }


}