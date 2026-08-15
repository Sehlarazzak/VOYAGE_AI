# ✈️ VoyageAI — AI Travel Companion

VoyageAI is an AI-powered travel planning application built with **Flutter** that helps users create personalized travel itineraries for destinations in Pakistan.

Users can enter their destination, budget, number of travellers, interests, and preferred travel style. VoyageAI then uses **Gemini AI** to generate a day-by-day travel plan with activities, food recommendations, estimated costs, travel tips, safety tips, and local insights.

## ✨ Features

* 🤖 **AI-Powered Itinerary Generation**

  * Generates personalized multi-day travel plans using Gemini AI.
  * Takes destination, budget, travellers, interests, and travel style into account.

* 🔄 **Itinerary Regeneration**

  * Regenerate the complete trip with new recommendations.
  * Regenerate a specific day based on a user's request.

* 🌤️ **Weather Information**

  * Retrieves destination location information and weather data.
  * Displays weather information alongside the generated itinerary.

* 📍 **Destination Information**

  * Uses location/geocoding services to identify destination details such as province and coordinates.

* 🖼️ **Destination Images**

  * Fetches destination images dynamically to enhance the itinerary experience.

* 💰 **Budget Breakdown**

  * Provides estimated costs for transportation, food, activities, accommodation, and shopping.

* 💡 **Travel Recommendations**

  * Includes travel tips, transport tips, safety tips, and insider/local recommendations.

* 🔐 **Firebase Integration**

  * Uses Firebase services for application functionality and user-related data.

## 🛠️ Technologies Used

| Technology               | Purpose                                          |
| ------------------------ | ------------------------------------------------ |
| Flutter                  | Cross-platform mobile application development    |
| Dart                     | Application programming language                 |
| Gemini AI                | AI-powered itinerary generation and regeneration |
| Firebase                 | Backend and application services                 |
| REST APIs                | External data integration                        |
| Weather API              | Destination weather information                  |
| Geocoding / Location API | Destination coordinates and location information |
| Unsplash API             | Destination images                               |
| Android Studio           | Android development and testing                  |
| VS Code                  | Development and debugging                        |

## 🏗️ Project Structure

```text
lib/
│
├── models/
│   ├── day_itinerary.dart
│   ├── destination.dart
│   ├── itinerary.dart
│   └── weather.dart
│
├── viewmodels/
│   ├── gemini_service.dart
│   ├── image_service.dart
│   ├── location_service.dart
│   ├── saved_trip_service.dart
│   └── weather_service.dart
│
├── views/
│   ├── generated_itinerary_screen.dart
│   ├── homescreen.dart
│   ├── loadingscreen.dart
│   ├── loginscreen.dart
│   ├── plantripscreen.dart
│   └── splashscreen.dart
│
└── widgets/
    ├── budget_breakdown.dart
    ├── day_itinerarycard.dart
    ├── itinerary_header.dart
    ├── traveltips_card.dart
    ├── weather_card.dart
    └── ...
```

## 🔄 How It Works

```text
User Input
    ↓
Destination + Budget + Interests + Travel Style
    ↓
Location & Weather Information
    ↓
Gemini AI
    ↓
Personalized Itinerary
    ↓
Day-by-Day Activities + Costs + Tips
    ↓
Generated Itinerary Screen
```

## 🤖 AI Itinerary Generation

VoyageAI uses Gemini to generate structured itinerary data in JSON format.

The generated response contains:

* Daily activities
* Morning, afternoon and evening plans
* Food recommendations
* Estimated costs
* Travel tips
* Transport tips
* Safety tips
* Insider tips

The JSON response is then converted into Dart model objects and displayed through custom Flutter widgets.

## 🔄 Smart Regeneration

VoyageAI also allows users to modify an existing itinerary.

Users can:

1. Regenerate the **whole trip** for completely different recommendations.
2. Regenerate a **specific day** while keeping the remaining days unchanged.
3. Provide a custom request such as:

   * "Make this a relaxing day"
   * "Add more adventure activities"
   * "Include more local food"
   * "Make this day budget-friendly"

## 🎨 UI & Design

The application includes a custom travel-focused interface with:

* Splash screen
* Login screen
* Home screen
* Trip planning form
* AI generation/loading screen
* Generated itinerary screen
* Destination image header
* Weather card
* Budget breakdown
* Day itinerary cards
* Travel tips
* Insider tips
* Regeneration interface

## 🔒 API & Firebase Configuration

Sensitive configuration files and API credentials are intentionally excluded from this repository.

If you want to run the project locally, you will need to configure your own:

* Firebase project
* Gemini AI access
* Weather API
* Image API

The required credentials should be added locally rather than committed to GitHub.

### Main Flow

**Plan Trip → Generate Itinerary → View Weather & Budget → Explore Daily Activities → Regenerate Trip/Day**

## 🚀 Future Improvements

Possible future improvements include:

* Real-time hotel and flight booking
* More accurate destination validation
* Improved handling of invalid destinations
* Saved and favorite trips
* Maps and route visualization
* User profiles and trip history
* Offline itinerary access
* More detailed cost estimation
* More travel APIs for real-time transportation information

## 👩‍💻 My Contribution

I worked on the **frontend and backend integration** of VoyageAI using Flutter and Dart.

My work included:

* Designing and implementing the application's UI
* Building reusable Flutter widgets
* Implementing navigation and application flow
* Integrating Gemini AI for itinerary generation
* Implementing itinerary regeneration
* Integrating location and weather services
* Integrating destination image services
* Creating Dart models for structured API/AI responses
* Implementing Firebase-related functionality
* Testing and debugging the application

## 📌 Project Status

**Completed functional prototype**

VoyageAI is currently a functional AI travel-planning application demonstrating personalized itinerary generation, external API integration, and itinerary regeneration.

---

### 👩‍💻 Developed by Sehla Razzak

Built with **Flutter + Dart + Gemini AI + Firebase**
