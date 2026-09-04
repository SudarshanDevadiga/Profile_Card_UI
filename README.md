# Cloud-Native DevOps Profile Interface

A modern, responsive, and highly interactive profile screen built with Flutter. This project demonstrates advanced UI/UX principles tailored for a DevOps/Cloud Engineer persona, including staggered cascade animations, a continuous pulsing status indicator, dynamic theming (Slate Light/Dark mode), and isolated widget state for interactive components.

## 📸 Screenshots

### Light Mode

<img width="1470" height="956" alt="Screenshot 2026-09-05 at 2 10 11 AM" src="https://github.com/user-attachments/assets/73b5f09c-ac29-4a06-91d8-69a9b596ac1b" />


### Dark Mode (Oceanic/Slate Theme)

<img width="1470" height="956" alt="Screenshot 2026-09-05 at 2 10 07 AM" src="https://github.com/user-attachments/assets/328ffa73-3f29-4363-86e9-3fd2c2617d17" />


### Interactive State & Notifications

<img width="1470" height="956" alt="Screenshot 2026-09-05 at 2 10 32 AM" src="https://github.com/user-attachments/assets/3082b6d0-a645-4fa0-b61b-c761753bdc55" />

<img width="1470" height="956" alt="Screenshot 2026-09-05 at 2 10 14 AM" src="https://github.com/user-attachments/assets/2bee91f3-3f63-4322-b035-ac1d97317e18" />

---

## ✨ Key Features

* **Dynamic Theming (Oceanic/Slate):** Seamless toggle between Slate Light and Slate Dark modes managed at the root level, dynamically adjusting text, container surfaces, and bright Sky Blue accents.
* **Live Status Animation:** Features a continuous, looping pulse animation on the "System Online" indicator using a dedicated `AnimationController`.
* **Staggered Entrance Animations:** Premium load-in cascade effect upon screen load using `AnimationController` and `TickerProviderStateMixin`.
* **Responsive Layout:** Utilizes `LayoutBuilder` to adapt the UI structure seamlessly between mobile (stacked) and tablet/desktop (side-by-side) form factors.
* **Interactive Connect Button:** The 'Connect' button is an isolated `StatefulWidget` featuring touch-feedback scaling (`AnimatedScale`), smooth color morphing (`AnimatedContainer`), icon transitions (Rocket to Check), and functional `SnackBar` popup notifications.
* **Dynamic Tech Stack Chips:** A responsive `Wrap` widget dynamically displaying technical skills (AWS, Kubernetes, Docker, etc.) as styled chips.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** Dart
* **Core Libraries:** `material.dart`

## 📂 Project Structure

The codebase is kept modular and clean, divided into two primary files:

```text
lib/
├── main.dart             # App entry point, Slate Theme configuration, and root MaterialApp
└── profile_screen.dart   # Core UI layout, complex animations, Tech Chips, and interactive widget classes
