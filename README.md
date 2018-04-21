Library
=======

> "It seems that perfection is attained, not when there is nothing more to add, but when there is nothing more to take away."
>
> – [Antoine de Saint Exupéry](https://en.wikiquote.org/wiki/Antoine_de_Saint_Exupéry)

Library is a highly modularized, modern, best practice following, Swift 4 implementation of a system to keep track of how has which book from the SWAG committee's library. It is simple, but not stupid, and there is far more under the hood than its appearance betrays.

Requirements
------------

Library:

- Utilizes Swift 4;
- Is compatible with any iPhone or iPad in any configuration;
- Runs on iOS 10+;
- Includes this README, which will give you architecture and technical explanations;
- And in this private git repo;
- Is internationalized, available in English and French as "Bibliothèque"

Screens
-------

### Screen 1: `BooksViewController`

`BooksViewController` is the first view the user interacts with. It fetches books, lists them, and allows the user press the `+` button to add a book. Tapping a book in the list goes to the detail screen. It it implemented with a table view and utilizes the default `UITableViewCell` in the title/subtitle style. The reason for this decision is that I believe the best code is always no code, and when you can avoid writing code, you should, because code invariably has bugs.

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
- No matter how long your name, the book's title, or any strings inputted at all, the book detail can handle it, because under the hood it is a static UITableView with dynamically sizing cells. I went with this approach because it gives me all the presentation properties I want without having to write any code, which means there are (hopefully) fewer bugs

### Screen 3: `BookEditorViewController`

The `BookEditorViewController` does double duty as the screen which lets you add a book and the screen which lets you edit a book. The reason it performs both tasks is that their essentially the same thing, with a few differences in behavior. It has its own Error object which presents the user with a localized error if there is any issue with their input. Like the other screens, it presents