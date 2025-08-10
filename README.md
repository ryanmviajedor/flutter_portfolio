# 🚀 Flutter Portfolio Website

A modern, responsive portfolio website built with Flutter Web featuring smooth animations, interactive components, and a professional design.

## 📸 Screenshots

### Desktop View
![Portfolio Desktop](screenshots/desktop-hero.png)
*Hero section with gradient text and smooth animations*

![Skills Section](screenshots/desktop-skills.png)
*Interactive skills section with tabbed interface*

### Mobile View
![Portfolio Mobile](screenshots/mobile-view.png)
*Responsive mobile design with optimized layouts*

## ✨ Features

### 🎨 **Modern Design**
- **Purple-blue gradient theme** (#667eea → #764ba2)
- **Smooth animations** and transitions
- **Hover effects** on interactive elements
- **Professional typography** with Inter font

### 📱 **Responsive Layout**
- **Mobile-first design** approach
- **Adaptive layouts** for all screen sizes
- **Touch-friendly** mobile interactions
- **Optimized performance** across devices

### 🎯 **Interactive Sections**

#### **Hero Section**
- Animated introduction with gradient text
- Social media links with hover effects
- Call-to-action buttons (Download CV, Contact)
- Animated background shapes

#### **About Section**
- Dual-card layout ("Who am I?" & "My Journey")
- Animated statistics counters
- Services grid with hover animations
- Professional presentation of background

#### **Skills Section**
- **Tabbed interface** (Frontend, Backend, Tools)
- **24 skills** with detailed descriptions
- **Responsive grid layout** (4→3→2→1 columns)
- **Mobile-optimized** horizontal card design

#### **Projects Section**
- Portfolio showcase with project cards
- Technology stack highlights
- Project links and demos
- Responsive grid layout

#### **Contact Section**
- Contact information with hover effects
- Social media integration
- Professional contact presentation
- Responsive design

## 🛠️ Technologies Used

### **Frontend**
- **Flutter Web** - Cross-platform framework
- **Dart** - Programming language
- **Material Design** - UI components
- **Custom Animations** - Smooth transitions

### **Design**
- **Responsive Design** - Mobile-first approach
- **CSS Grid/Flexbox** equivalent layouts
- **Custom Theme System** - Consistent styling
- **Hover Effects** - Interactive feedback

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Web browser (Chrome, Firefox, Safari, Edge)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ryanmviajedor/flutter_portfolio.git
   cd flutter_portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome --web-port=8080
   ```

4. **Open in browser**
   ```
   http://localhost:8080
   ```

### Building for Production

```bash
# Build for web
flutter build web

# The built files will be in build/web/
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── src/
│   ├── app.dart             # Main app configuration
│   ├── theme.dart           # Theme and color definitions
│   ├── screens/
│   │   └── home_screen.dart # Main portfolio screen
│   └── widgets/
│       ├── hero_section.dart      # Landing section
│       ├── about_section.dart     # About me section
│       ├── skills_section.dart    # Skills with tabs
│       ├── projects_section.dart  # Projects showcase
│       ├── contact_section.dart   # Contact information
│       ├── nav_bar.dart           # Navigation bar
│       └── footer.dart            # Footer component
```

## 🎨 Customization

### **Colors & Theme**
Edit `lib/src/theme.dart` to customize the color scheme:
```dart
class AppColors {
  static const primaryGradient = [Color(0xFF667eea), Color(0xFF764ba2)];
  static const primary = Color(0xFF667eea);
  // ... other colors
}
```

### **Content**
Update personal information in each section widget:
- **Hero Section**: `lib/src/widgets/hero_section.dart`
- **About Section**: `lib/src/widgets/about_section.dart`
- **Skills**: `lib/src/widgets/skills_section.dart`
- **Projects**: `lib/src/widgets/projects_section.dart`
- **Contact**: `lib/src/widgets/contact_section.dart`

## 📱 Responsive Breakpoints

- **Mobile**: ≤ 600px (Single column, horizontal cards)
- **Tablet**: 601px - 900px (2-3 columns)
- **Desktop**: 901px - 1200px (3-4 columns)
- **Large Desktop**: > 1200px (4+ columns)

## 🌐 Deployment

### **GitHub Pages**
1. Enable GitHub Pages in repository settings
2. Build the project: `flutter build web`
3. Deploy the `build/web` folder

### **Netlify**
1. Connect your GitHub repository
2. Set build command: `flutter build web`
3. Set publish directory: `build/web`

### **Vercel**
1. Import your GitHub repository
2. Framework preset: Other
3. Build command: `flutter build web`
4. Output directory: `build/web`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ryan Viajedor**
- GitHub: [@ryanmviajedor](https://github.com/ryanmviajedor)
- Email: ryanmoradasviajedor@gmail.com

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## ⭐ Show your support

Give a ⭐️ if this project helped you!

---

*Built with ❤️ using Flutter*
