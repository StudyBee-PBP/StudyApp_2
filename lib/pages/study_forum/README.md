This README.md is used only to perform git push commands.

You can ignore this file.

discussion page problem: gak bisa memuat semua replies
fix:
- show_replies.dart: wrap the ListView.builder with expanded instead of container. The Expanded widget will make the ListView.builder widget area expanded so it have available space

- discussion.dart: 
When you change the ListView to a Column widget, it removes the scrollability of the entire content within the DiscussionPage.

In the original code with ListView, each child widget (such as SelectedPost and ShowReplies) is rendered within a scrollable viewport, allowing the user to scroll through the entire content if it exceeds the available screen space. However, this also means that each child widget within the ListView has its own scrolling behavior.

On the other hand, when you replace the ListView with a Column, all the child widgets are rendered in a single column layout without any inherent scrolling behavior. This means that if the content exceeds the available screen space, it will overflow and might not be fully visible to the user.


https://github.com/ally-commits/flutter-forum-ui.git --> post layout

https://stackoverflow.com/questions/51930754/flutter-wrapping-text --> content text wrapping

formatted date using intl library:
- https://api.flutter.dev/flutter/intl/DateFormat-class.html
- https://stackoverflow.com/questions/69492760/dateformat-parse-from-json 
- https://youtu.be/ca7_sAtexXY --> pop up menu button