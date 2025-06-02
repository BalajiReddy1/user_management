# User Management App

A Flutter application that demonstrates a user management system integrated with the DummyJSON API. It features user search, infinite scrolling with pagination, detailed user views (including posts and todos), pull-to-refresh functionality, and local post creation—all managed with the BLoC pattern and designed with a consistent light (blue & white) and dark theme.

https://github.com/user-attachments/assets/d4b41121-078e-422e-a730-3039abe4553e


## Table of Contents

- [Features](#features)
- [Setup Instructions](#setup-instructions)
- [Project Overview](#project-overview)
- [Architecture Explanation](#architecture-explanation)
- [Contributing](#contributing)
- [License](#license)

## Features

- **API Integration:**  
  - Fetches users from [DummyJSON Users API](https://dummyjson.com/users) with limit/skip parameters.
  - Supports real-time search by user name.
  - Implements infinite scrolling for user listings.
  - Retrieves detailed data (posts and todos) for a selected user:
    - Posts: [`https://dummyjson.com/posts/user/{userId}`](https://dummyjson.com/posts/user/1)
    - Todos: [`https://dummyjson.com/todos/user/{userId}`](https://dummyjson.com/todos/user/1)

- **State Management:**
  - Uses the `flutter_bloc` package to handle loading, success, and error states.
  - Supports separate events for fetching, searching, and pagination.
  - Manages nested data fetching for posts and todos.

- **UI Features:**
  - **User List Screen:** Displays users with avatars, names, and emails.
  - **Search Bar:** Real-time search functionality at the top of the list.
  - **User Detail Screen:** Shows user information along with their posts and todos in tabbed views.
  - **Create Post Screen:** Allows users to add new posts locally (title and body) with immediate UI updates.
  - **Pull-to-Refresh:** Enables content refreshing with a swipe gesture.
  - **Theming:** Consistent light mode (blue & white) and a complementary dark mode.

- **Code Quality:**
  - Organized folder structure separating models, repositories, BLoC, screens, and widgets.
  - Implemented Flutter/Dart best practices with clean and readable code.
  - Handles edge cases and errors gracefully.

## Setup Instructions

1. **Prerequisites:**
   - [Flutter SDK](https://flutter.dev/docs/get-started/install) (Dart SDK comes with Flutter)
   - Code editor (e.g., Visual Studio Code, Android Studio)

2. **Clone the Repository:**
   ```bash
   git clone https://github.com/YourGitHubUsername/your-repo-name.git
   ```

## Project Overview

The User Management App is designed to showcase how to build a robust Flutter application with clean code architecture while integrating external APIs. It demonstrates:

**User Listing:** The app fetches a list of users from the DummyJSON API, supporting pagination and infinite scrolling. Users can search in real-time by name.

**Detail View:** On selecting a user, the app displays detailed information including their posts (with reaction counts and views) and todos.

**Local Updates:** Users can create posts locally through a dedicated screen, which instantly reflects in the UI.

**UI & UX Enhancements:** Pull-to-refresh and theming (light and dark mode) are implemented for an enhanced user experience.

## Architecture Explanation
The app is built following a layered architecture that promotes separation of concerns:

**Presentation Layer:**

Screens & Widgets: Handles user interfaces such as UserListScreen, UserDetailScreen, and CreatePostScreen. Custom widgets like UserTile provide reusable UI components.

Theming: Uses Flutter's ThemeData to provide consistent light and dark themes across the app.

**Business Logic Layer:**

BLoC Pattern: Utilizes the flutter_bloc package to manage state. Events (e.g., FetchUsers, SearchUsers) trigger state transitions (loading, success, error) while keeping UI components reactive.

Local State Management: For features like locally added posts and pull-to-refresh, state is managed and updated within the widget state as needed.

**Data Layer:**

Repositories: The UserRepository class encapsulates API calls (users, posts, todos) and abstracts data fetching from the UI.

Models: Data classes (User, Post, Todo) parse JSON responses and represent the API data structure.

This organization ensures that each layer focuses on its responsibilities, making the code highly maintainable, testable, and extendable.

## Contributing
```bash
Contributions, issues, and feature requests are welcome! If you'd like to contribute:
Fork the repository.
Create a new branch for your feature or bug fix.
Submit a pull request with detailed information on your changes.
```

 
