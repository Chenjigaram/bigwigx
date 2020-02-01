class Category {
  final String name;
  final String image;

  Category({this.name, this.image});

  static List<Category> getCategories(){
    Category history = Category(name:"History",image:"assets/categories/history.jpg");
    Category comics = Category(name:"Comics",image:"assets/categories/comics.jpg");
    Category children = Category(name:"Children",image:"assets/categories/children.jpg");
    Category classics = Category(name:"Classics",image:"assets/categories/classics.jpg");
    Category business = Category(name:"Business",image:"assets/categories/business.jpg");
    List<Category> categories = [history,comics,children,classics,business];
    return categories;
  }
}
