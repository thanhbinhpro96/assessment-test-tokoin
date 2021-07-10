# TOKOIN Assessment News Application

This application is developed to serve as an assessment test for the position of Flutter developer.
The application is a news providing application. All data are fetched from https://newsapi.org/

## Getting Started

Before running the code, please kindly enter your API key for newsapi.org located at ***/lib/settings/const.dart***

This application consists of three tabs: **Headlines**, **News** and **Profile**

### 1) Headlines

This section demonstrate latest news from default region **us**. The news are paginated and each page is limited to 10 news item.
Scrolling to the bottom will trigger the application to load the next page.

Clicking on the news will navigate user to the news detail page.

### 2) News

This section shows news based on selected category. User can only choose one category at a time. *load more* feature is also available for this section.

Clicking on the news will navigate user to the news detail page.

### 3) Profile

This section allows user to register an account and login with their account. All accounts information is stored on local storage.

## Demo

![Screenshot](examples/demo.gif)
