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
- And in this private git repository;
- Is internationalized, available in English and French as "Bibliothèque";
- Is fully accessible to the visually impaired making use of Dynamic Type.

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
- No matter how long your name, the book's title, or any strings inputted at all, the book detail can handle it, because under the hood it is a static UITableView with dynamically sizing cells. I went with this approach because it gives me all the presentation properties I want without having to write any code, which means there are (hopefully) fewer bugs.

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