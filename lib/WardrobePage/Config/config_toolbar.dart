
class ToolBarConfig{
  
  static String iconMapping(String category){
        switch (category){
      case '上装' : 
        return 'assets/icons/clothesCategory/女上装.svg';
      case '下装':
        return 'assets/icons/clothesCategory/女下装.svg';
      case '鞋子':
        return 'assets/icons/clothesCategory/女鞋.svg';
      case '包包':
        return 'assets/icons/clothesCategory/女包.svg';      
      case '配饰':
        return 'assets/icons/clothesCategory/配饰.svg';    
      default:
        return 'assets/icons/clothesCategory/女上装.svg';
    }
  }
  


}