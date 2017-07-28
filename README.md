# AwesomeToDo iOS app
### by Veronika Hristozova - veronikahristozova@gmail.com


**Flow of the app:**
1. Main View containing UICollectionView with custom collection view cells
   - the custom cell contains UILabel for the title of the task, blurred view, UIImage view for the pin(green for completed task, red for pending task)
2. Selecting single cell navigates to Single Task View
3. Add New Task View


**Features:**
Instead of “swipe to delete” I decided to use Peek and Pop feature with actions (Complete and Delete) as it seemed more fancy and I had never implemented it so far. 
Force touch to preview, full force touch navigates to Task View. While in Peek and Pop mode swipe up to see actions. (As in Messenger app when deleting a conversation)
Core Data for persistence.
If Peek and Pop not available on the device I switch to Long Press Gesture Recognizer and action sheet with the same options (Mark as Complete and Delete).
If task is marked as Complete the pin image is replaced with green one.
Validation for text fields


**Features I did not managed to do:**
Settings View with actual settings - It is not clear what will be the local notifications for and if any available
Delete button in single task view - repetitive
Edit a task


Please let me know if the app should explicitly have “swipe to delete” option, local notifications, task date and I will make the changes.

_Total time spent: approx 7h_
