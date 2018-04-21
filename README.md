Library
=======

> "It seems that perfection is attained, not when there is nothing more to add, but when there is nothing more to take away."
>
> – [Antoine de Saint Exupéry](https://en.wikiquote.org/wiki/Antoine_de_Saint_Exupéry)

Library is a highly modularized, modern, best practice following, Swift 4 implementation of a system to keep track of who has which book from the SWAG committee's library. It is simple, but not stupid, and there is far more under the hood than its appearance betrays.

Requirements
------------

Library:

- Utilizes Swift 4;
- Is compatible with any iPhone or iPad in any configuration;
- Runs on iOS 10+;
- Includes this README, which will give you architecture and technical explanations;
- And is in this private git repository;
- Is internationalized, available in English and French as "Bibliothèque";
- Is fully accessible to the visually impaired, making use of Dynamic Type;
- Comes complete with a test suite for the URL building and JSON parsing components of the application.

Screens
-------

### Screen 1: `BooksViewController`

`BooksViewController` is the first view the user interacts with. It fetches books, lists them, and allows the user to press the `+` button to add a book. Tapping a book in the list goes to the detail screen. It it implemented with a table view and utilizes the default `UITableViewCell` in the title/subtitle style. The reason for this decision is that I believe the best code is always no code, and when you can avoid writing code, you should, because code invariably has bugs.

Notable features:

- Swipe to delete a book;
- Edit mode with multiple deletion, all deletion, multiple selection, all selection;
- In Settings, you can configure the sort to be newest or oldest first.
- The book list occupies the whole screen in compact width situations and a popover in regular width situations.

### Screen 2: `BookDetailViewController`

This screen provides detail about a book, allows the user to press checkout to take the book out of the library, and also to share the book on social media or at it to their reading list.

Notable features:

- The detail appears as a full screen push in compact width situations and on more than half of the screen in regular width situations;
- The modify button presents Screen 3 on the whole screen in compact width situations and a popover in regular width situations;
- The share button also presents as a popover or modal in different contexts;
- No matter how long your name, your Dynamic Type settings, the book's title, or any of the strings inputted for that matter, the book detail can handle your book and preferences, because under the hood it is a static `UITableView` with dynamically sizing cells with Dynamic Type enabled. I went with this approach because it gives me all the presentation properties I want without having to write any code, which means there are (hopefully) fewer bugs.

### Screen 3: `BookEditorViewController`

This screen is the form to add a new book. The title and author fields are required, and present challenges to the user if they do not enter those fields. Pressing done closes the screen and saves the book, and pressing cancel presents you with a challenge if you'd entered content because it will not be saved. It has its own `Error` object which presents the user with a localized error if there is any issue with their input. I am not sure I have found the best way of creating error objects, I really did find the process of making one unduly painful when it seems to me that `Error(reason:"")` really should be the baked in solution. Regardless, I got it to work and I'm happy with the error mechanism.

Notable features:

- The `BookEditorViewController` does double duty as the screen which lets you add a book and the screen which lets you edit a book. The reason it performs both tasks is that their essentially the same thing, with a few differences in behavior;
- Like the other screens, its presentation depends on the presentation context, on compact width presentations, it's a modal, on regular width, it's a pop-up, and on very wide presentations it's a popover.

Notes and other features
------------------------

- I am not a designer, but I do as a user and developer find the default aesthetic of iOS functional and beautiful. If you wanted to add some pizzaz to the presentation, a custom font and color tint would be more than enough for my tastes. I would do this, but that would require defining font sizes for Dynamic Type, which this application supports by virtue of it's use of the system font, so I see no need to change it.
- The application diverges from the wireframes in a couple aspects:
	- The "done" button in Screen 3 is submit, there is not submit button, and "Cancel" is found in the top left to allow the user to leave without saving. This was done because I think it's a more efficient use of space and requires less scrolling in the form, but it's largely a matter of opinion.
	- Next to the share button in Screen 2 I've placed the "Edit" button to be able to modify a book. I suspect this requirement was added without being in the wireframe as a bit of a "gotcha", which is good, you want careful readers. 
	- I've placed an "Edit" button in Screen 1 to allow multiple selection and deletion. There is an API for deleting all, `clean`, but there is not an API endpoint for deleting multiple books at once, which would be nice. I got around this by use of `DispatchGroups`, which are super useful and I suspect indistinguishable to the user, although they're admittedly quite dangerous in my opinion.
- There is a lie in the documentation! The date format is not `yyyy-MM-dd HH:mm:ss zzz`, it is `yyyy-MM-dd HH:mm:ss`. Another test for careful readers?

Architecture
------------

The application utilizes Apple's MVC in a fairly standard way, but with some important departures. From a high-level, the networking layer, the model layer, and the view and view controller layers are kept completely separate. The views and controllers depend on the model, but they do not depend on the networking layer, which could be easily swapped for another solution should that be necessary. 

I opted to modularize all the different layers of this application into distinct development Cocoapods, and I went with this approach to show how strict division of single responsibilities can enable re-use. The networking client, `CodableClient`, could be use by any application. The extensions found in `LibraryExtensions` could be developed into a private Cocoapod which could be used in all applications as a set of common use-cases.

### Views and view controllers

The views and view controller are in the application's main target, and they import the model target called `LibraryService`, which is implemented as a development Cocoapod. These files were kept purposefully succinct, because they're so often unruly. The `AppDelegate` is empty, and is kept out of necessity and as a place to put debug code if necessary. The view controllers themselves are all near enough to `UITableViewController`s, at least managing a table view in the case of `Books`. The routing is handled with `UIStoryboardSegues`, because the application is small enough that this resulted in productivity gains rather than the penalty suffered in larger apps, that might benefit from distinct `Router` objects.

Other than these files, there's a `UISplitViewController` subclass which I use to override some default behavior, and some `UserDefault` extensions to make accessing them easy. I use the `UISplitViewController` because it gives you extremely powerful behavior across device sizes basically for free, I really love the split view.

Ideas for improvement:

- Move away from using `UIStoryboardSegues`, or at least stop stringly-typing them;
- Try to make the management of the `UIBarButton` items a little smarter – I suspect many of the operations could be put into a function which accepts a `Bool` to toggle the various states, but in my first attempt to do that I screwed it up so I've settled with the ugliness because it's functional;
- UI tests would be cool! 

### `LibraryService`

The library service is the applications model layer, and contains a singleton which accepts requests from view controllers and manages the networking layer as a dependency.

The model includes just the `Book`, but also has a `BookProtocol` and some protocol extensions on it to give me some features not found by default. The serialization is handled completely by Swift's `Codable` language feature, because it's so easy to use.

The `LibraryService` itself is a singleton, which while I think the singleton is abused most of the time, I opted for it here for sake of expediency, and I think it works pretty well because the Service does not have any state of its own besides the reference to the client object.

Ideas for improvement:

- I'd really like to make the client and `URLSession` injectable so that the system could be tested, but in my first attempts to bring `URLSession` under a protocol ended up being so complicated and ugly I scrapped them. And the fact that the service itself has no state means there's little system to actually test, but for sake of completeness it would be cool.

### `CodableClient`

This is the networking layer of the applcation, and it is a piece of code I've been using to play with Swift's Codable and generics. It accepts a `URLSession` which would ideally be a protocol which `URLSession` conforms to, but regardless, this allows you to set your own configuration on the networking.

It's a fairly "clever" piece of code (as opposed to "obvious", which I much prefer as a virtue, but this is not an application that I'm developing on a team so I thought it was acceptable to tinker). I think the best was to explain how it works would be to start with the application's principal function definition:

