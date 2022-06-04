# TvMaze - TvShows

A Tv Shows app built on Flutter with LocalStorage and API calls 

Flutter 3.0.1
Dart 2.17.1
## Getting Started
**Note:** Make sure your Flutter environment is setup with null-safety.

##### Check out Flutter’s online [documentation](https://docs.flutter.dev/) for help getting start with your Flutter project.

### Instalation

In the command terminal, run the following commands:

    $ git clone https://github.com/96rdca/TvSeries_App.git TvSeriesApp
    $ cd TvSeriesApp/
    $ flutter pub get
    $ flutter run

# Simulate for Android

    Make sure you have an Android emulator installed and running.
    Run the following command in your terminal.
    $ flutter run

# Simulate for iOS

    Run the following command in your terminal.
    $ open -a Simulator
    $ flutter run

# Completed Features

## REQUIREMENTS

* List all of the series contained in the API used by the paging scheme provided by the API.

* After clicking on a series, the application should show the details of the series, showing the following information:
    * Name
    * Poster
    * Genres
    * Summary
    * Days and time during which the series airs
    * List of episodes separated by season

		
* After clicking on an episode, the application should show the episode’s information, including:
	* Name
	* Number
	* Season
	* Summary
	* Image, if there is one

						
* Allow users to search series by name.
* The listing and search views must show at least the name and poster image of the series.

## BONUS

* Create a people search by listing the name and image of the person.
* After clicking on a person, the application should show the details of that person, such as:
	* Name
	* Image
	* Series they have participated in, with a link to the series details.
    
	
* Allow the user to save a series as a favorite.
* Allow the user to delete a series from the favorites list.
* Allow the user to browse their favorite series in alphabetical order, and click on one to see its details.
* Allow the user to set a PIN number to secure the application and prevent unauthorized users.
* For supported phones, the user must be able to choose if they want to enable fingerprint authentication to avoid typing the PIN number while opening the app.