#Zthings_IOSAPP

##Intro
这是一个用GAE with Python 作为后台， 用iPhone App作为前端的架构。Zthings_IOSAPP.git 只是iPhone APP部分

GAE with Python的后端 是[Z IN THE DREAM](http://zinthedream.appspot.com), 源码可以在是[zths.git](http://github.com/mengfeng/zths.git)

##Progress
STILL IN THE PROCESS OF CODING

###宏观上的进度

现在只是完成了[ZDream](http://zinthedream.appspot.com/zdream 和 [ZPic](http://zinthedream.appspot.com/zpic)，还需要将 [ZThought](http://zinthedream.appspot.com/zthought)加进来

###技术上的进度

现在还只是基于Navigation Controller + TableViewController(MasterViewController+DetailViewController)
需要改成Tab Based Navigation Controller

现在的Code Structure 还是很混乱， 基本是每个Application 各自为证 还需要经过一次想我对[Z IN THE DREAM](http://github.com/mengfeng/zths.git)那样的一次大手术似的重构 

###完成的功能

* Fully Integrated with Google App Engine Backends using NSURLCONNECTION and JSON.
  * Load Remote JSON string to initialize TableView
    * NSJSONSERIALIZATION is used to handle all JSON related parses.
  * View Details
  * Add New Data Object
  * Remove New Data Object
  * Edit A Selected Data Object
    * Delegate and Protocol is used to implement this
  * Upload iOS Device Photos to Google App Engine as Blob


* Z Dreams is fully implemented
  * View Dreams
  * Edit Dreams
  * Add Dreams
  * Delete Dreams
  * Commit Changes to Server Side.
* Z Pic is fully implemented
  * View Images+Content
  * Edit Content
  * Select Photos from iOS Device Photo Library and Upload New Pics and Record down its description
  * Delete Z Pic posts.

###TO DOs
* Change the Navigation Controller based navigation to Tab Bar Controller based navigations.
* Add a nice UI Framework to replace the built-in controls.
* APP HTTP Authentication