```
func load<T : Codable>(_ path: URLConvertible, completion: @escaping (_ response: T?, _ error: Error?) -> Void)
```

It is genericized on a Type which conforms to Codable, accepts a parameter which can be converted into a URL (along with associated HTTP information), and informs you of completion by returning to you the type optionally you passed in, along with an error. What it does with this information is build a `URLRequest` and executes it, and attempts to convert it into the type you specified. If this does not work for whatever reason, like JSON mismatch or unavailble network, it sends you the error.

I would love to hear ideas on how to improve this code, because I've had it kicking around in Playgrounds in one way or another for a while now. I originally developed this system for a demonstration at a meetup.

### `LibraryExtensions`

The library service and view and view controllers share some extensions, and instead of duplicating these across targets (yuck!), I keep all my extensions in a shared place so they can better make use of them.

If there are any useful extensions you use I'd love to see them!

### `LibraryDebug`

This pod is stuff I used to develop the application. It contains a system to create an arbitrary amount of random books, and a LibraryService which mocks the real behavior. 

Ideas for improvement:

- I think the `DebugLibraryService` could be used as the mock to test the real Library Service.

Conclusion
----------

Thank you for your consideration and time in reading this report on the technical aspects of my submission. I tried my very best to develop it in as obvious way as possible, and I don't think there is a single line which is wasted. Considerable effort was devoted to developing this application compassionately with localization and accessibility, which are values that Apple espouses, and ones which I'm proud to share. And with the split view controller, many of the benefits of Apple's multiply sized applications are rendered to this application for free, which is something I'm always looking to cash in on. I hope you like it, and I look forward to discussing the topics contained here further.


